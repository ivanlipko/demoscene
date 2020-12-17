program tunnel;

uses
  Windows,
  Messages,
  OpenGL,
  BMP,
  MiniFMOD,
  Scenes
//  Partical
;

const
  WND_TITLE = 'SCRIMERS _ vekmnabkmv _';
  FPS_TIMER = 1;                     // Timer to calculate FPS
  FPS_INTERVAL = 100;               // Calculate FPS every 1000 ms
var
  h_Wnd  : HWND;                     // Global window handle
  h_DC   : HDC;                      // Global device context
  h_RC   : HGLRC;                    // OpenGL rendering context

//  keys : Array[0..255] of Boolean;   // Holds keystrokes
  keys_:boolean;
//  FPSCount : Integer = 0;            // Counter for FPS              //comente here and other = 1 kB
//  ElapsedTime : Integer;             // Elapsed time between frames
//  LastTime    : Integer;             // Last elapsed time. Used to average out times and get smoother movement

  //initial
    Width  : Integer = 800; //1024  // 1280 // 800
    Height : Integer = 600; //768   // 1024 // 600
    PixelDepth : Integer = 16; //24 //16 //32
    FullScreen : Boolean =true;
{$R xm_e.RES} //_e

{------------------------------------------------------------------}
{  Function to draw the actual scene                               }
{------------------------------------------------------------------}
procedure glDraw();
var i:byte;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);    // Clear The Screen And The Depth Buffer
  glLoadIdentity();
                                       // Reset The View
// glTranslatef(0,-10,-30);
//  glRotatef(30,1,0,0);// commet }

  {coordinates
  glPushMatrix;
  glBegin(GL_LINES);
   glColor3f(1,0,0);
    glVertex3f(0,0,0);
    glVertex3f(100,0,0);
   glColor3f(0,1,0);
    glVertex3f(0,0,0);
    glVertex3f(0,100,0);
   glColor3f(0,0,1);
    glVertex3f(0,0,0);
    glVertex3f(0,0,100);
  glEnd;
  glPopMatrix;
  { sceneoptions }

  case NowOrder of
        0,1:            SceneCubeRain; //true
        2,3,4,5:        SceneCubeTree;
        6,7:              SceneCubeFire;
        8:begin
                        glTranslatef(0,-10,-35);
                        glRotatef(-45,0,1,0);
                        SceneCubeFire;
        end;
        9:begin
                        glTranslatef(0,-10,-35);
                        glRotatef(-45,0,1,0);
                                SceneCubeFire;
//                                SceneWordGreets;
        end;
        10:begin
                        glTranslatef(0,-10,-35);
                        glRotatef(-45,0,1,0);
                        SceneCubeFire;
//                                SceneWordGreets;
        end;
        11:begin
                        glTranslatef(0,-10,-35);
                        glRotatef(-45,0,1,0);
//                            glBlendFunc(GL_SRC_ALPHA, GL_DST_ALPHA);
                        SceneCubeFire_STOP;
                        SceneWordAuthor;
//                        SceneWordGreets;
        end;
        12:begin
                        glTranslatef(0,-10,-35);
                        glRotatef(-45,0,1,0);
//                            glBlendFunc(GL_SRC_ALPHA, GL_DST_ALPHA);
                        SceneCubeFire_STOP1;
                        SceneWordAuthor;
//                        SceneWordGreets;
        end;
        13:begin
          glTranslatef(0,-1,-20); //com
          glRotatef(_FMUSIC_GetTime(Module)*0.02,0,1,1);    //com
                        SceneRise;
        end;
        14:begin
                glTranslatef(0,-1,-20); //com
                glRotatef(45+_FMUSIC_GetTime(Module)*0.02,0,1,1);    //com
                  glRotatef(70,0,1,0);
//                  glBlendFunc(GL_SRC_ALPHA, GL_DST_ALPHA);
//                MypartCubeRain.Draw_particle;
                  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
                        glCallList(2);
                        glCallList(3);
        end;
        15:begin
                  glTranslatef(0,0,-20-NowRow*3); //com
                  glRotatef((_FMUSIC_GetTime(Module)-ElapsedTime_1)*0.014,0,1,1);
                  glRotatef(90,1,0,0);
//                  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
                  glPushMatrix;
                        glCallList(3);
                        SceneDay;
                  glPopMatrix;
                  glRotatef((_FMUSIC_GetTime(Module)-ElapsedTime_1)*0.014,0,1,0);
                  if NowRow>=16 then begin
                     glPushMatrix;
                           glCallList(5);
                     glPopMatrix;
                  end;
        end;
        16:begin
                  glTranslatef(0,0,-40-NowRow*3); //com
                  glRotatef(-(_FMUSIC_GetTime(Module)-ElapsedTime_1)*0.014,0,1,1);    //com
                  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
                       glRotatef(90,1,0,0);
                        glCallList(3);
                        glCallList(4);
                  SceneDayDay;

        end;
        17:begin
                  glTranslatef(0,0,-120-NowRow*5); //com
                  glRotatef(-(_FMUSIC_GetTime(Module)-ElapsedTime_1)*0.014,0,1,1);    //com

                  SceneDayDaySpiral;
                  glTranslatef(0,0,-NowRow*0.5); //com
//                  SceneDayDaySpiral;
                  glCallList(6);
                  glTranslatef(-20,0,50-NowRow*0.5); //com
                  glCallList(6);
//                        glCallList(4);
        end;
        18:begin
                  glRotatef(-(_FMUSIC_GetTime(Module)-ElapsedTime_1)*0.014,0,0,1);    //com        
                  glTranslatef(0,0,200-NowRow*5); //com
                  glRotatef(90,1,0,0);

                  SceneDayDay;
                  SceneDayDay;
        end;
        19:begin
//                  glTranslatef(-20,-10,-70); //com//-125
//                  glRotatef(90,0,1,0);
//                  glRotatef(NowRow*3,1,0,0);
                  glTranslatef(-30+NowRow*0.7,-10+7*sin(3.14/3+NowRow*0.1)+NowRow*0.2,-50); //com//-125

                           glRotatef(-120,0,0,1);

            glPushMatrix;
             glColor3f(0.45, 0.05, 0.50);
                glLineWidth(6);
               glRotatef(-5,0,0,1);
                 glBegin(GL_LINE_LOOP);
                     glVertex3f(0,0,0);
                     glVertex3f(1.5,0,0);
                     glVertex3f(1.5,0.2,0);
                 glEnd;
                 glLineWidth(1);
                     glColor3f(0.21, 0.1, 0.2);
                       glTranslatef(-1,1.5,0);
                       glScalef(0.2,0.2,0.2);
                         glBegin(GL_LINE_STRIP);
                           For i := 2 to LenghtCurve-39 do begin
                             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
                           end;
                         glEnd;
                       glScalef(5,5,5);
                       glTranslatef(1,-1.5,0);
                glPushMatrix;
                  glRotatef(60+50*sin(NowRow*0.2),1,0,0);
                     glCallList(7);
                glPopMatrix;
                  glRotatef(-60-50*sin(NowRow*0.2),1,0,0);
                     glCallList(7);
            glPopMatrix;
            glPushMatrix;
                glTranslatef(5,10,0);
             glColor3f(0.315, 0.12, 0.430);
                glLineWidth(6);
               glRotatef(-5,0,0,1);
                 glBegin(GL_LINE_LOOP);
                     glVertex3f(0,0,0);
                     glVertex3f(1.5,0,0);
                     glVertex3f(1.5,0.2,0);
                 glEnd;
                 glLineWidth(1);
                     glColor3f(0.21, 0.1, 0.2);
                       glTranslatef(-1,1.5,0);
                       glScalef(0.2,0.2,0.2);
                         glBegin(GL_LINE_STRIP);
                           For i := 2 to LenghtCurve-39 do begin
                             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
                           end;
                         glEnd;
                       glScalef(5,5,5);
                       glTranslatef(1,-1.5,0);
                glPushMatrix;
                  glRotatef(60+50*sin(0.61+NowRow*0.2),1,0,0);
                     glCallList(7);
                glPopMatrix;
                  glRotatef(-60-50*sin(0.61+NowRow*0.2),1,0,0);
                     glCallList(7);
            glPopMatrix;
            glPushMatrix;
                glTranslatef(-5,7,0);
             glColor3f(0.415, 0.10, 0.430);
                glLineWidth(6);
               glRotatef(-5,0,0,1);
                 glBegin(GL_LINE_LOOP);
                     glVertex3f(0,0,0);
                     glVertex3f(1.5,0,0);
                     glVertex3f(1.5,0.2,0);
                 glEnd;
                 glLineWidth(1);
                     glColor3f(0.21, 0.1, 0.2);
                       glTranslatef(-1,1.5,0);
                       glScalef(0.2,0.2,0.2);
                         glBegin(GL_LINE_STRIP);
                           For i := 2 to LenghtCurve-39 do begin
                             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
                           end;
                         glEnd;
                       glScalef(5,5,5);
                       glTranslatef(1,-1.5,0);
                glPushMatrix;
                  glRotatef(60+50*sin(0.4+NowRow*0.2),1,0,0);
                     glCallList(7);
                glPopMatrix;

                  glRotatef(-60-50*sin(0.4+NowRow*0.2),1,0,0);
                     glCallList(7);
            glPopMatrix;
        end;
        20:begin
                SceneWordGreets;
        end;
        21:begin
                if NowRow <28 then
                        glTranslatef(-9,-12+NowRow*0.5,-25)
                else
                        glTranslatef(-9,2,-25);
                SceneWordGreets1;
        end;
  end;
  {}
                //cubes rain

//        glTranslatef(0,0,-10);
//        SceneCubeRain;

                //cubes rain - end
                       {}

          //tree
//              SceneCubeTree;
         //tree -end
          {}

//          SceneWordGreets;
                   {}
   glAccum(GL_MULT, q);
   glAccum(GL_ACCUM, 1-q);
   glAccum(GL_RETURN, 1);
              {}
   glFlush;
end;


{------------------------------------------------------------------}
{  Initialise OpenGL                                               }
{------------------------------------------------------------------}
procedure glInit();
begin
  glClearColor(0.09, 0.08, 0.09, 1.0); 	   // Black Background
  glShadeModel(GL_SMOOTH);                 // Enables Smooth Color Shading
  glClearDepth(1.0);                       // Depth Buffer Setup
  glEnable(GL_DEPTH_TEST);                 // Enable Depth Buffer
  glDepthFunc(GL_LESS);		           // The Type Of Depth Test To Do
  {
  glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);   //Realy Nice perspective calculations
  }
  glClearAccum(0.0, 0.0, 0.0, 1.0);
  glClear(GL_ACCUM_BUFFER_BIT);

  glHint(GL_LINE_SMOOTH_HINT, GL_NICEST);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); ///!!!  FIRE
  //используйте GL_ONE если вам нужен аддитивный цвет

//    glBlendFunc(GL_SRC_ALPHA, GL_DST_ALPHA);

  glEnable(GL_LINE_SMOOTH);
  glEnable(GL_POINT_SMOOTH);
  glEnable(GL_SMOOTH);
  
  glEnable(GL_BLEND);
//  glDisable(GL_TEXTURE_2D);
  //просто обычные белые линии, благодарю вас.

//  glColor4f(1,1,1, alphavalue);
 //убедитесь, что указали alpha-канал
   {}

 glEnable(GL_LIGHTING);
 glEnable(GL_LIGHT0);

 glEnable (GL_COLOR_MATERIAL);  //BLACK_AND_WHITE - in comment
 glEnable (GL_ALPHA_TEST);
 glAlphaFunc( GL_GREATER, 0.1 );
 glLightModeli(GL_LIGHT_MODEL_TWO_SIDE,1);

// SHININESS := 20.0;

 LightPos [0] := 10.0;
 LightPos [1] := 10.0;
 LightPos [2] := 10.0;
 LightPos [3] := 0.0;
              {
 MaterialAmbient [0] := 0.2;
 MaterialAmbient [1] := 0.2;
 MaterialAmbient [2] := 0.2;
 MaterialAmbient [3] := 1.0;

 MaterialDiffuse [0] := 0.8;
 MaterialDiffuse [1] := 0.8;
 MaterialDiffuse [2] := 0.78;
 MaterialDiffuse [3] := 1.0;
                 }
 Ambient [0] := 0.90;
 Ambient [1] := 0.950;
 Ambient [2] := 0.80;
 Ambient [3] := 1.0;

 Diffuse [0] := 1.0;
 Diffuse [1] := 1.0;
 Diffuse [2] := 1.0;
 Diffuse [3] := 1.0;         

 Specular [0] := 1.0;
 Specular [1] := 1.0;
 Specular [2] := 1.0;        
 Specular [3] := 1.0;
 {
 glLightfv(GL_LIGHT0, GL_POSITION, @LightPos); }
 glLightfv(GL_LIGHT0, GL_AMBIENT, @Ambient);
 glLightfv(GL_LIGHT0, GL_DIFFUSE, @Diffuse);
 glLightfv(GL_LIGHT0, GL_SPECULAR, @Specular);

 {
 glMaterialfv (GL_FRONT, GL_AMBIENT, @MaterialAmbient);
 glMaterialfv (GL_FRONT, GL_DIFFUSE, @MaterialDiffuse);
  }

 randomize;

end;


{------------------------------------------------------------------}
{  Handle window resize                                            }
{------------------------------------------------------------------}
procedure glResizeWnd(Width, Height : Integer);
begin
  if (Height = 0) then                // prevent divide by zero exception
    Height := 1;
  glViewport(0, 0, Width, Height);    // Set the viewport for the OpenGL window
  glMatrixMode(GL_PROJECTION);        // Change Matrix Mode to Projection
  glLoadIdentity();                   // Reset View
  gluPerspective(45.0, Width/Height, 1.0, 1000.0);  // Do the perspective calculations. Last value = max clipping depth

  glMatrixMode(GL_MODELVIEW);         // Return to the modelview matrix
  glLoadIdentity();                   // Reset View

end;

{------------------------------------------------------------------}
{  Determines the applicationТs response to the messages received  }
{------------------------------------------------------------------}
function WndProc(hWnd: HWND; Msg: UINT;  wParam: WPARAM;  lParam: LPARAM): LRESULT; stdcall;
//var p:Byte;
begin
  case (Msg) of
    WM_CLOSE:
      begin
        PostQuitMessage(0);
        Result := 0
      end;
    WM_KEYDOWN:       // Set the pressed key (wparam) to equal true so we can check if its pressed
      begin
//        keys[wParam] := True;
            if wParam=VK_ESCAPE then
                keys_ := True;
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
          ScenesOptions;
          {
          if push then p:=1 else p:=0;

          SetWindowText(h_Wnd, PChar(WND_TITLE + ' _ vekmnabkmv _'
//                        + intToStr(NowOrder) +' / '
//                        + intToStr(NowRow) +' ] '
//                        + intToStr(ElapsedTime) +' ] '
//                        + intToStr(MypartCubeRain.Count) +' ] '   175.0-NowRow*2
                        )); }
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

  if (not wglMakeCurrent(h_DC, h_RC)) then
  begin
    glKillWnd(Fullscreen);
    Result := False;
    Exit;
  end;

  // Initializes the timer used to calculate the FPS
  SetTimer(h_Wnd, FPS_TIMER, FPS_INTERVAL, nil);

  // Settings to ensure that the window is the topmost window
  ShowWindow(h_Wnd, SW_SHOW);
  SetForegroundWindow(h_Wnd);
  SetFocus(h_Wnd);

  // Ensure the OpenGL window is resized properly
  glResizeWnd(Width, Height);
  glInit();

  Result := True;
end;


{--------------------------------------------------------------------}
{  Main message loop for the application                             }
{--------------------------------------------------------------------}
function WinMain(hInstance : HINST; hPrevInstance : HINST;
                 lpCmdLine : PChar; nCmdShow : Integer) : Integer; stdcall;
var
  msg : TMsg;
  finished : Boolean;
//  i:Byte;
begin

  finished := False;

  // Perform application initialization:
  if not glCreateWnd(Width, Height, FullScreen, PixelDepth) then
  begin
    Result := 0;
    Exit;
  end;

  //prescenes
  { }
  PreSceneCubeRain;
  PreSceneCubeTree;
  PreSceneCubeFire;
  PreSceneWords;
  PreSceneRise;


//  glInterleavedArrays (GL_V3F, 0, @ctrlpoints_);

  {}

  XMPlayFromRes('XMMOD','MUSIC');    //play music                                     !!!
   //order and row
  NowOrder:=0;//_FMUSIC_GetOrder(module);
  NowRow:=0;//_FMUSIC_GetRow(module);

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
//      Inc(FPSCount);                      // Increment FPS Counter

      NowOrder:=_FMUSIC_GetOrder(module);
      NowRow:=_FMUSIC_GetRow(module);

      ElapsedTime :=_FMUSIC_GetTime(Module);//GetTickCount();                // Calculate elapsed time in milliseconds                                       !!!!!!!!!!!!!

      glDraw();                           // Draw the scene

      SwapBuffers(h_DC);                  // Display the scene

      if keys_ then           // If user pressed ESC then set finised TRUE
        finished := True ;

    end;
  end;
  glKillWnd(FALSE);
  Result := msg.wParam;
end;


begin
  WinMain( hInstance, hPrevInst, CmdLine, CmdShow );
  XMFree();
  glDeleteLists(1,40);//2

  Mypart.Free;

//  Mypart.Destroy;
  MypartCubeRain.Free  ;
//  MypartCubeRain.Destroy;

end.
