unit Scenes;

interface
uses
     Partical;

const
        _T_9 =163;
        _T_7 =164;
        _T_A =165;
        _T_B =166;
        _T_C =167;
        _T_D =168;
        _T_E =169;
        _T_F =170;
        _T_G =171;
        _T_H =172;
        _T_I =173;
        _T_J =174;
        _T_K =175;
        _T_L =176;
        _T_M =177;
        _T_N =178;
        _T_O =179;
        _T_P =180;
        _T_Q =181;
        _T_R =182;
        _T_S =183;
        _T_T =184;
        _T_U =185;
        _T_V =186;
        _T_W =187;
        _T_X =188;
        _T_Y =189;
        _T_Z =190;

        LenghtCurve=48-1;
        LenghtCurve_=150-3;
        GL_V3F = $2A21;

procedure ScenesOptions;

procedure SceneCubeRain;
procedure PreSceneCubeRain;

//procedure SceneCubeRain1;

procedure SceneCubeTree;
procedure PreSceneCubeTree;
procedure PreSceneBuildCubeTree;

procedure SceneCubeFire;
procedure PreSceneCubeFire;

procedure SceneCubeFire_STOP;
procedure SceneCubeFire_STOP1;

procedure PreSceneRise ;
procedure SceneRise;

procedure SceneDay;
procedure SceneDayday;
procedure SceneDayDaySpiral;

procedure SceneWordAuthor;
procedure SceneWordGreets;
procedure SceneWordGreets1;
procedure PreSceneWords;

var
   Mypart:TP_Particle;
   MypartCubeRain:TP_Particle;

   //variables
   Transl:Real;
//   Tr1:Real;
//   Tr2:Real;

   ScenesOptTrig:Boolean =true;   //TRUE!!!

                      // curve Buzve
//  selpoint : byte = 0;

 ctrlpoints : Array [0..LenghtCurve, 0..2] of real =
       (
//       (   0,            0,               0 )   ,
{}
       ( 0.320056762 *100  ,	-0.093138499 *100 ,  0 )   ,
       ( 0.140642326 *100  ,	-0.08942882  *100 ,  0 )   ,
       ( 0.073368523 *100  ,	-0.083443027 *100 ,  0 )   ,
       ( 0.035348251 *100  ,	-0.075464864 *100 ,  0 )   ,
       ( 0.01028343  *100  ,	-0.065868775 *100 ,  0 )   ,
       ( -0.007109094*100  ,	-0.055098825 *100 ,  0 )   ,
      { }
       ( -0.01904692 *100  ,	-0.043643883 *100 ,  0 )   ,
       ( -0.026672681*100  ,	-0.032010611 *100 ,  0 )   ,
       ( -0.030715179*100  ,	-0.020695891 *100 ,  0 )   ,
       ( -0.031747099*100  ,	-0.010160354 *100 ,  0 )   ,
       ( -0.030292347*100  ,	-0.00080458  *100 ,  0 )   ,
       ( -0.026868072*100  ,	0.007050649  *100 ,  0 )   ,
       ( -0.021994951*100  ,	0.013178935  *100 ,  0 )   ,
       ( -0.016191036*100  ,	0.017456912  *100 ,  0 )   ,
       ( -0.009957191*100  ,	0.019866593  *100 ,  0 )   ,
       ( -0.003758968*100  ,	0.020491411  *100 ,  0 )   ,
       ( 0.001991877 *100  ,	0.019506408  *100 ,  0 )   ,
       ( 0.006953881 *100  ,	0.017163306  *100 ,  0 )   ,
       ( 0.010868783 *100  ,	0.013771586  *100 ,  0 )   ,
       ( 0.013569683 *100  ,	0.009676853  *100 ,  0 )   ,
       ( 0.014983875 *100  ,	0.00523795   *100 ,  0 )   ,
       ( 0.015130153 *100  ,	0.000804297  *100 ,  0 )   ,
       ( 0.014110854 *100  ,	-0.003305105 *100 ,  0 )   ,
       ( 0.012099269 *100  ,	-0.006819744 *100 ,  0 )   ,
       ( 0.009323344 *100  ,	-0.009531686 *100 ,  0 )   ,
       ( 0.006046824 *100  ,	-0.011304931 *100 ,  0 )   ,
       ( 0.002549163 *100  ,	-0.012079634 *100 ,  0 )   ,
       ( -0.000894477*100  ,	-0.011871111 *100 ,  0 )   ,
       ( -0.004031829*100  ,	-0.010763931 *100 ,  0 )   ,
       ( -0.006649556*100  ,	-0.008901696 *100 ,  0 )   ,
       ( -0.008585785*100  ,	-0.006473376 *100 ,  0 )   ,
       ( -0.009738434*100  ,	-0.003697275 *100 ,  0 )   ,
       ( -0.010068976*100  ,	-0.000803824 *100 ,  0 )   ,
       ( -0.009601575*100  ,	0.001981572  *100 ,  0 )   ,
       ( -0.008417881*100  ,	0.004454462  *100 ,  0 )   ,
       ( -0.00664801 *100  ,	0.006444986  *100 ,  0 )   ,
       ( -0.004458544*100  ,	0.007828386  *100 ,  0 )   ,
       ( -0.002038495*100  ,	0.008531781  *100 ,  0 )   ,
       ( 0.000415671 *100  ,	0.008536895  *100 ,  0 )   ,
       ( 0.002714844 *100  ,	0.00787871   *100 ,  0 )   ,
       ( 0.004690874 *100  ,	0.006640325  *100 ,  0 )   ,
       ( 0.006208033 *100  ,	0.004944541  *100 ,  0 )   ,
       ( 0.007171598 *100  ,	0.002942912  *100 ,  0 )   ,
       ( 0.007533063 *100  ,	0.000803163  *100 ,  0 )   ,
       ( 0.007291718 *100  ,	-0.001304044 *100 ,  0 )   ,
       ( 0.00649264  *100  ,	-0.003218012 *100 ,  0 )   ,
       ( 0.00522137  *100  ,	-0.004799644 *100 ,  0 )   ,
       ( 0.003595803 *100  ,	-0.005941003 *100 ,  0 )
        );

 push:Boolean=true;



implementation
uses OpenGL,
     BMP,
     MiniFMOD
     ;

procedure ScenesOptions;
var
        fogColor : array[0..3] of GLfloat;
        i:integer;
begin               
        case NowOrder of     //order+2
                0,1:begin
                        MypartCubeRain.Change_particle; //true
//                        SceneCubeRain;
                end;
                2,3,4:
                begin
                        Mypart.Change_particle;
//                        SceneCubeTree;
                        if ScenesOptTrig then    //true
                        begin
                                q:=q-0.2;//q:=0.7;

                                ElapsedTime_:=ElapsedTime;
//                                ElapsedTime_1:=ElapsedTime_*7+ElapsedTime_;
                                fogColor[0]:=0.09;//0.09, 0.08, 0.09, 1.0
                                fogColor[1]:=0.08;
                                fogColor[2]:=0.09;
                                fogColor[3]:=1;
                                    { }
                                glEnable(GL_FOG); // включаем режим тумана
                                glFogi(GL_FOG_MODE, GL_LINEAR); // задаем закон смешени€ тумана
                                glFogfv(GL_FOG_COLOR, @fogColor); // цвет дымки
                                glFogf(GL_FOG_DENSITY, 1); // плотность тумана
                                glHint(GL_FOG_HINT, GL_NICEST);// предпочтений к работе тумана нет

                                glFogf(GL_FOG_START, 0.0); // ближн€€ плоскость дл€ линейного
                                glFogf(GL_FOG_END, 100.0); // дальн€€ плоскость дл€ линейного
                                {}
                                ScenesOptTrig := not ScenesOptTrig;    //false
                        end;
                end;
                5:begin
//                        if NowRow >57 then
//                                Mypart.TP_Density:=100000;
//                        if NowRow >60 then
//                                for i:=1 to Mypart.MAXCount do
//                                        Mypart.particles[i].Color[3]:=0
//                        else
                        Mypart.Change_particle;  
                end;
                6,7:
                begin
//                        SceneCubeFire;
                        if not ScenesOptTrig then //false
                        begin
//                                q:=0.7;

                                Mypart.Destroy;

//                                ElapsedTime_:=ElapsedTime;
                                                      
                                glEnable(GL_LIGHT1);

                                LightPos [0] := 0.0;
                                LightPos [1] := 1.0;
                                LightPos [2] := 0.0;
                                LightPos [3] := 1.0;

                                Ambient [0] := 0.9;
                                Ambient [1] := 0.2;
                                Ambient [2] := 0;
                                Ambient [3] := 1;

                                Diffuse [0] := 0.7;
                                Diffuse [1] := 0;
                                Diffuse [2] := 0;
                                Diffuse [3] := 1;

                                Specular [0] := 0.0;
                                Specular [1] := 0.0;
                                Specular [2] := 0.0;
                                Specular [3] := 1.00;

                                glLightfv(GL_LIGHT1, GL_POSITION, @LightPos);
                                glLightfv(GL_LIGHT1, GL_AMBIENT, @Ambient);
                                glLightfv(GL_LIGHT1, GL_DIFFUSE, @Diffuse);
                                glLightfv(GL_LIGHT1, GL_SPECULAR, @Specular);
                                                   {}
                                fogColor[0]:=0.09;//0.09, 0.08, 0.09, 1.0
                                fogColor[1]:=0.08;
                                fogColor[2]:=0.09;
                                fogColor[3]:=1;
//                                gldisable(GL_FOG); true
                                    {  }
                                glEnable(GL_FOG); // включаем режим тумана
                                glFogi(GL_FOG_MODE, GL_LINEAR); // задаем закон смешени€ тумана
                                glFogfv(GL_FOG_COLOR, @fogColor); // цвет дымки
                                glFogf(GL_FOG_DENSITY, 1); // плотность тумана
                                glHint(GL_FOG_HINT, GL_NICEST);// предпочтений к работе тумана нет

                                glFogf(GL_FOG_START, 0.0); // ближн€€ плоскость дл€ линейного
                                glFogf(GL_FOG_END, 50.0); // дальн€€ плоскость дл€ линейного
                                {}

                                MypartCubeRain:=TP_Particle.Create;
                                MypartCubeRain.TP_Nil_Position[0]:=0;
                                MypartCubeRain.TP_Nil_Position[1]:=-2;
                                MypartCubeRain.TP_Nil_Position[2]:=0;
                                MypartCubeRain.TP_Nil_Color[0]:=1.0;  //1
                                MypartCubeRain.TP_Nil_Color[1]:=0.21;  //1
                                MypartCubeRain.TP_Nil_Color[2]:=0.01;  //1
                                MypartCubeRain.TP_Nil_Color[3]:=0.8;
                                MypartCubeRain.TP_Nil_Size:=1.5;//6.5;//10
                                MypartCubeRain.TP_Density:=1;//100
                                MypartCubeRain.ISIF:=true;
                                MypartCubeRain.Count:=0;
                                MypartCubeRain.MAXCount:=100;

                                MypartCubeRain.TP_random:=2;
                                MypartCubeRain.TP_random1:=2;
                                MypartCubeRain.TP_random2:=2;

                                MypartCubeRain.TP_randomC :=9;
                                MypartCubeRain.TP_randomC1:=11;
                                MypartCubeRain.TP_randomC2:=13;

                                MypartCubeRain.TP_Nil_Rotate[0]:=ElapsedTime;
                                MypartCubeRain.TP_Nil_Rotate[1]:=ElapsedTime;
                                MypartCubeRain.TP_Nil_Rotate[2]:=ElapsedTime;
                                MypartCubeRain.TP_Check_Rotate[0]:=6;
                                MypartCubeRain.TP_Check_Rotate[1]:=7;
                                MypartCubeRain.TP_Check_Rotate[2]:=5;
                                MypartCubeRain.TP_Check_Size:=0.01;
                                MypartCubeRain.TP_Check_Napr[0]:=0;
                                MypartCubeRain.TP_Check_Napr[1]:=0.07;
                                MypartCubeRain.TP_Check_Napr[2]:=0;
                                MypartCubeRain.TP_Check_Color[0]:=0.0;
                                MypartCubeRain.TP_Check_Color[1]:=0.0;
                                MypartCubeRain.TP_Check_Color[2]:=0.0;
                                MypartCubeRain.TP_Check_Color[3]:=0.007;

//                                 for i:=1 to 5 do
                                    MypartCubeRain.Add_particle(1);//i
                                          {}
                                ScenesOptTrig := not ScenesOptTrig;   //true
                        end;
                        MypartCubeRain.Change_particle;
                end;
                8,9,10:begin
                        MypartCubeRain.Change_particle;
                        if ScenesOptTrig then begin        //true
                                glFogf(GL_FOG_END, 80.0);
                                ScenesOptTrig := not ScenesOptTrig;
                        end;
                end;
                11:begin
                        MypartCubeRain.Change_particle;
                end;
                12:begin
                        MypartCubeRain.Change_particle;
                        if not ScenesOptTrig then       //false
                        begin
                                MypartCubeRain.Destroy;
                                MypartCubeRain:=TP_Particle.Create;
                                 MypartCubeRain.TP_Nil_Position[0]:=0;
                                 MypartCubeRain.TP_Nil_Position[1]:=25;
                                 MypartCubeRain.TP_Nil_Position[2]:=0;
                                 MypartCubeRain.TP_Nil_Color[0]:=0.81;  //1
                                 MypartCubeRain.TP_Nil_Color[1]:=0.83;  //1
                                 MypartCubeRain.TP_Nil_Color[2]:=0.79;  //1
                                 MypartCubeRain.TP_Nil_Color[3]:=0.4;
                                 MypartCubeRain.TP_Nil_Size:=1;//6.5;//10
                                 MypartCubeRain.TP_Density:=10;//100
                                 MypartCubeRain.ISIF:=true;
                                 MypartCubeRain.Count:=0;
                                 MypartCubeRain.MAXCount:=100;
                                
                                 MypartCubeRain.TP_random:=50;
                                 MypartCubeRain.TP_random1:=3;
                                 MypartCubeRain.TP_random2:=50;
                                
                                 MypartCubeRain.TP_randomC :=33;
                                 MypartCubeRain.TP_randomC1:=27;
                                 MypartCubeRain.TP_randomC2:=12;
                                
                                 MypartCubeRain.TP_Nil_Rotate[0]:=ElapsedTime;
                                 MypartCubeRain.TP_Nil_Rotate[1]:=ElapsedTime;
                                 MypartCubeRain.TP_Nil_Rotate[2]:=ElapsedTime;
                                 MypartCubeRain.TP_Check_Rotate[0]:=5;
                                 MypartCubeRain.TP_Check_Rotate[1]:=7;
                                 MypartCubeRain.TP_Check_Rotate[2]:=5;
                                 MypartCubeRain.TP_Check_Size:=0; //razmer
                                 MypartCubeRain.TP_Check_Napr[0]:=0;
                                 MypartCubeRain.TP_Check_Napr[1]:=-0.2;
                                 MypartCubeRain.TP_Check_Napr[2]:=0;
                                 MypartCubeRain.TP_Check_Color[0]:=0.0;
                                 MypartCubeRain.TP_Check_Color[1]:=0.0;
                                 MypartCubeRain.TP_Check_Color[2]:=0.0;
                                 MypartCubeRain.TP_Check_Color[3]:=0.007; // razmer
                                
                                 for i:=1 to 5 do
                                    MypartCubeRain.Add_particle(i);
                                          {}
                                ScenesOptTrig := not ScenesOptTrig;   //true
                                glFogf(GL_FOG_END, 100.0);//30
                        end;
                end;
                13:begin
                        if ScenesOptTrig then begin      //true
//                              q := 0.8;
                              q := q+0.1;
                              ScenesOptTrig:=not ScenesOptTrig;
                        end;
                                ;
                                MypartCubeRain.Change_particle;
                end;
                14:begin

                end;
                15:begin
                        if not ScenesOptTrig then begin      //true
{!!!!!!}                              q:=0.8;
                                 { }
                                fogColor[0]:=0.09;//0.09, 0.08, 0.09, 1.0
                                fogColor[1]:=0.08;
                                fogColor[2]:=0.09;
                                fogColor[3]:=1;
                                    
                                glEnable(GL_FOG); // включаем режим тумана
                                glFogi(GL_FOG_MODE, GL_LINEAR); // задаем закон смешени€ тумана
                                glFogfv(GL_FOG_COLOR, @fogColor); // цвет дымки
                                glFogf(GL_FOG_DENSITY, 1); // плотность тумана
                                glHint(GL_FOG_HINT, GL_NICEST);// предпочтений к работе тумана нет

                                glFogf(GL_FOG_START, 0.0); // ближн€€ плоскость дл€ линейного
                                glFogf(GL_FOG_END, 50.0); // дальн€€ плоскость дл€ линейного
                                {}

                                ElapsedTime_1:=ElapsedTime;
                                glFogf(GL_FOG_START, 145.0); //0.0
                                glFogf(GL_FOG_END, 300.0);//30
                  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
                              ScenesOptTrig:=not ScenesOptTrig;

                        end;
                end;
                16:begin
                        if ScenesOptTrig then begin      //true
                                ElapsedTime_1:=ElapsedTime;
                                glFogf(GL_FOG_START, 200.0); //0.0
                                glFogf(GL_FOG_END, 400.0);//30
                  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
                              ScenesOptTrig:=not ScenesOptTrig;
                        end;
                end;
                17:begin
                        if not ScenesOptTrig then begin      //true
//                                q:=0.9;
                              q := q+0.1;
                                glFogf(GL_FOG_END, 700.0);//30
                              ScenesOptTrig:=not ScenesOptTrig;
                        end;
                end;
                18:begin
                        if ScenesOptTrig then begin      //true
                                glFogf(GL_FOG_END, 500.0);//30
                              ScenesOptTrig:=not ScenesOptTrig;
                        end;
                end;
                19:begin
                        if not ScenesOptTrig then begin      //true
                              q := q-0.2;
                                glFogf(GL_FOG_START, 10);//30
                                glFogf(GL_FOG_END, 200.0);//30
                                glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
                                glDisable(GL_LIGHT1);
                              ScenesOptTrig:=not ScenesOptTrig;

                                 { 
                                fogColor[0]:=0.09;//0.09, 0.08, 0.09, 1.0
                                fogColor[1]:=0.08;
                                fogColor[2]:=0.09;
                                fogColor[3]:=1;
                                    
                                glEnable(GL_FOG); // включаем режим тумана
                                glFogi(GL_FOG_MODE, GL_LINEAR); // задаем закон смешени€ тумана
                                glFogfv(GL_FOG_COLOR, @fogColor); // цвет дымки
                                glFogf(GL_FOG_DENSITY, 1); // плотность тумана
                                glHint(GL_FOG_HINT, GL_NICEST);// предпочтений к работе тумана нет

                                glFogf(GL_FOG_START, 10.0); // ближн€€ плоскость дл€ линейного
                                glFogf(GL_FOG_END, 200.0); // дальн€€ плоскость дл€ линейного
                                {}


                        end;

                        glFogf(GL_FOG_END, 175.0-NowRow*2);//30
                end;
                20:begin
                        if ScenesOptTrig then begin      //true
                              q := 0.3;
                                glDisable(GL_FOG);
                              ScenesOptTrig:=not ScenesOptTrig;
                        end;
                end;
                21:begin
                        if NowRow >=60 then begin
                                _FMUSIC_StopSong(Module);
                                Halt(0);
                        end;
                end;
        end;
end;

procedure PreSceneCubeRain;
var
i:integer;
begin
 MypartCubeRain:=TP_Particle.Create;
 MypartCubeRain.TP_Nil_Position[0]:=0;
 MypartCubeRain.TP_Nil_Position[1]:=15;
 MypartCubeRain.TP_Nil_Position[2]:=0;
 MypartCubeRain.TP_Nil_Color[0]:=0.51;  //1
 MypartCubeRain.TP_Nil_Color[1]:=0.71;  //1
 MypartCubeRain.TP_Nil_Color[2]:=0.21;  //1
 MypartCubeRain.TP_Nil_Color[3]:=1;
 MypartCubeRain.TP_Nil_Size:=1;//6.5;//10
 MypartCubeRain.TP_Density:=10;//100
 MypartCubeRain.ISIF:=true;
 MypartCubeRain.Count:=0;
 MypartCubeRain.MAXCount:=100;

 MypartCubeRain.TP_random:=30;
 MypartCubeRain.TP_random1:=3;
 MypartCubeRain.TP_random2:=30;

 MypartCubeRain.TP_randomC :=33;
 MypartCubeRain.TP_randomC1:=27;
 MypartCubeRain.TP_randomC2:=12;

 MypartCubeRain.TP_Nil_Rotate[0]:=ElapsedTime;
 MypartCubeRain.TP_Nil_Rotate[1]:=ElapsedTime;
 MypartCubeRain.TP_Nil_Rotate[2]:=ElapsedTime;
 MypartCubeRain.TP_Check_Rotate[0]:=5;
 MypartCubeRain.TP_Check_Rotate[1]:=7;
 MypartCubeRain.TP_Check_Rotate[2]:=5;
 MypartCubeRain.TP_Check_Size:=0; //razmer
 MypartCubeRain.TP_Check_Napr[0]:=0;
 MypartCubeRain.TP_Check_Napr[1]:=-0.2;
 MypartCubeRain.TP_Check_Napr[2]:=0;
 MypartCubeRain.TP_Check_Color[0]:=0.0;
 MypartCubeRain.TP_Check_Color[1]:=0.0;
 MypartCubeRain.TP_Check_Color[2]:=0.0;
 MypartCubeRain.TP_Check_Color[3]:=0.007; // razmer

 for i:=1 to 1 do
    MypartCubeRain.Add_particle(i);
end;

procedure SceneCubeRain;
begin
       glTranslatef(0,0,-30);
        if NowOrder<=1 then
        begin
         MypartCubeRain.Draw_particle;
        end
         else
          MypartCubeRain.Destroy;
end;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
procedure CubeVetka;
begin

  glTranslatef(0,0.5,0);
  glColor4f(0.017,0.2,0.07,1);//0.6,0.3,0.05,1
  glutSolidCube(0.45);

  glTranslatef(0,0.5,0);
  glRotatef(12,1,1,0);    //  !
  glScale(1,1.5,1);
  glColor4f(0.1,0.2,0.06,1);
  glutSolidCube(0.4);

  glScale(1,0.8,1);
  glTranslatef(0,0.4,0);
  glRotatef(15,0,1,0);       // !
  glColor4f(0.19,0.27,0.06,1);
  glutSolidCube(0.37);

  glTranslatef(-0.1,0.35,0);
  glRotatef(10,0,1,1);
  glColor4f(0.25,0.3,0.06,1);
  glutSolidCube(0.35);

  glTranslatef(-0.1,0.34,0);
  glRotatef(15,0,1,1);
  glColor4f(0.22,0.32,0.05,1);
  glutSolidCube(0.31);

  glTranslatef(-0.1,0.25,0);
  glRotatef(15,0,1,1);
  glColor4f(0.25,0.33,0.06,1);
  glutSolidCube(0.3);

    glTranslatef(-0.1,0.25,0);
  glRotatef(10,0,1,0);
  glColor4f(0.27,0.35,0.06,1);
  glutSolidCube(0.29);

    glTranslatef(-0.1,0.25,0);
  glRotatef(15,0,1,1);
  glColor4f(0.3,0.37,0.06,1);
  glutSolidCube(0.27);

    glTranslatef(-0.1,0.25,0);
  glRotatef(15,0,1,1);
  glColor4f(0.29,0.35,0.06,1);
  glutSolidCube(0.25);

    glTranslatef(-0.15,0.25,0);
  glRotatef(15,0,1,1);
  glColor4f(0.3,0.33,0.06,1);
  glutSolidCube(0.25);
                               //
      glTranslatef(-0.15,0.25,0);
  glRotatef(15,0,1,1);
  glColor4f(0.25,0.33,0.06,1);
  glutSolidCube(0.25);

      glTranslatef(-0.15,0.25,0);
  glRotatef(15,0,1,1);
  glColor4f(0.27,0.35,0.06,1);
  glutSolidCube(0.25);

      glTranslatef(-0.15,0.25,0);
  glRotatef(15,0,1,1);
  glColor4f(0.3,0.37,0.06,1);
  glutSolidCube(0.25);

      glTranslatef(-0.15,0.25,0);
  glRotatef(15,0,1,1);
  glColor4f(0.29,0.35,0.06,1);
  glutSolidCube(0.24);
                               //
      glTranslatef(-0.1,0.25,0);
  glRotatef(10,0,1,-1);
  glColor4f(0.3,0.33,0.06,1);
  glutSolidCube(0.24);

      glTranslatef(-0.1,0.25,0);
  glRotatef(10,0,1,-1);
  glColor4f(0.2,0.27,0.06,1);
  glutSolidCube(0.24);

      glTranslatef(-0.1,0.25,0);
  glRotatef(10,0,1,-1);
  glColor4f(0.2,0.25,0.09,1);
  glutSolidCube(0.25);

      glTranslatef(-0.1,0.25,0);
  glRotatef(10,0,1,-1);
  glColor4f(0.22,0.273,0.06,1);
  glutSolidCube(0.24);
                               //
      glTranslatef(-0.1,0.25,0);
  glRotatef(10,0,1,-1);
  glColor4f(0.23,0.3,0.06,1);
  glutSolidCube(0.23);

      glTranslatef(-0.1,0.25,0);
  glRotatef(10,0,1,-1);
  glColor4f(0.25,0.33,0.06,1);
  glutSolidCube(0.23);

      glTranslatef(-0.1,0.22,0);
  glRotatef(10,0,1,-1);
  glColor4f(0.27,0.35,0.06,1);
  glutSolidCube(0.22);

      glTranslatef(-0.1,0.22,0);
  glRotatef(10,0,1,-1);
  glColor4f(0.28,0.36,0.06,1);
  glutSolidCube(0.22);
                               //
      glTranslatef(-0.1,0.23,0);
  glRotatef(10,0,1,-1);
  glColor4f(0.22,0.29,0.06,1);
  glutSolidCube(0.21);

      glTranslatef(-0.1,0.21,0);
  glRotatef(10,0,1,-1);
  glColor4f(0.23,0.27,0.06,1);
  glutSolidCube(0.21);

      glTranslatef(-0.1,0.2,0);
  glRotatef(10,0,1,-1);
  glColor4f(0.24,0.28,0.06,1);
  glutSolidCube(0.21);

      glTranslatef(-0.1,0.2,0);
  glRotatef(10,0,1,-1);
  glColor4f(0.25,0.25,0.06,1);
  glutSolidCube(0.21);
                               //
      glTranslatef(-0.1,0.2,0);
  glRotatef(10,0,1,-1);
  glColor4f(0.27,0.23,0.06,1);
  glutSolidCube(0.2);

      glTranslatef(-0.1,0.2,0);
  glRotatef(10,0,1,-1);
  glColor4f(0.24,0.25,0.06,1);
  glutSolidCube(0.2);

      glTranslatef(-0.1,0.2,0);
  glRotatef(10,0,1,-1);
  glColor4f(0.2,0.2,0.06,1);
  glutSolidCube(0.2);

      glTranslatef(-0.1,0.2,0);
  glRotatef(10,0,1,-1);
  glColor4f(0.18,0.2,0.06,1);
  glutSolidCube(0.2);
                               //
      glTranslatef(-0.1,0.2,0);
  glRotatef(10,0,1,-1);
  glColor4f(0.17,0.23,0.06,1);
  glutSolidCube(0.19);

      glTranslatef(-0.1,0.17,0);
  glRotatef(10,0,1,-1);
  glColor4f(0.15,0.25,0.06,1);
  glutSolidCube(0.18);

      glTranslatef(-0.1,0.15,0);
  glRotatef(10,0,1,-1);
  glColor4f(0.1,0.3,0.06,1);
  glutSolidCube(0.15);

      glTranslatef(-0.1,0.08,0);
  glRotatef(10,0,1,-1);
  glColor4f(0.9,1,0.06,1);
  glutSolidCube(0.1);
                           {  LAMP
//      glTranslatef(-0.1,0.08,0);
  glRotatef(myrow_,1,1,-1);
  glColor4f(0.9,1,0.06,0.015);
  glutSolidCube(0.3);
                          {}
end;

procedure SceneCubeTree;
begin
          glTranslatef(4,0,-10);//-10

           case NowOrder of     //order+2
                2:if NowRow<48 then
                        begin
                         Transl :=-(ElapsedTime-ElapsedTime_)*0.001;
                         glTranslatef(0,Transl,0)
                        end
                   else
                        begin
//                                  glTranslatef(6,Transl+5,0);
//                                  glRotatef(45,0,1,0);
                                  glTranslatef(6-(ElapsedTime-ElapsedTime_)*0.0013,Transl+5-abs(6*sin((ElapsedTime-ElapsedTime_)*0.0003)),-0);
                        end;
                3:if NowRow<20 then
                        begin
//                                  glTranslatef(6,Transl+5,0);
//                                  glTranslatef(-(ElapsedTime-ElapsedTime_)*0.0013,-abs(6*sin((ElapsedTime-ElapsedTime_)*0.0003)),-0);
                                  glTranslatef(6-(ElapsedTime-ElapsedTime_)*0.0013,Transl+5-abs(6*sin((ElapsedTime-ElapsedTime_)*0.0003)),-0);
//                                  Tr1:=-(ElapsedTime-ElapsedTime_)*0.0013;
//                                  Tr2:=abs(6*sin((ElapsedTime-ElapsedTime_)*0.0003));
                        end
                  else
                        begin
                                 glTranslatef(10,Transl+5,0);
                                 glTranslatef(-(ElapsedTime-ElapsedTime_)*0.0013,Transl,-0);
                                 glRotatef(45,0,1,0);
                        end;
                4:if NowRow < 30 then
                        begin
                                 glTranslatef(10,Transl+5,0);
                                 glTranslatef(-(ElapsedTime-ElapsedTime_)*0.0013,Transl,-0);
                                 glRotatef(45,0,1,0);
                        end
                  else                        
                        begin
//                                 Transl :=-(ElapsedTime-ElapsedTime_)*0.0001;
                                 glTranslatef(0,Transl,0);
                                 glRotatef(45,0,1,0);

                        end;

//                5:glRotatef(-ElapsedTime*0.008,0,1,0);// rotate tree
           end;
                       { }
          glRotatef(ElapsedTime*0.01,0,1,0);// rotate tree
                      {}

          glPushMatrix;
           Mypart.Draw_particle;
           glCallList(1);
          glPopMatrix;
end;

procedure PreSceneCubeTree;
var i:Integer;
begin
  glNewList(1,GL_COMPILE);
        PreSceneBUILDCubeTree;
  glEndList; 

 Mypart:=TP_Particle.Create;
 Mypart.TP_Nil_Position[0]:=0;
 Mypart.TP_Nil_Position[1]:=7;
 Mypart.TP_Nil_Position[2]:=0;

 Mypart.TP_Nil_Color[0]:=0.525;
 Mypart.TP_Nil_Color[1]:=0.750;
 Mypart.TP_Nil_Color[2]:=0.240;
 Mypart.TP_Nil_Color[3]:=1.00;

 Mypart.TP_Nil_Size:=0.2;//6.5;//10
 Mypart.TP_Density:=2;//100
 Mypart.ISIF:=true;
 Mypart.Count:=0;
 Mypart.MAXCount:=100;
 Mypart.TP_random:=8;
 Mypart.TP_random1:=1;
 Mypart.TP_random2:=8;

 Mypart.TP_randomC :=25;
 Mypart.TP_randomC1:=34;
 Mypart.TP_randomC2:=12;

 Mypart.TP_Nil_Rotate[0]:=0;
 Mypart.TP_Nil_Rotate[1]:=0;
 Mypart.TP_Nil_Rotate[2]:=0;
 Mypart.TP_Check_Rotate[0]:=5;
 Mypart.TP_Check_Rotate[1]:=7;
 Mypart.TP_Check_Rotate[2]:=1;
 Mypart.TP_Check_Size:=0; //razmer
 Mypart.TP_Check_Napr[0]:=0;
 Mypart.TP_Check_Napr[1]:=-0.051;
 Mypart.TP_Check_Napr[2]:=0;
 Mypart.TP_Check_Color[0]:=0.0;
 Mypart.TP_Check_Color[1]:=0.0;
 Mypart.TP_Check_Color[2]:=0.0;
 Mypart.TP_Check_Color[3]:=0.005; // razmer
                            
for i:=1 to 1 do
Mypart.Add_particle(i);

end;

procedure PreSceneBUILDCubeTree;

begin


  glPushMatrix;
  {
        glColor3f(0.51,0.611,0.319);
        glTranslatef(40,16,10);
        glRotatef(45,1,0,0);
        glRotatef(55,0,0,1);
        glutSolidCube(20);
  }
        glRotatef(-145,0,1,0);

        glTranslatef(40,19,10);
        glRotatef(45,1,0,1);
        glRotatef(10,0,0,1);
  //      glutSolidCube(20);

        glRotatef(-10,0,0,1);
        glRotatef(-45,1,0,1);

        glColor3f(0.21,0.31,0.719);
        glTranslatef(-40,-3,70);
        glRotatef(45,1,0,1);
        glRotatef(10,0,0,1);
//        glutSolidCube(15);

        glRotatef(-10,0,0,1);        
        glRotatef(-45,1,0,1);

        glColor3f(0.17,0.771,0.6119);
        glTranslatef(-20,-3,50);
        glRotatef(45,1,0,1);
        glRotatef(10,0,0,1);
//        glutSolidCube(15);

        glRotatef(-10,0,0,1);
        glRotatef(-45,1,0,1);

        glColor3f(0.481,0.511,0.719);
        glTranslatef(-35,6,-67);
        glRotatef(45,1,0,1);
        glRotatef(10,0,0,1);
        glutSolidCube(10);

        glRotatef(-10,0,0,1);
        glRotatef(-45,1,0,1);

        glColor3f(0.31,0.341,0.319);
        glTranslatef(-17,0,-54);
        glRotatef(45,1,0,1);
        glRotatef(10,0,0,1);
        glutSolidCube(21);

        glRotatef(-10,0,0,1);
        glRotatef(-45,1,0,1);

        glColor3f(0.23,0.511,0.319);
        glTranslatef(-15,-6,-23);
        glRotatef(45,1,0,1);
        glRotatef(10,0,0,1);
        glutSolidCube(7);

        glRotatef(-10,0,0,1);        
        glRotatef(-45,1,0,1);

        glColor3f(0.23,0.721,0.41);
        glTranslatef(45,-3,80);
        glRotatef(45,1,0,1);
        glRotatef(10,0,0,1);
        glutSolidCube(7.5);

        glRotatef(-10,0,0,1);        
        glRotatef(-45,1,0,1);

        glColor3f(0.23,0.41,0.51);
        glTranslatef(-25,0,-27);
        glRotatef(-45,1,0,1);
        glRotatef(-10,0,0,1);
        glutSolidCube(7.5);
                              //
        glRotatef(10,0,0,1);
        glRotatef(45,1,0,1);
                                   {
        glTranslatef(-70,0,-100); 
        glTranslatef(-30,13,-40);
                                  }
        glColor3f(0.723,0.541,0.451);
//        glTranslatef(120,-4,40);
        glTranslatef(20,13,-100);

        glRotatef(45,1,0,1);
        glRotatef(10,0,0,1);
        glutSolidCube(10.5);

  glPopMatrix;


// glEnable (GL_COLOR_MATERIAL);
          glColor3f(0.1,0.11,0.19);
          glBegin(GL_TRIANGLE_STRIP);
//          glNormal3f(0,0,-1);
            glVertex3f(-100,-0.55,-100);
            glVertex3f(100,-0.55,-100);
            glVertex3f(-100,-0.55,100);
            glVertex3f(100,-0.55,100);
          glEnd;

glPushMatrix;
  //stvol
  glRotatef(30,0,1,0);
//  glColor4f(0.4, 0.1, 0.02,1);
  glColor4f(0.4, 0.1, 0.02,1);
  glutSolidCube(1);                  glColor4f(0.4, 0.1, 0.02,0.5);glutSolidCube(1.1);

  glTranslatef(0,0.92,0);            
  glRotatef(-3,0,1,0);
  glColor4f(0.42,0.12,0.023,1);
  glutSolidCube(0.95);               glColor4f(0.42,0.12,0.023,0.5);glutSolidCube(1.05);

  glTranslatef(0,0.94,0);            
  glRotatef(-3,0,1,0);
  glColor4f(0.45,0.15,0.025,1);
  glutSolidCube(0.9);               glColor4f(0.45,0.15,0.025,0.5);glutSolidCube(0.97);

  glTranslatef(0,0.88,0);
  glRotatef(-4,0,1,0);
  glColor4f(0.47,0.18,0.027,1);
  glutSolidCube(0.87);              glColor4f(0.47,0.18,0.027,0.5);glutSolidCube(0.91);

  glTranslatef(0,0.88,0);
  glRotatef(-5,0,1,0);
  glColor4f(0.48,0.2,0.029,1);
  glutSolidCube(0.83);               glColor4f(0.48,0.2,0.029,0.5);glutSolidCube(0.9);

  glTranslatef(0,0.88,0);
  glRotatef(-6,0,1,0);
  glColor4f(0.5,0.25,0.03,1);
  glutSolidCube(0.8);               glColor4f(0.5,0.25,0.03,0.5);glutSolidCube(0.9);

  glTranslatef(0,0.82,0);
  glRotatef(-7,0,1,0);
  glColor4f(0.45,0.27,0.032,1);
  glutSolidCube(0.77);                glColor4f(0.45,0.27,0.032,0.5);glutSolidCube(0.84);

  glTranslatef(0,0.77,0);
  glRotatef(-7,0,1,0);
  glColor4f(0.4,0.3,0.035,1);
  glutSolidCube(0.7);               glColor4f(0.4,0.3,0.035,0.5);glutSolidCube(0.8);

  glTranslatef(0,0.72,0);
  glRotatef(-8,0,1,0);
  glColor4f(0.2,0.2,0.04,1);
  glutSolidCube(0.63);               glColor4f(0.2,0.2,0.04,0.5);glutSolidCube(0.71);

  //vetki
        //serdce
  glTranslatef(0,0.4,0);
  glRotatef(45,1,0,1);
  glColor4f(0.6,0.3,0.05,1);
  glutSolidCube(0.6);
        //1
 glPushMatrix;
 CubeVetka;
 glPopMatrix;
 glPushMatrix;
  glRotatef(90,-1,0,1);
 CubeVetka;
 glPopMatrix;
 glPushMatrix;
  glRotatef(90,-1,0,1);
  glRotatef(90,-1,0,0);
 CubeVetka;
 glPopMatrix;
 glPushMatrix;
  glRotatef(90,-1,0,1);
  glRotatef(180,-1,0,0);  
 CubeVetka;
 glPopMatrix;

 glPushMatrix;
  glRotatef(45,-1,0,1);
  glRotatef(180,-1,0,0);
 CubeVetka;
 glPopMatrix;
 glPushMatrix;
  glRotatef(-45,-1,0,1);
 CubeVetka;
 glPopMatrix;
 glPushMatrix;
  glRotatef(-45,-1,0,1);
  glRotatef(0,1,0,0);
 CubeVetka;
 glPopMatrix;
 glPushMatrix;
  glRotatef(130,-1,0,1);
 CubeVetka;
 glPopMatrix;
 glPushMatrix;
  glRotatef(-95,0,0,1);
 CubeVetka;
 glPopMatrix;
 glPushMatrix;
  glRotatef(-50,0,0,1);
 CubeVetka;
 glPopMatrix;       {}
 glPushMatrix;
  glRotatef(45,-1,0,1);
 CubeVetka;
 glPopMatrix;       {}
 glPushMatrix;
  glRotatef(180,0,1,0);
  glRotatef(-70,-1,0,-1);
 CubeVetka;
 glPopMatrix;
 glPushMatrix;
  glRotatef(240,0,1,0);
  glRotatef(-70,-1,0,-1);
 CubeVetka;
 glPopMatrix;
 glPushMatrix;
  glRotatef(200,0,1,0);
  glRotatef(-90,-1,0,-1);
 CubeVetka;
 glPopMatrix;
  glPushMatrix;
  glRotatef(140,0,1,0);
  glRotatef(-90,-1,0,-1);
 CubeVetka;
 glPopMatrix;
 glPushMatrix;
  glRotatef(-10,0,1,0);
  glRotatef(-30,-1,0,-1);
 CubeVetka;
 glPopMatrix;

glPopMatrix;

end;

procedure PreSceneCubeFire;
var i:Byte;
begin
 glNewList(2,GL_COMPILE);
  glPushMatrix;
       glTranslatef(0,-2,0);

          glColor3f(0.1,0.11,0.19);
          glBegin(GL_TRIANGLE_STRIP);
//          glNormal3f(0,0,-1);
            glVertex3f(-50,0,-50);
            glVertex3f(50,0,-50);
            glVertex3f(-50,0,50);
            glVertex3f(50,0,50);
          glEnd;

               glTranslatef(20,6.4,0);
               glRotatef(45,1,0,1);
               glRotatef(5,1,0,0);
                  glutSolidCube(7.5);
               glRotatef(-5,1,0,0);
               glRotatef(-45,1,0,1);
               glTranslatef(-20,-6.4,0);
               glTranslatef(30,10,20);
               glRotatef(45,1,0,1);
               glRotatef(5,1,0,0);
                  glutSolidCube(10);
               glRotatef(-5,1,0,0);
               glRotatef(-45,1,0,1);
               glTranslatef(-30,-10,-20);
          glColor3f(0.1,0.2,0.11);
               glTranslatef(-35,6.4,0);
               glRotatef(45,1,0,1);
               glRotatef(5,1,0,0);
                  glutSolidCube(7.5);
               glRotatef(-5,1,0,0);
               glRotatef(-45,1,0,1);
               glTranslatef(35,-6.4,0);

          glColor3f(0.8,0.1,0.11);
               glTranslatef(5,11,-37);
               glRotatef(55,1,0,1);
               glRotatef(5,1,0,0);
                  glutSolidCube(12.5);
               glRotatef(-5,1,0,0);
               glRotatef(-55,1,0,1);
               glTranslatef(-5,-11,37);   //glMap1f
               
               {
               glTranslatef(5,11,-30);
               glRotatef(55,1,0,1);
               glRotatef(5,1,0,0);
                  glutSolidCube(12.5);
               glRotatef(-5,1,0,0);
               glRotatef(-55,1,0,1);
               glTranslatef(-5,-11,30);
               }

          glColor3f(0.7,0.11,0.1);
               glTranslatef(20,5,-35);
               glRotatef(55,1,0,1);
               glRotatef(5,1,0,0);
                  glutSolidCube(5);
               glRotatef(-5,1,0,0);
               glRotatef(-55,1,0,1);
               glTranslatef(-20,-5,35);

       glTranslatef(0,0.1,0);
       glColor3f(0.18,0.13,0.02);
       for i:=0 to 5 do
       begin
               glRotatef(60,0,1,0);
               glTranslatef(2,0,0);
               glScalef(2.35,0.23,0.5);
                  glutSolidCube(1);
               glScalef(0.42553,4.3478,2);
               glTranslatef(-2,0,0);
       end;

               glRotatef(15,0,1,0);
       for i:=0 to 5 do
       begin
               glRotatef(60,0,1,0);
               glTranslatef(2,0,0);
               glScalef(2.35,0.23,0.5);
                  glutSolidCube(1);
               glScalef(0.42553,4.3478,2);
               glTranslatef(-2,0,0);
       end;
  glPopMatrix;
 glEndList;
end;

procedure SceneCubeFire;
begin
        glTranslatef(0,0,-15);
          glRotatef(ElapsedTime*0.01,0,1,0);

          glBlendFunc(GL_SRC_ALPHA, GL_DST_ALPHA);
        MypartCubeRain.Draw_particle;
        //pomenyat mestami
          glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        glCallList(2); 
end;

procedure SceneCubeFire_STOP;
begin
//          glRotatef(ElapsedTime*0.05,0,1,0);//com
        if NowRow<=32 then begin
        glTranslatef(7,5,5);
          glRotatef(140,0,1,0);
          glBlendFunc(GL_SRC_ALPHA, GL_DST_ALPHA);
        MypartCubeRain.Draw_particle;
          glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        glCallList(2);
        end else begin
        glTranslatef(0,5,-10);
          glRotatef(170,0,1,0);
          glBlendFunc(GL_SRC_ALPHA, GL_DST_ALPHA);
        MypartCubeRain.Draw_particle;
          glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        glCallList(2);
        end;
end;
procedure SceneCubeFire_STOP1;
begin
        if NowRow<=32 then begin
        glTranslatef(0,5,-25);
          glRotatef(140,0,1,0);
          glBlendFunc(GL_SRC_ALPHA, GL_DST_ALPHA);
        MypartCubeRain.Draw_particle;
          glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        glCallList(2);
        end else begin
        glTranslatef(0,5,-25);
          glRotatef(90,0,1,0);
//          glRotatef(-30,1,0,0);
          glBlendFunc(GL_SRC_ALPHA, GL_DST_ALPHA);
        MypartCubeRain.Draw_particle;
          glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        glCallList(2);
        end;
end;

procedure PreSceneRise;
var i,j,k:Byte;
begin
  glNewList(3,GL_COMPILE);
       glLineWidth(3);
       {}
       glColor3f(0.85, 0.70, 0.20);
       for j:=0 to 7 do begin
        glRotatef(j*45,0,1,0);
        glTranslatef(-4,2,0);
        glRotatef(60,0,0,1);
         glBegin(GL_LINE_STRIP);
           For i := 6 to LenghtCurve do begin
             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
           end;
         glEnd;
        glRotatef(-60,0,0,1);
        glTranslatef(4,-2,0);
       end;

       glColor3f(0.70, 0.60, 0.20);
       for j:=0 to 7 do begin
        glRotatef(j*45,0,1,0);
        glTranslatef(-4,0,0);
        glRotatef(60,0,0,1);
        glRotatef(90,0,1,0);
         glBegin(GL_LINE_STRIP);
           For i := 6 to LenghtCurve do begin
             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
           end;
         glEnd;
        glRotatef(-90,0,1,0);
        glRotatef(-60,0,0,1);
        glTranslatef(4,0,0);
       end;

       glColor3f(0.65, 0.70, 0.150);
       glTranslatef(0,-1.9,0);
       for j:=0 to 7 do begin
        glRotatef(j*45,0,1,0);
        glTranslatef(-6,0,0);
        glRotatef(120,0,1,0);
        glRotatef(-90,1,0,0);
         glBegin(GL_LINE_STRIP);
           For i := 6 to LenghtCurve do begin
             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
           end;
         glEnd;
        glRotatef(90,1,0,0);
        glRotatef(-120,0,1,0);
        glTranslatef(6,0,0);
       end;
                   {}
       glColor3f(0.90, 0.60, 0.20);
       glTranslatef(0,-1.9,0);
       for j:=0 to 7 do begin
        glRotatef(j*45,0,1,0);
        glTranslatef(5,10,0);
        glRotatef(-60,0,0,1);
         glBegin(GL_LINE_STRIP);
           For i := 0 to LenghtCurve do begin
             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
           end;
         glEnd;
        glRotatef(60,0,0,1);
        glTranslatef(-5,-10,0);
       end;
                 {
       glLineWidth(10);
       glBegin(GL_LINES);
        glColor3f(0.9,0.9,0);
         glVertex3f(0,0,0);
         glVertex3f(0,64*0.2,0);
       glend;
                   }
  glEndList;

  glNewList(4,GL_COMPILE);
     glRotatef(70,0,1,0);
//      glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
       glScalef(2,1,2);
       glColor3f(0.35,0.0,0.0);
       glLineWidth(10);
       for j:=0 to 7 do begin
        glRotatef(j*45,0,1,0);
        glTranslatef(-4,0,0);
        glRotatef(60,0,0,1);
        glRotatef(90,0,1,0);
         glBegin(GL_LINE_STRIP);
           For i := 6 to LenghtCurve do begin
             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
             {
       glColor3f(1,0,0);
             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
       glColor3f(0,1,0);
             glVertex3f(ctrlpoints[i][0]*10,ctrlpoints[i][1]*10,ctrlpoints[i][2]*10);
             }
           end;
         glEnd;
        glRotatef(-90,0,1,0);
        glRotatef(-60,0,0,1);
        glTranslatef(4,0,0);
       end;

       glScalef(1.25,1,1.25);
//       glScalef(1/0.8,1,1/0.8);

       glColor3f(0.45,0.05,0.01);
        glTranslatef(0,-1,0);
       for j:=0 to 7 do begin
        glRotatef(j*45,0,1,0);
        glTranslatef(-4,0,0);
        glRotatef(60,0,0,1);
        glRotatef(90,0,1,0);
         glBegin(GL_LINE_STRIP);
           For i := 6 to LenghtCurve do begin
             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
           end;
         glEnd;
        glRotatef(-90,0,1,0);
        glRotatef(-60,0,0,1);
        glTranslatef(4,0,0);
       end;

       glScalef(1.3333333333,1,1.3333333333);
       glColor3f(0.7,0.05,0.01);
        glTranslatef(0,-0.5,0);
       for j:=0 to 7 do begin
        glRotatef(j*45,0,1,0);
        glTranslatef(-4,0,0);
        glRotatef(60,0,0,1);
        glRotatef(90,0,1,0);
         glBegin(GL_LINE_STRIP);
           For i := 6 to LenghtCurve do begin
             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
           end;
         glEnd;
        glRotatef(-90,0,1,0);
        glRotatef(-60,0,0,1);
        glTranslatef(4,0,0);
       end;
  glEndList;
  
  glNewList(5,GL_COMPILE);
                        glTranslatef(-50,0,-25);
                          glPushMatrix;
                           glCallList(3);
                           glCallList(4);
                          glPopMatrix;
                        glTranslatef(100,0,0);
                          glPushMatrix;
                           glCallList(3);
                           glCallList(4);
                          glPopMatrix;
                        glTranslatef(0,0,50);
                          glPushMatrix;
                           glCallList(3);
                           glCallList(4);
                          glPopMatrix;
//                        glTranslatef(50,0,125);
                         glTranslatef(-50,0,65);
                          glPushMatrix;
                           glCallList(3);
                           glCallList(4);
                          glPopMatrix;
                        glTranslatef(-50,0,-50);
                          glPushMatrix;
                           glCallList(3);
                           glCallList(4);
                          glPopMatrix;
  glEndList;

  glNewList(6, GL_COMPILE);
                       glScalef(5,1,5);
                      glBlendFunc(GL_SRC_ALPHA, GL_DST_ALPHA);
                      glLineWidth(2);
                       glColor3f(0.07,0.96,0.09);
                  For k:=0 to 7 do begin
                     glTranslatef(0,-k*10,0);
                       for j:=0 to 5 do begin
                        glRotatef(j*60,0,1,0);
//                        glTranslatef(-4,0,0);
//                        glRotatef(60,0,0,1);
//                        glRotatef(90,0,1,0);
                         glBegin(GL_LINE_STRIP);
                           For i := 0 to LenghtCurve-64+NowRow+23 do begin
                             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
                           end;
                         glEnd;
//                        glRotatef(-90,0,1,0);
//                        glRotatef(-60,0,0,1);
                        glTranslatef(13,0,0);
                       end;
                  end;
  glEndList;

  glNewList(7, GL_COMPILE);
//        glLineWidth(1);
     glColor3f(0.60, 0.052, 0.620);

//       glRotatef(90,1,0,0);
//       glRotatef(180,0,1,0);
//       glRotatef(60,0,0,1);
       glTranslatef(-0.5,-1.5,0);
       glScalef(0.5,0.5,0.5);
   glBegin(GL_LINE_STRIP);
           For i := 6 to LenghtCurve do begin
             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
           end;
   glEnd;
     glColor3f(0.90, 0.2, 0.820);
       glRotatef(60,0,0,1);
   glBegin(GL_LINE_STRIP);
           For i := 4 to LenghtCurve do begin
             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
           end;
   glEnd;
     glColor3f(0.690, 0.2, 0.730);
       glTranslatef(-2,-1,0);
   glBegin(GL_LINE_STRIP);
           For i := 3 to LenghtCurve do begin
             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
           end;
   glEnd;
     glColor3f(0.70, 0.2, 0.710);
       glTranslatef(4.5,-11.5,0);
       glRotatef(-190,0,0,1);
       glScalef(0.5,0.5,0.5);
   glBegin(GL_LINE_STRIP);
           For i := 3 to LenghtCurve do begin
             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
           end;
   glEnd;
       glScalef(2,2,2);
     glColor3f(0.690, 0.2, 0.720);
       glTranslatef(4.5,-11.5,0);
       glRotatef(-185,0,0,1);
   glBegin(GL_LINE_STRIP);
           For i := 3 to LenghtCurve-37 do begin
             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
           end;
   glEnd;
     glColor3f(0.690, 0.2, 0.30);
       glTranslatef(7.5,-1,0);
       glRotatef(-30,0,0,1);
   glBegin(GL_LINE_STRIP);
           For i := 3 to LenghtCurve-38 do begin
             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
           end;
   glEnd;
                           {
     glColor3f(0.350, 0.37, 0.3120);
       glTranslatef(-7,2,0);
       glRotatef(-15,0,0,1);
       glScalef(0.2,0.2,0.2);
         glBegin(GL_LINE_STRIP);
           For i := 1 to LenghtCurve do begin
             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
           end;
         glEnd;
       glScalef(5,5,5);
                     }
  glEndList;

end;

procedure SceneRise;
var i,j:Byte;
begin
     glRotatef(70,0,1,0);
      glBlendFunc(GL_SRC_ALPHA, GL_DST_ALPHA);
        MypartCubeRain.Draw_particle;
      glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        glCallList(2);

    if NowRow > 23 then begin
    {}
       glLineWidth(3);
       glColor3f(0.25, 0.70, 0.20);
       for j:=0 to 7 do begin
        glRotatef(j*45,0,1,0);
        glTranslatef(-4,2,0);
        glRotatef(60,0,0,1);
         glBegin(GL_LINE_STRIP);
           For i := 6 to LenghtCurve-64+NowRow do begin
             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
           end;
         glEnd;
        glRotatef(-60,0,0,1);
        glTranslatef(4,-2,0);
       end;

       glColor3f(0.70, 0.60, 0.20);
       for j:=0 to 7 do begin
        glRotatef(j*45,0,1,0);
        glTranslatef(-4,0,0);
        glRotatef(60,0,0,1);
        glRotatef(90,0,1,0);
         glBegin(GL_LINE_STRIP);
           For i := 6 to LenghtCurve-64+NowRow do begin
             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
           end;
         glEnd;
        glRotatef(-90,0,1,0);
        glRotatef(-60,0,0,1);
        glTranslatef(4,0,0);
       end;
       glColor3f(0.10, 0.70, 0.150);
       glTranslatef(0,-1.9,0);
       for j:=0 to 7 do begin
        glRotatef(j*45,0,1,0);
        glTranslatef(-6,0,0);
        glRotatef(120,0,1,0);
        glRotatef(-90,1,0,0);
         glBegin(GL_LINE_STRIP);
           For i := 6 to LenghtCurve-64+NowRow do begin
             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
           end;
         glEnd;
        glRotatef(90,1,0,0);
        glRotatef(-120,0,1,0);
        glTranslatef(6,0,0);
       end;
       glColor3f(0.10, 0.60, 0.20);
       glTranslatef(0,-1.9,0);
       for j:=0 to 7 do begin
        glRotatef(j*45,0,1,0);
        glTranslatef(5,10,0);
        glRotatef(-60,0,0,1);
         glBegin(GL_LINE_STRIP);
           For i := 0 to LenghtCurve-64+NowRow do begin
             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
           end;
         glEnd;
        glRotatef(60,0,0,1);
        glTranslatef(-5,-10,0);
       end;
                 
       glLineWidth(10);
       glBegin(GL_LINES);
        glColor3f(0,1,0);
         glVertex3f(0,0,0);
         glVertex3f(0,NowRow*0.2,0);
       glend;
                  {}
    end;
end;

procedure SceneDay;
var i,j:Byte;
begin
     glRotatef(70,0,1,0);
      glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
       glScalef(2,1,2);
       glColor3f(0.35,0,0);
       glLineWidth(10);
       for j:=0 to 7 do begin
        glRotatef(j*45,0,1,0);
        glTranslatef(-4,0,0);
        glRotatef(60,0,0,1);
        glRotatef(90,0,1,0);
         glBegin(GL_LINE_STRIP);
           For i := 6 to LenghtCurve-64+NowRow+23 do begin
             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
             {
       glColor3f(1,0,0);
             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
       glColor3f(0,1,0);
             glVertex3f(ctrlpoints[i][0]*10,ctrlpoints[i][1]*10,ctrlpoints[i][2]*10);
             }
           end;
         glEnd;
        glRotatef(-90,0,1,0);
        glRotatef(-60,0,0,1);
        glTranslatef(4,0,0);
       end;

       glScalef(1.25,1,1.25);
//       glScalef(1/0.8,1,1/0.8);
       glColor3f(0.45,0.05,0.01);
        glTranslatef(0,-1,0);
       for j:=0 to 7 do begin
        glRotatef(j*45,0,1,0);
        glTranslatef(-4,0,0);
        glRotatef(60,0,0,1);
        glRotatef(90,0,1,0);
         glBegin(GL_LINE_STRIP);
           For i := 6 to LenghtCurve-64+NowRow+23 do begin
             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
           end;
         glEnd;
        glRotatef(-90,0,1,0);
        glRotatef(-60,0,0,1);
        glTranslatef(4,0,0);
       end;

//       glScalef(1/0.75,1,1/0.75);
       glScalef(1.3333333,1,1.33333333);
       glColor3f(0.7,0.05,0.01);
        glTranslatef(0,-0.5,0);
       for j:=0 to 7 do begin
        glRotatef(j*45,0,1,0);
        glTranslatef(-4,0,0);
        glRotatef(60,0,0,1);
        glRotatef(90,0,1,0);
         glBegin(GL_LINE_STRIP);
           For i := 6 to LenghtCurve-64+NowRow+23 do begin
             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
           end;
         glEnd;
        glRotatef(-90,0,1,0);
        glRotatef(-60,0,0,1);
        glTranslatef(4,0,0);
       end;
end;

procedure SceneDayDay;
var i,j,k:byte;
begin
                       glScalef(5,1,5);
                      glBlendFunc(GL_SRC_ALPHA, GL_DST_ALPHA);
                      glLineWidth(2);
                       glColor3f(0.07,0.96,0.09);
                  For k:=0 to 7 do begin
                     glTranslatef(0,-k*9,0);
                       for j:=0 to 7 do begin
                        glRotatef(j*45,0,1,0);
                        glTranslatef(-4,0,0);
                        glRotatef(60,0,0,1);
                        glRotatef(90,0,1,0);
                         glBegin(GL_LINE_STRIP);
                           For i := 6 to LenghtCurve-64+NowRow+23 do begin
                             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
                           end;
                         glEnd;
                        glRotatef(-90,0,1,0);
                        glRotatef(-60,0,0,1);
                        glTranslatef(4,0,0);
                       end;
                  end;
end;


procedure SceneDayDaySpiral;
var i,j,k:byte;
begin
                       glScalef(5,1,5);
                      glBlendFunc(GL_SRC_ALPHA, GL_DST_ALPHA);
                      glLineWidth(2);
                       glColor3f(0.07,0.96,0.09);
                  For k:=0 to 7 do begin
                     glTranslatef(0,-k*10,0);
                       for j:=0 to 5 do begin
                        glRotatef(j*60,0,1,0);
//                        glTranslatef(-4,0,0);
//                        glRotatef(60,0,0,1);
//                        glRotatef(90,0,1,0);
                         glBegin(GL_LINE_STRIP);
                           For i := 0 to LenghtCurve-64+NowRow+23 do begin
                             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
                           end;
                         glEnd;
//                        glRotatef(-90,0,1,0);
//                        glRotatef(-60,0,0,1);
                        glTranslatef(13,0,0);
                       end;
                  end;
end;

procedure SceneWordGreets;
begin
glPushMatrix; //del
//glLoadIdentity;
        glTranslatef(-10,-10+NowRow*0.5,-25);
       glColor3f(1,1,1);
glScalef(0.25,0.25,0.25);

       glCallList(_T_R);
       glCallList(_T_U);
       glCallList(_T_D);
       glCallList(_T_e);
       glCallList(_T_m);
       glCallList(_T_o);
       glCallList(_T_s);
       glCallList(_T_c);
       glCallList(_T_e);
       glCallList(_T_n);
       glCallList(_T_e);
     glTranslatef(-60,-10,0);
       glCallList(_T_s);
       glCallList(_T_a);
       glCallList(_T_n);
       glCallList(_T_d);
       glCallList(_T_s);
     glTranslatef(0,-7,0);
       glCallList(_T_Q);
       glCallList(_T_u);
       glCallList(_T_i);
       glCallList(_T_t);
       glCallList(_T_e);
     glTranslatef(0,5,0);
       glCallList(_T_t);
       glCallList(_T_r);
       glCallList(_T_e);
       glCallList(_T_x);
     glTranslatef(-60,-13,0);
       glCallList(_T_7);
       glCallList(_T_d);
       glCallList(_T_u);
       glCallList(_T_m);
       glCallList(_T_p);
     glTranslatef(5,0,0);
       glCallList(_T_c);
       glCallList(_T_r);
       glCallList(_T_o);
       glCallList(_T_l);
       glCallList(_T_y);
       glCallList(_T_x);
     glTranslatef(-60,-13,0);
       glCallList(_T_M);
       glCallList(_T_a);
       glCallList(_T_n);
       glCallList(_T_w);
       glCallList(_T_e);
     glTranslatef(-30,-7,0);
       glCallList(_T_b);
       glCallList(_T_i);
       glCallList(_T_t);
       glCallList(_T_l);
     glTranslatef(-16.5,-7,0);
       glCallList(_T_t);
       glCallList(_T_a);
       glCallList(_T_n);
       glCallList(_T_g);
       glCallList(_T_e);
       glCallList(_T_r);
       glCallList(_T_i);
       glCallList(_T_n);
       glCallList(_T_e);
     glTranslatef(-41,-7,0);
       glCallList(_T_m);
       glCallList(_T_a);
       glCallList(_T_m);
     glTranslatef(-17.5,-7,0);
       glCallList(_T_x);
       glCallList(_T_i);
       glCallList(_T_o);
       glCallList(_T_d);
     glTranslatef(-16.5,-7,0);
       glCallList(_T_i);
       glCallList(_T_c);
       glCallList(_T_e);
       glCallList(_T_f);
       glCallList(_T_a);
       glCallList(_T_l);
       glCallList(_T_l);
     glTranslatef(-31,-7,0);
       glCallList(_T_t);
       glCallList(_T_o);
       glCallList(_T_n);
       glCallList(_T_e);
     glTranslatef(-20,-7,0);
       glCallList(_T_a);
       glCallList(_T_n);
       glCallList(_T_d);
     glTranslatef(-15,-7,0);
       glCallList(_T_l);
       glCallList(_T_y);
       glCallList(_T_z);
               glTranslatef(1,0,0);
       glCallList(_T_z);
       glCallList(_T_a);
       glCallList(_T_r);
       glCallList(_T_d);
     glTranslatef(-30,-7,0);

     //
       glCallList(_T_p);
       glCallList(_T_h);
       glCallList(_T_a);
       glCallList(_T_n);
       glCallList(_T_t);
       glCallList(_T_o);
       glCallList(_T_m);                                           //
               glTranslatef(3,0,0);                                ////
       glCallList(_T_l);                                               //
       glCallList(_T_o);                                               //
       glCallList(_T_r);                                                //
       glCallList(_T_d);                                                 //
                                                                          //
     glTranslatef(-55,-7,0);                                               //
   //
       glCallList(_T_p);
       glCallList(_T_r);
       glCallList(_T_e);
       glCallList(_T_s);
       glCallList(_T_t);
       glCallList(_T_o);
       glCallList(_T_n);
     glTranslatef(-30,-7,0);
       glCallList(_T_f);
       glCallList(_T_o);
       glCallList(_T_x);

                     {
glCallList(_T_S);
glCallList(_T_C);
glCallList(_T_R);
glCallList(_T_i);
glCallList(_T_m);
glCallList(_T_e);
glCallList(_T_r);
glCallList(_T_s);

       glCallList(_T_A);
       glCallList(_T_B);
       glCallList(_T_C);
       glCallList(_T_D);
       glCallList(_T_E);
       glCallList(_T_F);
       glCallList(_T_G);
       glCallList(_T_H);
       glCallList(_T_I);
       glCallList(_T_J);
       glCallList(_T_K);
       glCallList(_T_L);
       glCallList(_T_M);
       glCallList(_T_N);
       glCallList(_T_O);
       glCallList(_T_P);
       glCallList(_T_Q);
       glCallList(_T_R);
       glCallList(_T_S);
       glCallList(_T_T);
       glCallList(_T_U);
        glCallList(_T_V);
        glCallList(_T_W);
        glCallList(_T_X);
        glCallList(_T_Y);
        glCallList(_T_Z);
       { }
glPopMatrix; //del
end;


procedure SceneWordGreets1;
begin
glPushMatrix; //del
//glLoadIdentity;
//        glTranslatef(-12,-150+ElapsedTime*0.002,-25);

       glColor3f(0.9,0.1,0.81);
       glCallList(_T_C);
       glCallList(_T_C);
             glTranslatef(1,0,0);
       glCallList(_T_O);
       glCallList(_T_9);
     glTranslatef(-20,-5,0);
       glColor3f(1,1,1);
glScalef(0.25,0.25,0.25);
       glCallList(_T_o);
       glCallList(_T_r);
       glCallList(_T_g);
       glCallList(_T_a);
       glCallList(_T_n);
       glCallList(_T_i);
             glTranslatef(1,0,0);
       glCallList(_T_z);
       glCallList(_T_a);
       glCallList(_T_t);
       glCallList(_T_o);
       glCallList(_T_r);
       glCallList(_T_s);
     glTranslatef(-40,-10,0);
       glCallList(_T_v);
       glCallList(_T_i);
             glTranslatef(1,0,0);
       glCallList(_T_z);
       glCallList(_T_i);
//             glTranslatef(1,0,0);
       glCallList(_T_t);
       glCallList(_T_o);
       glCallList(_T_r);
       glCallList(_T_s);
     glTranslatef(-40,-10,0);
       glCallList(_T_T);
       glCallList(_T_h);
       glCallList(_T_a);
       glCallList(_T_n);
       glCallList(_T_k);
             glTranslatef(2,0,0);
       glCallList(_T_y);
             glTranslatef(-1.5,0,0);
       glCallList(_T_o);
       glCallList(_T_u);





glPopMatrix; //del
end;

procedure SceneWordAuthor;
begin
glPushMatrix; //del
glLoadIdentity;
//        glTranslatef(-12,-10,-25);
        glTranslatef(-10,-5,-20);
       glColor3f(1,1,1);

//     glColor3f(1,0,0);
//                          glutSolidCube(10);
     glColor3f(1,1,1);
     glScalef(0.2,0.2,0.2);
   case NowOrder of
     11:begin
//  vekmnabkmv
//  vekmn
//  abkmv
        if NowRow <32 then begin
                glCallList(_T_v);
                glCallList(_T_e);
                glCallList(_T_k);
                glCallList(_T_m);
                glCallList(_T_n);
        end else
        if (NowRow >=34)and(NowRow <=60) then
        begin
                glCallList(_T_a);
                glCallList(_T_b);
                glCallList(_T_k);
                glCallList(_T_m);
                        glTranslatef(1,0,0);
                glCallList(_T_v);
        end;
     end;
     12:begin
        if NowRow <32 then begin
                glCallList(_T_v);
                glCallList(_T_e);
                glCallList(_T_k);
                glCallList(_T_m);
                glCallList(_T_n);
                glCallList(_T_a);
                glCallList(_T_b);
                glCallList(_T_k);
                glCallList(_T_m);
                        glTranslatef(1,0,0);
                glCallList(_T_v);
        end else
        if (NowRow >=34)and(NowRow <=60) then        
        begin
             glTranslatef(0,45,0);
                glCallList(_T_I);
                glCallList(_T_d);
                glCallList(_T_e);
                glCallList(_T_a);
             glTranslatef(-15,-7,0);
                glCallList(_T_c);
                glCallList(_T_o);
                glCallList(_T_d);
                glCallList(_T_e);
             glTranslatef(-15,-7,0);
                glCallList(_T_m);
                glCallList(_T_u);
                glCallList(_T_s);
                glCallList(_T_i);
                glCallList(_T_c);
             glTranslatef(-7,-7,0);
     glScalef(0.5,0.5,0.5);
                glCallList(_T_b);
                glCallList(_T_y);

     glScalef(2,2,2);
//     glScalef(1/0.5,1/0.5,1/0.5);

//   *  glScalef(1/0.05,1/0.05,1/0.05);
             glTranslatef(-20,-7,0);
                glCallList(_T_S);
                glCallList(_T_C);
                glCallList(_T_R);
                glCallList(_T_i);
                glCallList(_T_m);
                glCallList(_T_e);
                glCallList(_T_r);
                glCallList(_T_s);
        end;
     end;
   end;
   {    glTranslatef(-60,-10,0); }
glPopMatrix;
end;

procedure PreSceneWords;
begin

 glNewList(_T_9,GL_COMPILE);
           glTranslatef(2,0,0);
   glPushMatrix;
//        glColor4f(0.7,0.7,0.7,1);
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

           glTranslatef(-1.5,-0.4,0);
            glScalef(2.5,0.2,1);
            glutSolidCube(1);

            glScalef(0.4,5,1);
//            glScalef(1/2.5,1/0.2,1);
           glTranslatef(-1.5,0.4,0);

//          glColor4f(1,0,0,1);
           glTranslatef(1.5,0.4,0);
            glScalef(2,0.2,1);
            glutSolidCube(1);

            glScalef(0.5,2.5,1);
//            glScalef(1/2,1/0.4,1);
           glTranslatef(-0.75,-0.4,0);
            glutSolidCube(1); {}
                          //  glColor3f(1,0,0);
           glTranslatef(1,-0.4,0);
            glScalef(3,0.5,1);
            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(5,0,0);
 glEndList;

 glNewList(_T_7,GL_COMPILE);
//        glTranslatef(1.5,0,0);
   glPushMatrix;
//        glColor4f(0.7,0.7,0.7,1);

           glTranslatef(0,0.5,0);
            glutSolidCube(1);

           glTranslatef(1,1,0);
            glutSolidCube(1);

           glTranslatef(-1.25,1,0);
           glScalef(3.5,1,1);
            glutSolidCube(1);
//           glScalef(1/3.5,1,1);            
           glScalef(0.285714285,1,1);

           glTranslatef(-0.5,-3,0);
            glutSolidCube(1);

           glTranslatef(0,-1,0);
           glScalef(1,1,1);
            glutSolidCube(1);

   glPopMatrix;
        glTranslatef(3,0,0);
 glEndList;

 glNewList(_T_A,GL_COMPILE);
   glPushMatrix;
//        glColor4f(0.7,0.7,0.7,1);
//        glColor4f(1,0,0,1);
            glScalef(1,4,1);
            glutSolidCube(1);
           glTranslatef(3,0,0);
            glutSolidCube(1);
           glTranslatef(-3,0,0);
           glTranslatef(1.5,0,0);
            glScalef(2,0.25,1);
            glutSolidCube(1);
           glTranslatef(0,2.5,0);
            glScalef(1.75,1,1);
            glutSolidCube(1);
           glTranslatef(0,0.75,0);
            glScalef(0.5,0.5,1);
            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(5,0,0);   
 glEndList;

 glNewList(_T_B,GL_COMPILE);
   glPushMatrix;
//        glColor4f(0.7,0.7,0.7,1);
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

           glTranslatef(2,-0.4,0);
            glScalef(3,0.2,1);
            glutSolidCube(1);
//            glScalef(1/3,5,1);
            glScalef(0.333333,5,1);
           glTranslatef(-0.2,0.8,0);

           glTranslatef(-0.5,0,0);
            glScalef(2.75,0.2,1);
            glutSolidCube(1);
//            glScalef(1/2.75,1/0.2,1);
            glScalef(0.3636363636,5,1);
           glTranslatef(0.2,-0.40,0);

            glScalef(2,0.15,1);
            glutSolidCube(1);
            glScalef(0.5,6.66666666,1);
//            glScalef(0.5,1/0.15,1);

           glTranslatef(1.5,0,0);
            glScalef(1,0.6,1);
            glScalef(1,1,1);
            glutSolidCube(1);

   glPopMatrix;
        glTranslatef(5,0,0);
 glEndList;  

 glNewList(_T_C,GL_COMPILE);
   glPushMatrix;
//        glColor4f(0.7,0.7,0.7,1);
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

           glTranslatef(2,-0.4,0);
            glScalef(3,0.2,1);
            glutSolidCube(1);
            glScalef(0.333333,5,1);
//            glScalef(1/3,1/0.2,1);
           glTranslatef(-0.2,0.8,0);

            glScalef(2.75,0.2,1);
            glutSolidCube(1);
//            glScalef(1/3,1/0.2,1);
            glScalef(0.333333,5,1);
           glTranslatef(-0.5,-0.40,0);
   glPopMatrix;
        glTranslatef(5,0,0);
 glEndList;

 glNewList(_T_D,GL_COMPILE);
   glPushMatrix;
//        glColor4f(0.7,0.7,0.7,1);
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

           glTranslatef(2,-0.4,0);
            glScalef(3,0.2,1);
            glutSolidCube(1);
//            glScalef(1/3,1/0.2,1);
            glScalef(0.333333,5,1);
           glTranslatef(-0.2,0.8,0);

            glScalef(2.75,0.2,1);
            glutSolidCube(1);
//            glScalef(1/2.75,1/0.2,1);
            glScalef(0.36363636363,5,1);
           glTranslatef(-0.5,-0.40,0);

           glTranslatef(2,0.0,0);
            glScalef(1,0.6,1);
            glutSolidCube(1);

   glPopMatrix;
        glTranslatef(5,0,0);
 glEndList;

 glNewList(_T_E,GL_COMPILE);
   glPushMatrix;
//        glColor4f(0.7,0.7,0.7,1);
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

           glTranslatef(2,-0.4,0);
            glScalef(3,0.2,1);
            glutSolidCube(1);
//            glScalef(1/3,1/0.2,1);
            glScalef(0.33333,5,1);
           glTranslatef(-0.2,0.8,0);

            glScalef(2.75,0.2,1);
            glutSolidCube(1);
//            glScalef(1/3,1/0.2,1);
            glScalef(0.33333,5,1);
           glTranslatef(-0.5,-0.40,0);

            glScalef(2,0.15,1);
            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(5,0,0);
 glEndList;

 glNewList(_T_F,GL_COMPILE);
   glPushMatrix;
//        glColor4f(0.7,0.7,0.7,1);
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

           glTranslatef(2,-0.4,0);
            glScalef(3,0.2,1);
//            glutSolidCube(1);
//            glScalef(1/3,1/0.2,1);
            glScalef(0.33333,5,1);
           glTranslatef(-0.2,0.8,0);

            glScalef(2.75,0.2,1);
            glutSolidCube(1);
//            glScalef(1/3,1/0.2,1);
            glScalef(0.33333,5,1);
           glTranslatef(-0.5,-0.40,0);

            glScalef(2,0.15,1);
            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(5,0,0);
 glEndList;

 glNewList(_T_G,GL_COMPILE);
   glPushMatrix;
//        glColor4f(0.7,0.7,0.7,1);
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

           glTranslatef(2,-0.4,0);
            glScalef(3,0.2,1);
            glutSolidCube(1);
//            glScalef(1/3,1/0.2,1);
            glScalef(0.33333,5,1);
           glTranslatef(-0.2,0.8,0);

            glScalef(2.75,0.2,1);
            glutSolidCube(1);
//            glScalef(1/2.75,1/0.2,1);
            glScalef(0.33333,5,1);
           glTranslatef(-0.5,-0.40,0);

           glTranslatef(2,-0.15,0);
            glScalef(1,0.3,1);
            glutSolidCube(1);
//            glScalef(1,1/0.3,1);
            glScalef(1,3.3333333,1);
           glTranslatef(-1.2,0.15,0);
            glScalef(1.5,0.2,1);
            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(5,0,0);
 glEndList;

 glNewList(_T_H,GL_COMPILE);
   glPushMatrix;
//        glColor4f(0.7,0.7,0.7,1);
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

           glTranslatef(1.5,0,0);
            glScalef(2,0.2,1);
            glutSolidCube(1);
//            glScalef(1/2,1/0.2,1);
            glScalef(0.5,5,1);
           glTranslatef(1.5,0,0);

            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(5,0,0);
 glEndList;

 glNewList(_T_N,GL_COMPILE);
   glPushMatrix;
//        glColor4f(0.7,0.7,0.7,1);
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);
//            glScalef(1,1/5.5,1);
            glScalef(1,0.1818181818181818,1);

           glTranslatef(0.5,2,0);
            glutSolidCube(1);
           glTranslatef(0.5,-1,0);
            glutSolidCube(1);
           glTranslatef(0.5,-1,0);
            glutSolidCube(1);
           glTranslatef(0.5,-1,0);
            glutSolidCube(1);
           glTranslatef(0.5,-1,0);
            glutSolidCube(1);
           glTranslatef(0.5,2,0);
////        glColor4f(1,0,0,1);
            glScalef(1,5.5,1);
            glutSolidCube(1);
//            glScalef(1,1/5.5,1);
   glPopMatrix;
        glTranslatef(5,0,0);
 glEndList;

 glNewList(_T_I,GL_COMPILE);
   glPushMatrix;
//        glColor4f(0.7,0.7,0.7,1);
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

//           glTranslatef(1.75,-0.4,0);
//            glScalef(2.5,0.2,1);
//            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(2,0,0);
 glEndList;

 glNewList(_T_J,GL_COMPILE);
        glTranslatef(0.5,0,0);
   glPushMatrix;
//        glColor4f(0.7,0.7,0.7,1);

           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);
//glColor3f(1,0,0);
           glTranslatef(-0.5,-0.4,0);
            glScalef(1,0.2,1);
            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(2,0,0);
 glEndList;

 glNewList(_T_K,GL_COMPILE);
   glPushMatrix;
//        glColor4f(0.7,0.7,0.7,1);
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

           glTranslatef(1,0,0);
            glScalef(1,0.2,1);
            glutSolidCube(1);

           glTranslatef(1,0,0);
            glutSolidCube(1);

           glTranslatef(0.5,1,0);
            glutSolidCube(1);

           glTranslatef(0.5,1,0);
            glutSolidCube(1);
////        glColor4f(1,0,0,1);
           glTranslatef(0,-4,0);
            glutSolidCube(1);

           glTranslatef(-0.5,1,0);
            glutSolidCube(1);

   glPopMatrix;
        glTranslatef(4.5,0,0);
 glEndList;

 glNewList(_T_L,GL_COMPILE);
   glPushMatrix;
//        glColor4f(0.7,0.7,0.7,1);
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

           glTranslatef(1.75,-0.4,0);
            glScalef(2.5,0.2,1);
            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(4.5,0,0);
 glEndList;

 glNewList(_T_M,GL_COMPILE);
   glPushMatrix;
//        glColor4f(0.7,0.7,0.7,1);
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);
//            glScalef(1,1/5.5,1);
            glScalef(1,0.18181818181818,1);

           glTranslatef(0.5,2,0);
            glutSolidCube(1);
           glTranslatef(0.5,-1,0);
            glutSolidCube(1);
           glTranslatef(0.5,-1,0);
            glutSolidCube(1);
           glTranslatef(0.5,-1,0);
            glutSolidCube(1);
           glTranslatef(0.5,-0.5,0);
            glutSolidCube(1);

           glTranslatef(0.5,0.5,0);
            glutSolidCube(1);
           glTranslatef(0.5,1,0);
            glutSolidCube(1);
           glTranslatef(0.5,1,0);
            glutSolidCube(1);
           glTranslatef(0.5,1,0);
            glutSolidCube(1);

////                    glColor4f(1,0,0,1);
           glTranslatef(0.5,-2,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(7,0,0);
 glEndList;

 glNewList(_T_H,GL_COMPILE);
   glPushMatrix;
//        glColor4f(0.7,0.7,0.7,1);
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

           glTranslatef(1.5,0,0);
            glScalef(2,0.2,1);
            glutSolidCube(1);
//            glScalef(1/2,1/0.2,1);
            glScalef(0.5,5,1);
           glTranslatef(1.5,0,0);

            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(5,0,0);
 glEndList;

 glNewList(_T_O,GL_COMPILE);
   glPushMatrix;
//        glColor4f(0.7,0.7,0.7,1);
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

           glTranslatef(1.5,-0.4,0);
            glScalef(2,0.2,1);
            glutSolidCube(1);
//            glScalef(1/2,1/0.2,1);
            glScalef(0.5,5,1);
           glTranslatef(-1.5,0.4,0);

////          glColor4f(1,0,0,1);
           glTranslatef(1.5,0.4,0);
            glScalef(2,0.2,1);
            glutSolidCube(1);
//            glScalef(1/2,1/0.2,1);
            glScalef(0.5,5,1);
           glTranslatef(1.5,-0.4,0);

            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(5,0,0);
 glEndList;

 glNewList(_T_P,GL_COMPILE);
   glPushMatrix;
//        glColor4f(0.7,0.7,0.7,1);
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

           glTranslatef(1,0,0);
            glScalef(1,0.2,1);
            glutSolidCube(1);

//          glColor4f(1,0,0,1);

           glTranslatef(1.2,0,0);
                glScalef(1.85,1,1);
                glutSolidCube(1);
//        glScalef(1/1.75,1,1);
        glScalef(0.57142857,1,1);

           glTranslatef(0.35,1,0);
            glutSolidCube(1);
//
           glTranslatef(-1,1,0);
            glScalef(3,1,1);
            glutSolidCube(1);

   glPopMatrix;
        glTranslatef(4.5,0,0);
 glEndList;

 glNewList(_T_Q,GL_COMPILE);
   glPushMatrix;
//        glColor4f(0.7,0.7,0.7,1);
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

           glTranslatef(1.5,-0.4,0);
            glScalef(2,0.2,1);
            glutSolidCube(1);
//            glScalef(1/2,1/0.2,1);
            glScalef(0.5,5,1);

           glTranslatef(-1.5,0.4,0);

           glTranslatef(1.5,0.4,0);
            glScalef(2,0.2,1);
            glutSolidCube(1);

//            glScalef(1/2,1/0.2,1);
            glScalef(0.5,5,1);
           glTranslatef(1.5,-0.5,0);

            glScalef(1,1.2,1);
            glutSolidCube(1);
//            glScalef(1,1/6,1);
            glScalef(1,0.166666,1);

////          glColor4f(1,0,0,1);
           glTranslatef(1,-2.5,0);
            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(5,0,0);
 glEndList;


 glNewList(_T_R,GL_COMPILE);
   glPushMatrix;
//        glColor4f(0.7,0.7,0.7,1);
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

           glTranslatef(1,0,0);
            glScalef(1,0.2,1);
            glutSolidCube(1);

           glTranslatef(1,0,0);
            glutSolidCube(1);

           glTranslatef(0.5,1,0);
            glutSolidCube(1);
//        glColor4f(1,0,0,1);
           glTranslatef(-0.75,1,0);
            glScalef(2.5,1,1);
            glutSolidCube(1);
//            glScalef(1/2.5,1,1);
            glScalef(0.4,1,1);

           glTranslatef(1,-4,0);
            glutSolidCube(1);

           glTranslatef(-0.5,1,0);
            glutSolidCube(1);

   glPopMatrix;
        glTranslatef(4.5,0,0);
 glEndList;

 glNewList(_T_S,GL_COMPILE);
        glTranslatef(2,0,0);
   glPushMatrix;
//        glColor4f(0.7,0.7,0.7,1);

           glTranslatef(-1,-1.5,0);
            glScalef(3,1,1);
            glutSolidCube(1);
//            glScalef(1/3,1,1);
            glScalef(0.33333,1,1);
//glColor3f(1,0,0);
           glTranslatef(1,1.25,0);
            glScalef(1,1.5,1);
            glutSolidCube(1);
//            glScalef(1,1/1.5,1);
            glScalef(1,0.6666666666,1);

//        glColor4f(0.7,0.7,0.7,1);
           glTranslatef(-1,1.25,0);
            glScalef(3,1,1);
            glutSolidCube(1);
//            glScalef(1/3,1,1);
            glScalef(0.333333,1,1);

           glTranslatef(-1,1,0);
            glutSolidCube(1);

           glTranslatef(1,1,0);
            glScalef(3,1,1);
            glutSolidCube(1);
//            glScalef(1/3,1,1);
            glScalef(0.333333,1,1);

   glPopMatrix;
        glTranslatef(2.5,0,0);
 glEndList;

 glNewList(_T_T,GL_COMPILE);
        glTranslatef(1.5,0,0);
   glPushMatrix;
//        glColor4f(0.7,0.7,0.7,1);

           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);
//glColor3f(1,0,0);
           glTranslatef(0,0.4,0);
            glScalef(4,0.2,1);
            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(3.5,0,0);
 glEndList;

 glNewList(_T_U,GL_COMPILE);
   glPushMatrix;
//        glColor4f(0.7,0.7,0.7,1);
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

           glTranslatef(1.5,-0.4,0);
            glScalef(2,0.2,1);
            glutSolidCube(1);
//            glScalef(1/2,1/0.2,1);
            glScalef(0.5,5,1);
           glTranslatef(1.5,0.4,0);
            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(6,0,0);
 glEndList;

 glNewList(_T_V,GL_COMPILE);
//        glTranslatef(1.5,0,0);
   glPushMatrix;
//        glColor4f(0.7,0.7,0.7,1);

           glTranslatef(0,-1.5,0);
            glutSolidCube(1);

           glTranslatef(1,1.5,0);
            glScalef(1,2,1);
            glutSolidCube(1);

           glTranslatef(-2,0,0);
            glutSolidCube(1);
//glColor3f(1,0,0);
           glTranslatef(-0.5,1.1,0);
            glScalef(1,1.25,1);
            glutSolidCube(1);

           glTranslatef(3,0,0);
            glutSolidCube(1);

   glPopMatrix;
        glTranslatef(3,0,0);
 glEndList;

 glNewList(_T_W,GL_COMPILE);
   glPushMatrix;
//        glColor4f(0.7,0.7,0.7,1);
           glRotatef(180,1,0,0);
           glTranslatef(0.5,1.25,0);
            glutSolidCube(1);
           glTranslatef(0.5,-1,0);
            glutSolidCube(1);
           glTranslatef(0.5,-1,0);
            glutSolidCube(1);
           glTranslatef(0.5,-1,0);
            glutSolidCube(1);
           glTranslatef(0.5,-0.5,0);
            glutSolidCube(1);

           glTranslatef(0.5,0.5,0);
            glutSolidCube(1);
           glTranslatef(0.5,1,0);
            glutSolidCube(1);
           glTranslatef(0.5,1,0);
            glutSolidCube(1);
           glTranslatef(0.5,1,0);
            glutSolidCube(1);
//                    glColor4f(1,0,0,1);
           glTranslatef(0.5,-2.65,0);
            glScalef(1,4.3,1);
            glutSolidCube(1);
//            glScalef(1,1/4.3,1);
            glScalef(1,0.2325581,1);

           glTranslatef(-5,0,0);
            glScalef(1,4.3,1);
            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(8,0,0);
 glEndList;

 glNewList(_T_X,GL_COMPILE);
//        glTranslatef(1.5,0,0);
   glPushMatrix;
//        glColor4f(0.7,0.7,0.7,1);

           glTranslatef(0,0.5,0);
            glutSolidCube(1);

           glTranslatef(1,1,0);
            glutSolidCube(1);

           glTranslatef(-2,0.0,0);
            glutSolidCube(1);

           glTranslatef(-0.5,1,0);
            glutSolidCube(1);

           glTranslatef(3,0,0);
            glutSolidCube(1);

           glTranslatef(-0.5,-3,0);
            glutSolidCube(1);

           glTranslatef(-2,0,0);
            glutSolidCube(1);

           glTranslatef(-0.5,-1,0);
            glutSolidCube(1);
           glTranslatef(3,0,0);
            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(3,0,0);
 glEndList;

 glNewList(_T_Y,GL_COMPILE);
        glTranslatef(1.5,0,0);
   glPushMatrix;
//        glColor4f(0.7,0.7,0.7,1);

           glTranslatef(0,-1,0);
            glScalef(1,2,1);
            glutSolidCube(1);
//            glScalef(1,1/2,1);
            glScalef(1,0.5,1);
           glTranslatef(-1,1.5,0);
            glutSolidCube(1);
           glTranslatef(2,0,0);
            glutSolidCube(1);
           glTranslatef(-2.5,1.5,0);
            glScalef(1,2,1);
            glutSolidCube(1);
           glTranslatef(3,0,0);
            glutSolidCube(1);
                           {}
   glPopMatrix;
        glTranslatef(5,0,0);
 glEndList;

 glNewList(_T_Z,GL_COMPILE);
//        glTranslatef(1.5,0,0);
   glPushMatrix;
//        glColor4f(0.7,0.7,0.7,1);

           glTranslatef(0,0.5,0);
            glutSolidCube(1);

           glTranslatef(1,1,0);
            glutSolidCube(1);

           glTranslatef(-1.25,1,0);
           glScalef(3.5,1,1);
            glutSolidCube(1);
//           glScalef(1/3.5,1,1);
           glScalef(0.285714,1,1);

           glTranslatef(-0.5,-3,0);
            glutSolidCube(1);

           glTranslatef(0.75,-1,0);
           glScalef(3.5,1,1);
            glutSolidCube(1);

   glPopMatrix;
        glTranslatef(3,0,0);
 glEndList;

end;

end.


        glColor3f(1.0, 1.0, 0.0);
                               {
         glBegin(GL_LINE_STRIP);
           For i := 0 to LenghtCurve do begin
             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
           end;
         glEnd;
                      }
        if NowRow > 23 then
        for j:=0 to 5 do begin
         glRotatef(60,0,1,0);

        glTranslatef(-5,3,0);
        glRotatef(30,0,0,1);

         glBegin(GL_LINE_STRIP);
           For i := 0 to LenghtCurve-(64-NowRow) do begin
             glVertex3f(ctrlpoints[i][0],ctrlpoints[i][1],ctrlpoints[i][2]);
           end;
         glEnd;
        end;
        //del
