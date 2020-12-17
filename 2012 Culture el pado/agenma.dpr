program agenma;

uses
  Windows
  ,Messages
  ,OpenGL
  ,Bass
  ,scene
  ,initscenes
  ,sysutils
  ,textures
  ,particle
  ;

const
  WND_TITLE = 'SCRIMERS_';
  FPS_TIMER = 10;                    // Timer to calculate FPS
  FPS_INTERVAL = 100;               // Calculate FPS every 1000 ms


var {
  h_Wnd  : HWND;                     // Global window handle
  h_DC   : HDC;                      // Global device context
  h_RC   : HGLRC;                    // OpenGL rendering context   }

  keys_:boolean;
  finished : Boolean = False;

  //setup window
  Width  : Integer = 1024; //1024  // 1280 // 800  // 600
  Height : Integer = 768; //768   // 1024 // 600  // 480
  PixelDepth : Integer = 16; //24 //16 //32
  FullScreen : Boolean = false;

  //BASS Sound
  Stream   : HSTREAM;
  BassInit : Boolean;

  TimeOffset : Integer = 000;

//{$R jpg.RES} //_e

{------------------------------------------------------------------}
{  Function to draw the actual scene                               }
{------------------------------------------------------------------}
var i:integer;

procedure glDraw();
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);    // Clear The Screen And The Depth Buffer
  glLoadIdentity();

  case Stage of
    0 : begin
         //InitLoadScreen;

         ShowLoad;
         Inc(Stage);
         InitLoadData;
         //Inc(Stage);
    end;
    1 : begin
          //Initialize
          if Progress > 7
            then glInterleavedArrays (GL_C3F_V3F, 0, @intertwined);
          //Inc(Stage);
          ShowLoad;
          //glClearAccum(1.0, 1.0, 1.0, 1.0);
//          glClear(GL_ACCUM_BUFFER_BIT);
        end;
    2 :{ Stage :=3 see down of code (540str)} ;                   // Used to init and start Bass sound in main loop
    3 : begin
         SceneStreet;
         //glTranslatef(xx_x, xx_y,xx_z);
    end;
    4 : begin  //17sec
         SceneStreetCar
    end;
    5 : begin   //25.5sec
         SceneStreetMan
    end;
    6 : begin   //39sec
         SceneStage;
    end;
    7 : begin   // 50sec
         ScenePokerGame;
         glTranslatef(505, 0,-65);
         SceneSmoketube;

         ShowMovie;
    end;
    8 : begin   //60sec
         ShowPokerTable;
         ShowPokerLight;

         ShowMovie;
         if ElapsedTime < 62000 then begin
          glDepthMask(GL_FALSE);
          glColor4f(1, 1, 1, (62000 - ElapsedTime) * 0.001);
          glBindTexture(GL_TEXTURE_2D, array_text[16]);
          glBegin(GL_POLYGON);
          glTexCoord2f(0.0, 0.0); glVertex3f(-200.0, -200.0, -25);
          glTexCoord2f(1.0, 0.0); glVertex3f( 200.0, -200.0, -25);
          glTexCoord2f(1.0, 1.0); glVertex3f( 200.0,  200.0, -25);
          glTexCoord2f(0.0, 1.0); glVertex3f(-200.0,  200.0, -25);
          glEnd;
          glDepthMask(GL_TRUE);
         end else begin
            //PointsCount := count[0];
            Inc(Stage);
         end;
    end;
    9 : begin     // 1:02    //joker
         ShowPokerTable;
         ShowPokerLight;

         glDisable(GL_TEXTURE_2D);
         glTranslatef(3,-1,-15);
         if ElapsedTime < 77000                                 //67
            then PointsCount := Trunc((ElapsedTime-62000)*0.061);   //0.183
         glPointSize(6);
         //glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
         glTranslatef(0.1, 0.05, 0.25);
         glDrawArrays (GL_POINTS, 0, PointsCount);

         glPointSize(4);
         //glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
         glDrawArrays (GL_POINTS, 0, PointsCount);

         glEnable(GL_TEXTURE_2D);

         ShowMovie;

         glAccum(GL_MULT, 0.9);
         glAccum(GL_ACCUM, 1-0.9);
         glAccum(GL_RETURN, 1);

         if ElapsedTime > 79000 then begin
            //PointsCount := count[1];
            //PointsCount1 := count[2];
            Inc(Stage);
         end;
    end;
    10 : begin     // 1:19     //karts
         ShowPokerTable;
         ShowPokerLight;

         glDisable(GL_TEXTURE_2D);
         glTranslatef(10,0,-15);

         if ElapsedTime < 82000
            then begin
               PointsCount := Trunc((ElapsedTime-79000)*0.077);
            end;
         if ElapsedTime < 95000
         then begin
            xx_x := (ElapsedTime-89000)*0.002;
            glTranslatef(0, -xx_x ,-xx_x*0.1);
         end else begin
            Inc(Stage);
         end;

         //glColor3f(1, 1, 1);

         glPointSize(3);
         glDrawArrays (GL_POINTS, count[0], PointsCount);
            glTranslatef(7, -0.5, -7);
            glRotatef(35,0,0,1);
         glDrawArrays (GL_POINTS, count[0], PointsCount);
            glTranslatef(-16, 3.5, 0);
            glRotatef(180,0,0,1);
         glDrawArrays (GL_POINTS, count[0], PointsCount);
            glTranslatef(1.55, -33, -5.35);
            glRotatef(180,0,0,1);
         glDrawArrays (GL_POINTS, count[0], PointsCount);
            glTranslatef(38, -10, -1);
         glDrawArrays (GL_POINTS, count[0], PointsCount);
            glTranslatef(-57, -27, 0);
         glDrawArrays (GL_POINTS, count[0], PointsCount);

         glEnable(GL_TEXTURE_2D);

         ShowMovie;

         glAccum(GL_MULT, 0.9);
         glAccum(GL_ACCUM, 1-0.9);
         glAccum(GL_RETURN, 1); 
    end;

    11 : begin     // 1:35       //cvetki
         ShowPokerTable;
         ShowPokerLight;

         glDisable(GL_TEXTURE_2D);
         glTranslatef(0,0,-15);

         if ElapsedTime < 98000
            then begin
               PointsCount := Trunc((ElapsedTime-95000)*0.1156);
               PointsCount1 := Trunc((ElapsedTime-95000)*0.063);
            end;

         glPointSize(3);
         glDrawArrays (GL_POINTS, count[0]+count[1], PointsCount);
         glTranslatef(4.55,0,0);
         glDrawArrays (GL_POINTS, count[0]+count[1]+count[2], PointsCount1);
         glTranslatef(-10, 0,0);
         glDrawArrays (GL_POINTS, count[0]+count[1]+count[2], PointsCount1);
         glTranslatef(-10, -10, -10);
         glDrawArrays (GL_POINTS, count[0]+count[1]+count[2], PointsCount1);
         glTranslatef(30, 3, 5);
         glDrawArrays (GL_POINTS, count[0]+count[1]+count[2], PointsCount1);
         glEnable(GL_TEXTURE_2D);

         ShowMovie;

         glAccum(GL_MULT, 0.9);
         glAccum(GL_ACCUM, 1-0.9);
         glAccum(GL_RETURN, 1);

         if ElapsedTime > 102000 then begin
            glPointSize(4);
            Inc(Stage);
         end; 
    end;
    12:begin   //1:42       //goroda
         //ShowPokerTable;
         //ShowPokerLight;
         glDisable(GL_TEXTURE_2D);
         glTranslatef(-1,-5,-15);
         if ElapsedTime < 117000 then begin
            PointsCount := Trunc((ElapsedTime-102000)*0.10); //0.1503
         end;
            glDrawArrays (GL_POINTS, count[0]+count[1]+count[2]+count[3], PointsCount);
            //glTranslatef(2,2,-1);   :(
            //glDrawArrays (GL_POINTS, count[0]+count[1]+count[2]+count[3]+count[4]+count[5]+count[6]+count[7], PointsCount-(count[0]+count[1]+count[2]+count[3]+count[4]+count[5]+count[6]+count[7]) );

         glEnable(GL_TEXTURE_2D);
         ShowMovie;
         glAccum(GL_MULT, 0.9);
         glAccum(GL_ACCUM, 1-0.9);
         glAccum(GL_RETURN, 1);
         if ElapsedTime > 121000 then begin
            Inc(Stage);
            glEnable(GL_FOG);
            glFogf(GL_FOG_START, 17.0);
            glFogf(GL_FOG_END, 28.0);
            glFogf(GL_FOG_MODE, GL_LINEAR);
            glFogf(GL_FOG_DENSITY, 0.2); // плотность тумана
         end;
    end;
    13:begin   //2:01   //quest
         //ShowPokerTable;
         //ShowPokerLight;
         glDisable(GL_TEXTURE_2D);
         glTranslatef(0,-7,-15);
         if ElapsedTime < 129000 then begin
            PointsCount := Trunc((ElapsedTime-121000)*0.0677); //0.1084
         end;
         glDrawArrays (GL_POINTS, count[0]+count[1]+count[2]+count[3]+count[4]+count[5]+count[6]+count[7]+count[8]+count[9]+count[10]+count[11]+count[12], PointsCount); //design mode
         glEnable(GL_TEXTURE_2D);

         ShowMovie;
         glAccum(GL_MULT, 0.9);
         glAccum(GL_ACCUM, 1-0.9);
         glAccum(GL_RETURN, 1);
         if ElapsedTime > 135000 then begin
            Inc(Stage);
         end;
    end;

    14:begin   //2:15      //man
         //ShowPokerTable;
         //ShowPokerLight;
         glDisable(GL_TEXTURE_2D);
         glTranslatef(0,0,-15);
         if ElapsedTime < 140000 then begin
            PointsCount := Trunc((ElapsedTime-135000)*0.1037);
         end;

         if ElapsedTime < 142000 then begin
            PointsCount1 := Trunc((ElapsedTime-140000)*0.09);
            for i:=0 to 11 do begin
               glRotatef(30, 1,0,0);
               glDrawArrays (GL_POINTS, count[0]+count[1]+count[2]+count[3]+count[4]+count[5]+count[6]+count[7]+count[8]+count[9]+count[10]+count[11], PointsCount1);
            end;
         end;
         if (ElapsedTime < 166000)and(ElapsedTime > 142000) then begin
            glRotatef((ElapsedTime-142000)*0.02, 1,1,0);
            for i:=0 to 11 do begin
               glRotatef(30, 1,0,0);
               glDrawArrays (GL_POINTS, count[0]+count[1]+count[2]+count[3]+count[4]+count[5]+count[6]+count[7]+count[8]+count[9]+count[10]+count[11], PointsCount1);
            end;
         end;
         if (ElapsedTime > 166000) then begin
            glDisable(GL_FOG);
            Inc(Stage);
            glDisable(GL_TEXTURE_2D);
         end;

         glDrawArrays (GL_POINTS, count[0]+count[1]+count[2]+count[3]+count[4]+count[5]+count[6]+count[7]+count[8]+count[9]+count[10], PointsCount);

         glEnable(GL_TEXTURE_2D);

         ShowMovie;
         glAccum(GL_MULT, 0.9);
         glAccum(GL_ACCUM, 1-0.9);
         glAccum(GL_RETURN, 1);


         if ElapsedTime > 162000 then begin
            glColor4f(0, 0, 0, (ElapsedTime - 162000)*0.00025);
            glBegin(GL_POLYGON);
            glTexCoord2f(0.0, 0.0);glVertex3f(-130.0, -101.0, -54);
            glTexCoord2f(0.1, 0.0);glVertex3f( 126.0, -101.0, -54);
            glTexCoord2f(0.1, 0.1);glVertex3f( 126.0,  91.0,  -54);
            glTexCoord2f(0.0, 0.1);glVertex3f(-130.0,  91.0,  -54);
            glEnd;
         end;
    end;
    15:begin   //2:      //grettings
                 glColor3f(1, 1, 1);  glTranslatef(-90, -140, -200);
                 glBindTexture(GL_TEXTURE_2D, array_text[26]);
                 glBegin(GL_POLYGON);
                  glTexCoord2f(0.0, 0.0); glVertex3f( 0.0,   0.0,  0.0);
                  glTexCoord2f(1.0, 0.0); glVertex3f( 188.0, 0.0,  0.0);
                  glTexCoord2f(1.0, 1.0); glVertex3f( 188.0, 280.0, 0.0);
                  glTexCoord2f(0.0, 1.0); glVertex3f( 0.0,   280.0, 0.0);
                 glEnd;
         glAccum(GL_MULT, 0.9);
         glAccum(GL_ACCUM, 1-0.9);
         glAccum(GL_RETURN, 1);
         if (ElapsedTime > 186000) then begin
            Inc(Stage);
         end;
         glLoadIdentity();
         if ElapsedTime < 170000 then begin
            glColor4f(0, 0, 0, 1 - (ElapsedTime - 166000)*0.00025);
            glBegin(GL_POLYGON);
            glTexCoord2f(0.0, 0.0);glVertex3f(-130.0, -101.0, -54);
            glTexCoord2f(0.1, 0.0);glVertex3f( 126.0, -101.0, -54);
            glTexCoord2f(0.1, 0.1);glVertex3f( 126.0,  91.0,  -54);
            glTexCoord2f(0.0, 0.1);glVertex3f(-130.0,  91.0,  -54);
            glEnd;
         end;

    end;
    16:begin
      finished := True ;
    end;
  end;

 {
  glDisable(GL_TEXTURE_2D);

  glBegin(GL_LINEs);
   glColor3f(1,0,0);
   glVertex3f(0,0,0);
   glVertex3f(20,0,0);
   Glcolor3f(0,1,0);
   glVertex3f(0,0,0);
   glVertex3f(0,20,0);
   Glcolor3f(0,0,1);
   glVertex3f(0,0,0);
   glVertex3f(0,0,20);
  glend;

   glEnable(GL_TEXTURE_2D);
                   }
  glFlush;

end;

{------------------------------------------------------------------}
{  Handle window resize                                            }
{------------------------------------------------------------------}
procedure glResizeWnd(Width, Height : Integer);
begin
{}
  if (Height = 0) then                // prevent divide by zero exception
    Height := 1;

  glViewport(0, 0, Width, Height);    // Set the viewport for the OpenGL window
  glMatrixMode(GL_PROJECTION);        // Change Matrix Mode to Projection
  glLoadIdentity();                   // Reset View
  gluPerspective(120.0, Width/Height, 0.1, 10000.0);  // Do the perspective calculations. Last value = max clipping depth
  glMatrixMode(GL_MODELVIEW);         // Return to the modelview matrix
  glLoadIdentity();                   // Reset View

  glClearAccum(1.0, 1.0, 1.0, 1.0);
  glClear(GL_ACCUM_BUFFER_BIT);    
{
  if (Height = 0) then                // prevent divide by zero exception
    Height := 1;

  glViewport(0, 0, Width, Height);    // Set the viewport for the OpenGL window
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  glOrtho (0.0, Width, 0.0, Height, -1.0, 1.0);
  glMatrixMode(GL_MODELVIEW);
 {}

end;

{------------------------------------------------------------------}
{  Determines the applicationТs response to the messages received  }
{------------------------------------------------------------------}
function WndProc(hWnd: HWND; Msg: UINT;  wParam: WPARAM;  lParam: LPARAM): LRESULT; stdcall;
var
   i:Word;
   f : TextFile;
begin
  case (Msg) of
    WM_CLOSE:
      begin
        PostQuitMessage(0);
        Result := 0
      end;
    WM_KEYDOWN:       // Set the pressed key (wparam) to equal true so we can check if its pressed
      begin
        if wParam=VK_ESCAPE then keys_ := True;
                         (*
        if wParam=VK_RIGHT then xx_x := xx_x + 1.0;
        if wParam=VK_UP then xx_y := xx_y + 1.0;
        if wParam=VK_INSERT then xx_z := xx_z + 1.0;

        if wParam=VK_LEFT then xx_x := xx_x - 1.0;
        if wParam=VK_DOWN then xx_y := xx_y - 1.0;
        if wParam=VK_DELETE then xx_z := xx_z - 1.0;
                          {
        if wParam=VK_RIGHT then xx_x := xx_x     + 0.05;
        if wParam=VK_UP then xx_y := xx_y        + 0.05;
        if wParam=VK_INSERT then xx_z := xx_z    + 0.05;

        if wParam=VK_LEFT then xx_x := xx_x      - 0.05;
        if wParam=VK_DOWN then xx_y := xx_y      - 0.05;
        if wParam=VK_DELETE then xx_z := xx_z    - 0.05;
                                }

        if wParam = VK_RETURN then begin
            //color
            intertwined[PartyIndex*6  ] := cc_r;
            intertwined[PartyIndex*6+1] := cc_g;
            intertwined[PartyIndex*6+2] := cc_b;
            //coords    for create mode
            intertwined[PartyIndex*6+3] := xx_x;
            intertwined[PartyIndex*6+4] := xx_y;
            intertwined[PartyIndex*6+5] := xx_z;

            PartyIndex := PartyIndex + 1; //for create mode  }
            
            glInterleavedArrays (GL_C3F_V3F, 0, @intertwined);
        end;
        //t
        if wParam = $54 then begin
            //color
            intertwined[PartyIndex*6  ] := cc_r;
            intertwined[PartyIndex*6+1] := cc_g;
            intertwined[PartyIndex*6+2] := cc_b;
            glInterleavedArrays (GL_C3F_V3F, 0, @intertwined);
        end;


        //o
        if wParam = $50 then begin
         PartyIndex := PartyIndex + 1;
           xx_x := intertwined[PartyIndex*6+3];
           xx_y := intertwined[PartyIndex*6+4];
           xx_z := intertwined[PartyIndex*6+5];
        end;
        //p
        if wParam = $4F then begin
         PartyIndex := PartyIndex - 1;
         if PartyIndex < 0 then PartyIndex := 0;
           xx_x := intertwined[PartyIndex*6+3];
           xx_y := intertwined[PartyIndex*6+4];
           xx_z := intertwined[PartyIndex*6+5];
        end;

        //q
        if wParam=$51 then begin
         cc_r := cc_r + 0.05;
         intertwined[PartyIndex*6  ] := cc_r;
         intertwined[PartyIndex*6+1] := cc_g;
         intertwined[PartyIndex*6+2] := cc_b;
         glInterleavedArrays (GL_C3F_V3F, 0, @intertwined);
        end;
        //w
        if wParam=$57 then begin
         cc_g := cc_g + 0.05;
         intertwined[PartyIndex*6  ] := cc_r;
         intertwined[PartyIndex*6+1] := cc_g;
         intertwined[PartyIndex*6+2] := cc_b;
         glInterleavedArrays (GL_C3F_V3F, 0, @intertwined);
        end;
        //e
        if wParam=$45 then begin
         cc_b := cc_b + 0.05;
         intertwined[PartyIndex*6  ] := cc_r;
         intertwined[PartyIndex*6+1] := cc_g;
         intertwined[PartyIndex*6+2] := cc_b;
         glInterleavedArrays (GL_C3F_V3F, 0, @intertwined);
        end;
        //a
        if wParam=$41 then begin
         cc_r := cc_r - 0.05;//1.0;
         intertwined[PartyIndex*6  ] := cc_r;
         intertwined[PartyIndex*6+1] := cc_g;
         intertwined[PartyIndex*6+2] := cc_b;
         glInterleavedArrays (GL_C3F_V3F, 0, @intertwined);
        end;
        //s
        if wParam=83 then begin
         cc_g := cc_g  - 0.05;//1.0;
         intertwined[PartyIndex*6  ] := cc_r;
         intertwined[PartyIndex*6+1] := cc_g;
         intertwined[PartyIndex*6+2] := cc_b;
         glInterleavedArrays (GL_C3F_V3F, 0, @intertwined);
        end;
        //d
        if wParam=$44 then begin
         cc_b := cc_b - 0.05;//1.0;
         intertwined[PartyIndex*6  ] := cc_r;
         intertwined[PartyIndex*6+1] := cc_g;
         intertwined[PartyIndex*6+2] := cc_b;
         glInterleavedArrays (GL_C3F_V3F, 0, @intertwined);
        end;
        //z
        if wParam=90 then begin
         AssignFile(f, path_exe + 'out.txt');
         Rewrite(f);
         {Writeln(f, PointsCount );         //design mode
         for i:=0 to PointsCount do begin  //design mode  }
         {}Writeln(f, PartyIndex );         //create mode
         for i:=0 to PartyIndex do begin  //create mode {}
            //color
            Write(f, intertwined[i*6  ] );
            Write(f, ' ');
            Write(f, intertwined[i*6+1] );
            Write(f, ' ');
            Write(f, intertwined[i*6+2] );
            Write(f, ' ');
            //coords
            Write(f, intertwined[i*6+3] );
            Write(f, ' ');
            Write(f, intertwined[i*6+4] );
            Write(f, ' ');
            Write(f, intertwined[i*6+5] );
            Write(f, ' ');
            Writeln(f);
         end;
         CloseFile(f);
        end;

//delete lines
{
            intertwined[PartyIndex*6  ] := cc_r;
            intertwined[PartyIndex*6+1] := cc_g;
            intertwined[PartyIndex*6+2] := cc_b;
        glInterleavedArrays (GL_C3F_V3F, 0, @intertwined);  }

{
        if wParam=VK_LEFT then xx_x := xx_x + 0.05;//1.0;
        if wParam=VK_UP then xx_y := xx_y + 0.05;//1.0;
        if wParam=VK_INSERT then xx_z := xx_z + 0.05;//1.0;

        if wParam=VK_RIGHT then xx_x := xx_x - 0.05;//1.0;
        if wParam=VK_DOWN then xx_y := xx_y - 0.05;//1.0;
        if wParam=VK_DELETE then xx_z := xx_z - 0.05;//1.0;
{}
                        *)
        Result := 0;
      end;
    WM_KEYUP:         // Set the released key (wparam) to equal false so we can check if its pressed
      begin
//        keys[wParam] := False;
        keys_ := False;
        Result := 0;
      end;
    WM_SIZE:          // Resize the window with the new width and height
      begin
        glResizeWnd(LOWORD(lParam),HIWORD(lParam));
        Result := 0;
      end;

    WM_TIMER :                     // Add code here for all timers to be used.
      begin

        if wParam = FPS_TIMER then
        begin
//          ang := ang + 1;
          //SetWindowText(h_Wnd, PChar(WND_TITLE + ' stage=' + intToStr(Stage) +' progress=' + intToStr(Progress) + '   Time : ' + intToStr(ElapsedTime DIV 1000) + '.' + intToStr(ElapsedTime MOD 1000)+ ' [ElapsedTime] - ' + intToStr(ElapsedTime) + ' |||:- xx_x=' + FloatToStr(xx_x) + ' xx_y=' + FloatToStr(xx_y) + ' xx_z=' + FloatToStr(xx_z)) );
          //SetWindowText(h_Wnd, PChar(WND_TITLE + ' stage=' + intToStr(Stage) +' progress=' + intToStr(Progress) +  ' |||:- xx_x=' + FloatToStr(xx_x) + ' xx_y=' + FloatToStr(xx_y) + ' xx_z=' + FloatToStr(xx_z)  + ' |||:- cc_r=' + FloatToStr(cc_r) + ' cc_g=' + FloatToStr(cc_g) + ' cc_b=' + FloatToStr(cc_b) ) );
            SetWindowText(h_Wnd, PChar(WND_TITLE + ' [ElapsedTime] - ' + intToStr(ElapsedTime)  ) );
          Result := 0;
        end;
        if wParam = TIMER_PARTICLES then
        begin
          if stage = 6
            then ParticalsFog.reset_pr;
          if (stage > 2) and (stage < 6)
               then begin
                  ParticalsRain.add_particle;
                  ParticalsRain.reset_pr;
               end;
          if stage = 7
            then ParticalsSmoke.reset_pr;

          //SetWindowText(h_Wnd, PChar(WND_TITLE  + ' Particals=' + inttostr(ParticalsRain.colpr)) );
          Result := 0;
        end;
      end;

    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam);    // Default result if nothing happens
  end;
end;


{---------------------------------------------------------------------}
{  Properly destroys the window created at startup (no memory leaks)  }
{---------------------------------------------------------------------}
procedure glKillWnd(Fullscreen : Boolean);
begin

  // Stop BASS Sound
  BASS_Stop;
  if BASSInit then
    BASS_StreamFree(Stream);     // Free the stream
  BASS_Free;
  

  if Fullscreen then             // Change back to non fullscreen
  begin
    ChangeDisplaySettings(devmode(nil^), 0);
    ShowCursor(True);
  end;

  // Makes current rendering context not current, and releases the device
  // context that is used by the rendering context.   
  if (not wglMakeCurrent(h_DC, 0)) then
  // Attempts to delete the rendering context
  if (not wglDeleteContext(h_RC)) then
  begin
    h_RC := 0;
  end;

  // Attemps to release the device context
  if ((h_DC = 1) and (ReleaseDC(h_Wnd, h_DC) <> 0)) then
  begin
    h_DC := 0;
  end;

  // Attempts to destroy the window
  if ((h_Wnd <> 0) and (not DestroyWindow(h_Wnd))) then
  begin
    h_Wnd := 0;
  end;

  // Attempts to unregister the window class
  if (not UnRegisterClass('OpenGL', hInstance)) then
  begin
    hInstance := 0;
  end;
end;


{--------------------------------------------------------------------}
{  Creates the window and attaches a OpenGL rendering context to it  }
{--------------------------------------------------------------------}
function glCreateWnd(Width, Height : Integer; Fullscreen : Boolean; PixelDepth : Integer) : Boolean;
var
  wndClass : TWndClass;         // Window class
  dwStyle : DWORD;              // Window styles
  dwExStyle : DWORD;            // Extended window styles
  dmScreenSettings : DEVMODE;   // Screen settings (fullscreen, etc...)
  PixelFormat : GLuint;         // Settings for the OpenGL rendering
  h_Instance : HINST;           // Current instance
  h_Instance1 : HINST;           // Current instance
  pfd : PIXELFORMATDESCRIPTOR;  // Settings for the OpenGL window
begin
  h_Instance := GetModuleHandle(nil);       //Grab An Instance For Our Window
  ZeroMemory(@wndClass, SizeOf(wndClass));  // Clear the window class structure

  with wndClass do                    // Set up the window class
  begin
    style         := CS_HREDRAW or    // Redraws entire window if length changes
                     CS_VREDRAW or    // Redraws entire window if height changes
                     CS_OWNDC;        // Unique device context for the window
    lpfnWndProc   := @WndProc;        // Set the window procedure to our func WndProc
    hInstance     := h_Instance;
    hCursor       := LoadCursor(0, IDC_ARROW);
    lpszClassName := 'OpenGL';
  end;

  if (RegisterClass(wndClass) = 0) then  // Attemp to register the window class
  begin
    Result := False;
    Exit
  end;

  // Change to fullscreen if so desired
  if Fullscreen then
  begin
    ZeroMemory(@dmScreenSettings, SizeOf(dmScreenSettings));
    with dmScreenSettings do begin              // Set parameters for the screen setting
      dmSize       := SizeOf(dmScreenSettings);
      dmPelsWidth  := Width;                    // Window width
      dmPelsHeight := Height;                   // Window height
      dmBitsPerPel := PixelDepth;               // Window color depth
      dmFields     := DM_PELSWIDTH or DM_PELSHEIGHT or DM_BITSPERPEL;
    end;

    // Try to change screen mode to fullscreen
    if (ChangeDisplaySettings(dmScreenSettings, CDS_FULLSCREEN) = DISP_CHANGE_FAILED) then
    begin
      Fullscreen := False;
    end;
  end;

  // If we are still in fullscreen then
  if (Fullscreen) then
  begin
    dwStyle := WS_POPUP or                // Creates a popup window
               WS_CLIPCHILDREN            // Doesn't draw within child windows
               or WS_CLIPSIBLINGS;        // Doesn't draw within sibling windows
    dwExStyle := WS_EX_APPWINDOW;         // Top level window
    ShowCursor(False);                    // Turn of the cursor (gets in the way)
  end
  else
  begin
    dwStyle := WS_OVERLAPPEDWINDOW or     // Creates an overlapping window
               WS_CLIPCHILDREN or         // Doesn't draw within child windows
               WS_CLIPSIBLINGS;           // Doesn't draw within sibling windows
    dwExStyle := WS_EX_APPWINDOW or       // Top level window
                 WS_EX_WINDOWEDGE;        // Border with a raised edge
  end;

  // Attempt to create the actual window
  h_Wnd := CreateWindowEx(dwExStyle,      // Extended window styles
                          'OpenGL',       // Class name
                          WND_TITLE,      // Window title (caption)
                          dwStyle,        // Window styles
                          0, 0,           // Window position
                          Width, Height,  // Size of window
                          0,              // No parent window
                          0,              // No menu
                          h_Instance,     // Instance
                          nil);           // Pass nothing to WM_CREATE
  if h_Wnd = 0 then
  begin
    glKillWnd(Fullscreen);                // Undo all the settings we've changed
    Result := False;
    Exit;
  end;

  // Try to get a device context
  h_DC := GetDC(h_Wnd);
  if (h_DC = 0) then
  begin
    glKillWnd(Fullscreen);
    Result := False;
    Exit;
  end;


  // Settings for the OpenGL window
  with pfd do
  begin
    nSize           := SizeOf(PIXELFORMATDESCRIPTOR); // Size Of This Pixel Format Descriptor
    nVersion        := 1;                    // The version of this data structure
    dwFlags         := PFD_DRAW_TO_WINDOW    // Buffer supports drawing to window
                       or PFD_SUPPORT_OPENGL // Buffer supports OpenGL drawing
                       or PFD_DOUBLEBUFFER;  // Supports double buffering
    iPixelType      := PFD_TYPE_RGBA;        // RGBA color format
    cColorBits      := PixelDepth;           // OpenGL color depth
    cRedBits        := 0;                    // Number of red bitplanes
    cRedShift       := 0;                    // Shift count for red bitplanes
    cGreenBits      := 0;                    // Number of green bitplanes
    cGreenShift     := 0;                    // Shift count for green bitplanes
    cBlueBits       := 0;                    // Number of blue bitplanes
    cBlueShift      := 0;                    // Shift count for blue bitplanes
    cAlphaBits      := 0;                    // Not supported
    cAlphaShift     := 0;                    // Not supported
    cAccumBits      := 0;                    // No accumulation buffer
    cAccumRedBits   := 0;                    // Number of red bits in a-buffer
    cAccumGreenBits := 0;                    // Number of green bits in a-buffer
    cAccumBlueBits  := 0;                    // Number of blue bits in a-buffer
    cAccumAlphaBits := 0;                    // Number of alpha bits in a-buffer
    cDepthBits      := 16;                   // Specifies the depth of the depth buffer
    cStencilBits    := 0;                    // Turn off stencil buffer
    cAuxBuffers     := 0;                    // Not supported
    iLayerType      := PFD_MAIN_PLANE;       // Ignored
    bReserved       := 0;                    // Number of overlay and underlay planes
    dwLayerMask     := 0;                    // Ignored
    dwVisibleMask   := 0;                    // Transparent color of underlay plane
    dwDamageMask    := 0;                     // Ignored
  end;

  // Attempts to find the pixel format supported by a device context that is the best match to a given pixel format specification.
  PixelFormat := ChoosePixelFormat(h_DC, @pfd);
  if (PixelFormat = 0) then
  begin
    glKillWnd(Fullscreen);
    Result := False;
    Exit;
  end;

  // Sets the specified device context's pixel format to the format specified by the PixelFormat.
  if (not SetPixelFormat(h_DC, PixelFormat, @pfd)) then
  begin
    glKillWnd(Fullscreen);
    Result := False;
    Exit;
  end;

  // Create a OpenGL rendering context
  h_RC := wglCreateContext(h_DC);
  if (h_RC = 0) then
  begin
    glKillWnd(Fullscreen);
    Result := False;
    Exit;
  end;


  h_RC_res := wglCreateContext(h_DC);  

  if (not wglMakeCurrent(h_DC, h_RC)) then
  begin
    glKillWnd(Fullscreen);
    Result := False;
    Exit;
  end;

  wglShareLists(h_RC_res, h_RC);
  
  // Initializes the timer used to calculate the FPS
  SetTimer(h_Wnd, FPS_TIMER, FPS_INTERVAL, nil);

  // Settings to ensure that the window is the topmost window
  ShowWindow(h_Wnd, SW_SHOW);
  SetForegroundWindow(h_Wnd);
  SetFocus(h_Wnd);

  // Ensure the OpenGL window is resized properly
  glResizeWnd(Width, Height);

  Result := True;

  //--- Initialize and Start BASS Sound system ----//
  Stream := 0;
  BASSInit :=FALSE;
  if BASS_GetVersion() <> MAKELONG(0,8) then    //  Check that BASS 0.8+ was loaded
  begin
    MessageBox(0, 'BASS version 0.8 Sound System was not loaded', 'Sound', MB_OK or MB_ICONERROR);
    exit;
  end;

  // Initialize digital sound - default device, 44100hz, stereo, 16 bits
  if not BASS_Init(-1, 44100, 0, h_Wnd) then
  begin
    MessageBox(0, 'Can''t initialize digital sound system', 'Sound', MB_OK or MB_ICONERROR);
    exit;
  end;

  //  Start digital output
  BASS_Start;
  Stream := BASS_StreamCreateFile(FALSE, PChar(path_exe + 'data\track.mp3'), 0, 0, 0);
//  BASS_SetVolume(10);
  if Stream = 0 then
  begin
    MessageBox(0, 'Can''t create digital sound stream. Music file might be missing', 'Sound', MB_OK or MB_ICONERROR);
    exit;
  end;

  BASSInit :=TRUE;

end;


{--------------------------------------------------------------------}
{  Main message loop for the application                             }
{--------------------------------------------------------------------}
function WinMain(hInstance : HINST; hPrevInstance : HINST;
                 lpCmdLine : PChar; nCmdShow : Integer) : Integer; stdcall;
var
  msg : TMsg;
  DemoStart : DWord;
  LastTime : DWord;

begin

  If MessageBox(h_Wnd,'Fullscreen (1024x768x16) ?','Is Culture a normal?',MB_OKCANCEL) = IDOK then begin
    FullScreen := true;
    Width  := 1024;
    Height := 768;
  end;


  // Perform application initialization:
  if not glCreateWnd(Width, Height, FullScreen, PixelDepth) then
  begin
    Result := 0;
    Exit;
  end;


  glClearColor(0, 0, 0, 0.0); 	   // Black Background
  glShadeModel(GL_SMOOTH);                 // Enables Smooth Color Shading
  glClearDepth(1.0);                       // Depth Buffer Setup
  //glEnable(GL_DEPTH_TEST);                 // Enable Depth Buffer
  glDepthFunc(GL_LESS);		           // The Type Of Depth Test To Do


  glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);   //Realy Nice perspective calculations
  glHint(GL_LINE_SMOOTH_HINT, GL_NICEST);
  glHint(GL_FOG_HINT, GL_NICEST);
                  {
  glClearAccum(0.0, 0.0, 0.0, 1.0);
  glClear(GL_ACCUM_BUFFER_BIT);
                     }
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); ///!!!  FIRE
//  glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
//  glBlendFunc(GL_SRC_ALPHA, GL_DST_ALPHA);
  //используйте GL_ONE если вам нужен аддитивный цвет

  glEnable(GL_LINE_SMOOTH);
  glEnable(GL_POINT_SMOOTH);
  glEnable(GL_SMOOTH);

  glEnable(GL_BLEND);

  glEnable (GL_COLOR_MATERIAL);  //BLACK_AND_WHITE - in comment

  //to fix z-fighting
  glEnable(GL_POLYGON_OFFSET_FILL);
  glPolygonOffset(1, 1);

  // LoadTexture(path_exe + path_gfx + 'loader.jpg',array_text[0]);
   //glEnable(GL_TEXTURE_2D);
                     {
  glEnable(GL_FOG);
  glFogf(GL_FOG_START, 100.0);
  glFogf(GL_FOG_END, 150.0);
  glFogf(GL_FOG_MODE, GL_LINEAR);
  glFogf(GL_FOG_DENSITY, 0.1); // плотность тумана

                      {
 glEnable (GL_ALPHA_TEST);
 glAlphaFunc( GL_GREATER, 0.1 );  }
// glLightModeli(GL_LIGHT_MODEL_TWO_SIDE,1);}

//  glShadeModel (GL_FLAT);                           // Do not shade the model
  InitLoadScreen;

  makeRasterFont();

  DemoStart := GetTickCount();            // Get Time when demo started

  // Main message loop:
  while not finished do
  begin
    if (PeekMessage(msg, 0, 0, 0, PM_REMOVE)) then // Check if there is a message for this window
    begin
      if (msg.message = WM_QUIT) then     // If WM_QUIT message received then we are done
        finished := True
      else
      begin                               // Else translate and dispatch the message to this window
  	TranslateMessage(msg);
        DispatchMessage(msg);
      end;
    end
    else
    begin

      if Stage = 2 then
      begin
        DemoStart :=GetTickCount() - 1;
        if BassInit then
          BASS_StreamPlay(Stream, FALSE, 0);
        Stage :=3;
      end;

      LastTime :=ElapsedTime;
      ElapsedTime :=GetTickCount() - DemoStart + TimeOffset;     // Calculate Elapsed Time
      //ElapsedTime :=(LastTime + ElapsedTime) DIV 2 ; // Average it out for smoother movement


      glDraw();                           // Draw the scene 
      SwapBuffers(h_DC);                  // Display the scene

      if keys_ then           // If user pressed ESC then set finised TRUE
        finished := True ;

    end;
  end;
  glKillWnd(FALSE);
  Result := msg.wParam;
end;


function getPath_:string;
  var s:string;
  i:integer;
  begin
    s:=Paramstr(0);
    i:=length(s);
    while i>0 do begin
      if s[i]='\' then begin
      delete(s,i+1,length(s)-i);
      result:=s;
      break;
      end;
      dec(i);
    end;
  end;

begin
  path_exe := getPath_;

  WinMain( hInstance, hPrevInst, CmdLine, CmdShow );

  ParticalsRain.Free;
  ParticalsFog.Free;
  ParticalsSmoke.Free;

end.


{

var i, j : GLint;
    teststring : string;
    tempI : GLfloat;

begin


    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);                   // Clear the colour buffer
    glLoadIdentity();
    glTranslatef(0,0,-10);

      glDisable(GL_LIGHTING);
      glDisable(GL_LIGHT0);

    teststring := '';      
    glColor3fv(@white);                             // Set the font colour to white
    i := 0;                                         // Initialize the variable for our loop
    while (i < 127) do
    begin
      tempI := i/32.0;
      glRasterPos2f(-10.0, 55.0 - 18.0*tempI);     // Set the raster position
        for j := 0 to 31 do                         // Create the string
            teststring := teststring + char(i+j);

        teststring := teststring + char(0);
        printString(teststring);                    // Print the string to the scene
        teststring := '';                           // Re-init the string variable
        i := i + 32;                                // Incrememt by 32 characters
    end;
    glRasterPos2i(0, 0);                        // Set the position for the text to be rendered
    printString('The quick brown fox jumps');       // Print the string to the scene
    glRasterPos2i(0, 2);                        // Set the position for the text to be rendered
    printString('over a lazy dog.');                // Print the string to the scene

      glEnable(GL_LIGHTING);
      glEnable(GL_LIGHT0);    


      glColor3f(1.0,0.0,0.0);
      glutSolidCube(1);

  // Flush the OpenGL Buffer
  glFlush();                        // ( Force the buffer to draw or send a network packet of commands in a networked system)

}




прога грузит проц только лишь потому, что в потоке есть wglMakeCurrent(h_DC, h_RC_res) ;
если его убрать, то всЄ нормально, но тогда нельз€ будет параллелить процессы 
