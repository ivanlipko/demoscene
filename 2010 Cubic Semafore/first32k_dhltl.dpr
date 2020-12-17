program tunnel;

uses
  Windows,
  Messages,
//  SysUtils,   //!!!!!
//  math,
  OpenGL,
  MiniFMOD  
;

//GLUT_BITMAP_8_BY_13

const
  WND_TITLE = 'SCRIMERS _Cubic semafore_';
//  FPS_TIMER = 1;                     // Timer to calculate FPS
//  FPS_INTERVAL = 100;               // Calculate FPS every 1000 ms

  pic = 1/180*pi;

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



var
  h_Wnd  : HWND;                     // Global window handle
  h_DC   : HDC;                      // Global device context
  h_RC   : HGLRC;                    // OpenGL rendering context

  keys_:boolean;

  //initial
    Width  : Integer = 600; //1024  // 1280 // 800
    Height : Integer = 480; //768   // 1024 // 600
    PixelDepth : Integer = 16; //24 //16 //32
    FullScreen : Boolean = false;

  Textro : GLfloat = 0.0; 


{$R jpg.RES} //_e


procedure glutSolidCube(Size :GLDouble);
const
  DrawType = GL_QUADS;

  BoxPoints :    Array[0..5, 0..2] of GLfloat =
      ( (-1,  0,  0),
        ( 0,  1,  0),
        ( 1,  0,  0),
        ( 0, -1,  0),
        ( 0,  0,  1),
        ( 0,  0, -1) );

  BoxFaces :    Array[0..5, 0..3] of GLint =      ( (0, 1, 2, 3),
        (3, 2, 6, 7),
        (7, 6, 5, 4),
        (4, 5, 1, 0),
        (5, 6, 2, 1),
        (7, 4, 0, 3) );
var
  V :array[0..7, 0..2] of GLfloat;
  I : GLint;
  HalfSize : GLfloat;

begin

  HalfSize := Size / 2;
  V[0, 0] := -HalfSize;
  V[1, 0] := -HalfSize;
  V[2, 0] := -HalfSize;
  V[3, 0] := -HalfSize;
  V[4, 0] := HalfSize;
  V[5, 0] := HalfSize;
  V[6, 0] := HalfSize;
  V[7, 0] := HalfSize;
  V[0, 1] := -HalfSize;
  V[1, 1] := -HalfSize;
  V[4, 1] := -HalfSize;
  V[5, 1] := -HalfSize;
  V[2, 1] := HalfSize;
  V[3, 1] := HalfSize;
  V[6, 1] := HalfSize;
  V[7, 1] := HalfSize;
  V[0, 2] := -HalfSize;
  V[3, 2] := -HalfSize;
  V[4, 2] := -HalfSize;
  V[7, 2] := -HalfSize;
  V[1, 2] := HalfSize;
  V[2, 2] := HalfSize;
  V[5, 2] := HalfSize;
  V[6, 2] := HalfSize;

  glBegin(DrawType);
  for I := 0 to 5 do
   begin
//    glBegin(DrawType);
    glNormal3fv(@BoxPoints[I, 0]);

    glVertex3fv(@V[BoxFaces[I, 0], 0]);
    glVertex3fv(@V[BoxFaces[I, 1], 0]);
    glVertex3fv(@V[BoxFaces[I, 2], 0]);
    glVertex3fv(@V[BoxFaces[I, 3], 0]);
//  glEnd;
   end;
  glEnd;

end;

procedure PreSceneWords;
begin

 glNewList(_T_9,GL_COMPILE);
           glTranslatef(2,0,0);
   glPushMatrix;
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

           glTranslatef(-1.5,-0.4,0);
            glScalef(2.5,0.2,1);
            glutSolidCube(1);

            glScalef(0.4,5,1);
           glTranslatef(-1.5,0.4,0);

           glTranslatef(1.5,0.4,0);
            glScalef(2,0.2,1);
            glutSolidCube(1);

            glScalef(0.5,2.5,1);
           glTranslatef(-0.75,-0.4,0);
            glutSolidCube(1); {}
           glTranslatef(1,-0.4,0);
            glScalef(3,0.5,1);
            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(5,0,0);
 glEndList;

 glNewList(_T_7,GL_COMPILE);
   glPushMatrix;

           glTranslatef(0,0.5,0);
            glutSolidCube(1);

           glTranslatef(1,1,0);
            glutSolidCube(1);

           glTranslatef(-1.25,1,0);
           glScalef(3.5,1,1);
            glutSolidCube(1);
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
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

           glTranslatef(2,-0.4,0);
            glScalef(3,0.2,1);
            glutSolidCube(1);
            glScalef(0.333333,5,1);
           glTranslatef(-0.2,0.8,0);

           glTranslatef(-0.5,0,0);
            glScalef(2.75,0.2,1);
            glutSolidCube(1);
            glScalef(0.3636363636,5,1);
           glTranslatef(0.2,-0.40,0);

            glScalef(2,0.15,1);
            glutSolidCube(1);
            glScalef(0.5,6.66666666,1);

           glTranslatef(1.5,0,0);
            glScalef(1,0.6,1);
            glScalef(1,1,1);
            glutSolidCube(1);

   glPopMatrix;
        glTranslatef(5,0,0);
 glEndList;  

 glNewList(_T_C,GL_COMPILE);
   glPushMatrix;
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

           glTranslatef(2,-0.4,0);
            glScalef(3,0.2,1);
            glutSolidCube(1);
            glScalef(0.333333,5,1);
           glTranslatef(-0.2,0.8,0);

            glScalef(2.75,0.2,1);
            glutSolidCube(1);
            glScalef(0.333333,5,1);
           glTranslatef(-0.5,-0.40,0);
   glPopMatrix;
        glTranslatef(5,0,0);
 glEndList;

 glNewList(_T_D,GL_COMPILE);
   glPushMatrix;
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

           glTranslatef(2,-0.4,0);
            glScalef(3,0.2,1);
            glutSolidCube(1);
            glScalef(0.333333,5,1);
           glTranslatef(-0.2,0.8,0);

            glScalef(2.75,0.2,1);
            glutSolidCube(1);
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
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

           glTranslatef(2,-0.4,0);
            glScalef(3,0.2,1);
            glutSolidCube(1);
            glScalef(0.33333,5,1);
           glTranslatef(-0.2,0.8,0);

            glScalef(2.75,0.2,1);
            glutSolidCube(1);
            glScalef(0.33333,5,1);
           glTranslatef(-0.5,-0.40,0);

            glScalef(2,0.15,1);
            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(5,0,0);
 glEndList;

 glNewList(_T_F,GL_COMPILE);
   glPushMatrix;
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

           glTranslatef(2,-0.4,0);
            glScalef(3,0.2,1);
            glScalef(0.33333,5,1);
           glTranslatef(-0.2,0.8,0);

            glScalef(2.75,0.2,1);
            glutSolidCube(1);
            glScalef(0.33333,5,1);
           glTranslatef(-0.5,-0.40,0);

            glScalef(2,0.15,1);
            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(5,0,0);
 glEndList;

 glNewList(_T_G,GL_COMPILE);
   glPushMatrix;
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

           glTranslatef(2,-0.4,0);
            glScalef(3,0.2,1);
            glutSolidCube(1);
            glScalef(0.33333,5,1);
           glTranslatef(-0.2,0.8,0);

            glScalef(2.75,0.2,1);
            glutSolidCube(1);
            glScalef(0.33333,5,1);
           glTranslatef(-0.5,-0.40,0);

           glTranslatef(2,-0.15,0);
            glScalef(1,0.3,1);
            glutSolidCube(1);
            glScalef(1,3.3333333,1);
           glTranslatef(-1.2,0.15,0);
            glScalef(1.5,0.2,1);
            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(5,0,0);
 glEndList;

 glNewList(_T_H,GL_COMPILE);
   glPushMatrix;
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

           glTranslatef(1.5,0,0);
            glScalef(2,0.2,1);
            glutSolidCube(1);
            glScalef(0.5,5,1);
           glTranslatef(1.5,0,0);

            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(5,0,0);
 glEndList;

 glNewList(_T_N,GL_COMPILE);
   glPushMatrix;
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);
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
            glScalef(1,5.5,1);
            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(5,0,0);
 glEndList;

 glNewList(_T_I,GL_COMPILE);
   glPushMatrix;
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

   glPopMatrix;
        glTranslatef(3,0,0);
 glEndList;

 glNewList(_T_J,GL_COMPILE);
        glTranslatef(0.5,0,0);
   glPushMatrix;
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);
           glTranslatef(-0.5,-0.4,0);
            glScalef(1,0.2,1);
            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(2,0,0);
 glEndList;

 glNewList(_T_K,GL_COMPILE);
   glPushMatrix;
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
           glTranslatef(0,-4,0);
            glutSolidCube(1);

           glTranslatef(-0.5,1,0);
            glutSolidCube(1);

   glPopMatrix;
        glTranslatef(4.5,0,0);
 glEndList;

 glNewList(_T_L,GL_COMPILE);
   glPushMatrix;
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
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);
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
           glTranslatef(0.5,-2,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(7,0,0);
 glEndList;

 glNewList(_T_H,GL_COMPILE);
   glPushMatrix;
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

           glTranslatef(1.5,0,0);
            glScalef(2,0.2,1);
            glutSolidCube(1);
            glScalef(0.5,5,1);
           glTranslatef(1.5,0,0);

            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(5,0,0);
 glEndList;

 glNewList(_T_O,GL_COMPILE);
   glPushMatrix;
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

           glTranslatef(1.5,-0.4,0);
            glScalef(2,0.2,1);
            glutSolidCube(1);
            glScalef(0.5,5,1);
           glTranslatef(-1.5,0.4,0);

           glTranslatef(1.5,0.4,0);
            glScalef(2,0.2,1);
            glutSolidCube(1);
            glScalef(0.5,5,1);
           glTranslatef(1.5,-0.4,0);

            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(5,0,0);
 glEndList;

 glNewList(_T_P,GL_COMPILE);
   glPushMatrix;
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

           glTranslatef(1,0,0);
            glScalef(1,0.2,1);
            glutSolidCube(1);
           glTranslatef(1.2,0,0);
                glScalef(1.85,1,1);
                glutSolidCube(1);
        glScalef(0.57142857,1,1);

           glTranslatef(0.35,1,0);
            glutSolidCube(1);
           glTranslatef(-1,1,0);
            glScalef(3,1,1);
            glutSolidCube(1);

   glPopMatrix;
        glTranslatef(4.5,0,0);
 glEndList;

 glNewList(_T_Q,GL_COMPILE);
   glPushMatrix;
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

           glTranslatef(1.5,-0.4,0);
            glScalef(2,0.2,1);
            glutSolidCube(1);
            glScalef(0.5,5,1);

           glTranslatef(-1.5,0.4,0);

           glTranslatef(1.5,0.4,0);
            glScalef(2,0.2,1);
            glutSolidCube(1);

            glScalef(0.5,5,1);
           glTranslatef(1.5,-0.5,0);

            glScalef(1,1.2,1);
            glutSolidCube(1);
            glScalef(1,0.166666,1);

           glTranslatef(1,-2.5,0);
            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(5,0,0);
 glEndList;


 glNewList(_T_R,GL_COMPILE);
   glPushMatrix;
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
           glTranslatef(-0.75,1,0);
            glScalef(2.5,1,1);
            glutSolidCube(1);
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
           glTranslatef(-1,-1.5,0);
            glScalef(3,1,1);
            glutSolidCube(1);
            glScalef(0.33333,1,1);
           glTranslatef(1,1.25,0);
            glScalef(1,1.5,1);
            glutSolidCube(1);
            glScalef(1,0.6666666666,1);

           glTranslatef(-1,1.25,0);
            glScalef(3,1,1);
            glutSolidCube(1);
            glScalef(0.333333,1,1);

           glTranslatef(-1,1,0);
            glutSolidCube(1);

           glTranslatef(1,1,0);
            glScalef(3,1,1);
            glutSolidCube(1);
            glScalef(0.333333,1,1);

   glPopMatrix;
        glTranslatef(2.5,0,0);
 glEndList;

 glNewList(_T_T,GL_COMPILE);
        glTranslatef(1.5,0,0);
   glPushMatrix;
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);
           glTranslatef(0,0.4,0);
            glScalef(4,0.2,1);
            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(3.5,0,0);
 glEndList;

 glNewList(_T_U,GL_COMPILE);
   glPushMatrix;
           glTranslatef(0,0.75,0);
            glScalef(1,5.5,1);
            glutSolidCube(1);

           glTranslatef(1.5,-0.4,0);
            glScalef(2,0.2,1);
            glutSolidCube(1);
            glScalef(0.5,5,1);
           glTranslatef(1.5,0.4,0);
            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(6,0,0);
 glEndList;

 glNewList(_T_V,GL_COMPILE);
   glPushMatrix;

           glTranslatef(0,-1.5,0);
            glutSolidCube(1);

           glTranslatef(1,1.5,0);
            glScalef(1,2,1);
            glutSolidCube(1);

           glTranslatef(-2,0,0);
            glutSolidCube(1);
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
           glTranslatef(0.5,-2.65,0);
            glScalef(1,4.3,1);
            glutSolidCube(1);
            glScalef(1,0.2325581,1);

           glTranslatef(-5,0,0);
            glScalef(1,4.3,1);
            glutSolidCube(1);
   glPopMatrix;
        glTranslatef(8,0,0);
 glEndList;

 glNewList(_T_X,GL_COMPILE);
   glPushMatrix;

           glTranslatef(2,0.5,0);
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
           glTranslatef(0,-1,0);
            glScalef(1,2,1);
            glutSolidCube(1);
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
   glPopMatrix;
        glTranslatef(5,0,0);
 glEndList;

 glNewList(_T_Z,GL_COMPILE);
   glPushMatrix;

           glTranslatef(0,0.5,0);
            glutSolidCube(1);

           glTranslatef(1,1,0);
            glutSolidCube(1);

           glTranslatef(-1.25,1,0);
           glScalef(3.5,1,1);
            glutSolidCube(1);
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


procedure       _SIN;
asm
        FSIN
        FNSTSW  AX
        SAHF
        JP      @@outOfRange
        RET
@@outOfRange:
        FSTP    st(0)   { for now, return 0. result would       }
        FLDZ            { have little significance anyway       }
end;

function Hevi( into : GLfloat) : GLfloat;
begin

  if into > 0 then Result := into
  else Result := 0;

end;


{------------------------------------------------------------------}
{  Function to draw the actual scene                               }
{------------------------------------------------------------------}
procedure glDraw();
const
  count = 55;

var
  Row : LongWord;
  Order : LongWord;

  i : GLint;

  colorAR: array [0..count, 0..2] of GLfloat;

begin

  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);    // Clear The Screen And The Depth Buffer
  glLoadIdentity();


  Order := _FMUSIC_GetOrder(Module);
  Row := _FMUSIC_GetRow(Module);

//  SetWindowText(h_Wnd,PChar(IntToStr(Order)));

  //main
  glTranslatef(0,0,-12);

    case order of
    0..12,13..35,38..43:
      for i := 0 to count do begin
        colorAR[i,0] := 0;
        colorAR[i,1] := hevi( sin( (row + 1) * 0.125 * 90 * pic   - i * 22.5*pic)) - 0.1;
        colorAR[i,2] := 0;
      end;
    end;

    case Order of
                  
      0: begin
      
        glRotatef( 30 , 1,0,0);
        glRotatef( 60 , 0,1,0);

        for i := 0 to count do begin
          colorAR[i,0] := 0;
          colorAR[i,1] := 0;
          colorAR[i,2] := 0;
        end;

          for i := 0 to row - 8 do begin
            colorAR[i,0] := hevi( sin( (row + 1) * 0.125 * 90 * pic  - i *  pic - 60)) ;
            colorAR[i,1] := hevi( sin( (row + 1) * 0.125 * 90 * pic  - i *  pic)) - 0.1 ;
            colorAR[i,2] := 0;
          end;

      end;

      1:begin


        glRotatef( -90 , 1,0,0);

        for i := 0 to count do begin
          colorAR[i,0] := 0;
          colorAR[i,1] := 0;
          colorAR[i,2] := 0;
        end;

        for i := 0 to 15 do begin
         colorAR[i,0] := hevi( sin( (row + 1) * 0.125 * 90 * pic   - i * 22.5*pic     )) - 0.1;
         colorAR[i,1] := hevi( sin( (row + 1) * 0.125 * 90 * pic   - i * 22.5*pic - 45)) - 0.1;
         colorAR[i,2] := 0;
       end;

         
                       (*
        glRotatef( 30 , 1,0,0);
        glRotatef( -60 , 0,1,0);

      for i := 0 to count do begin
        colorAR[i,0] := hevi( sin( (row + 1) * 0.125 * 90 * pic   - i * 22.5*pic - 45)) - 0.1;;
        colorAR[i,1] := hevi( sin( (row + 1) * 0.125 * 90 * pic   - i * 22.5*pic     )) - 0.1;
        colorAR[i,2] := 0;
      end;
      *)


      end;

      2..4: begin

        glRotatef( -90 , 1,0,0);

        for i := 0 to count do begin
          colorAR[i,0] := 0;
          colorAR[i,1] := 0;
          colorAR[i,2] := 0;
        end;

         colorAR[6,0] := hevi( sin( (row + 1) * 0.125 * 90 * pic  -                 45)) - 0.1;
         colorAR[6,1] := hevi( sin( (row + 1) * 0.125 * 90 * pic                      )) - 0.1;

         colorAR[5,0] := hevi( sin( (row + 1) * 0.125 * 90 * pic  - 1  * 22.5*pic - 45)) - 0.1;
         colorAR[5,1] := hevi( sin( (row + 1) * 0.125 * 90 * pic  - 1  * 22.5*pic     )) - 0.1;

         colorAR[9,0] := hevi( sin( (row + 1) * 0.125 * 90 * pic  - 2 * 22.5*pic - 45)) - 0.1;
         colorAR[9,1] := hevi( sin( (row + 1) * 0.125 * 90 * pic  - 2 * 22.5*pic     )) - 0.1;

         colorAR[10,0] := hevi( sin( (row + 1) * 0.125 * 90 * pic - 3 * 22.5*pic - 45)) - 0.1;
         colorAR[10,1] := hevi( sin( (row + 1) * 0.125 * 90 * pic - 3 * 22.5*pic     )) - 0.1;

         colorAR[11,0] := hevi( sin( (row + 1) * 0.125 * 90 * pic - 4 * 22.5*pic - 45)) - 0.1;
         colorAR[11,1] := hevi( sin( (row + 1) * 0.125 * 90 * pic - 4 * 22.5*pic     )) - 0.1;

         colorAR[7,0] := hevi( sin( (row + 1) * 0.125 * 90 * pic  - 5 * 22.5*pic - 45)) - 0.1;
         colorAR[7,1] := hevi( sin( (row + 1) * 0.125 * 90 * pic  - 5 * 22.5*pic     )) - 0.1;

         colorAR[3,0] := hevi( sin( (row + 1) * 0.125 * 90 * pic  - 6 * 22.5*pic - 45)) - 0.1;
         colorAR[3,1] := hevi( sin( (row + 1) * 0.125 * 90 * pic  - 6 * 22.5*pic     )) - 0.1;

         colorAR[2,0] := hevi( sin( (row + 1) * 0.125 * 90 * pic  - 7 * 22.5*pic - 45)) - 0.1;
         colorAR[2,1] := hevi( sin( (row + 1) * 0.125 * 90 * pic  - 7 * 22.5*pic     )) - 0.1;

         colorAR[1,0] := hevi( sin( (row + 1) * 0.125 * 90 * pic  - 8 * 22.5*pic - 45)) - 0.1;
         colorAR[1,1] := hevi( sin( (row + 1) * 0.125 * 90 * pic  - 8 * 22.5*pic     )) - 0.1;

         colorAR[0,0] := hevi( sin( (row + 1) * 0.125 * 90 * pic  - 9 * 22.5*pic - 45)) - 0.1;
         colorAR[0,1] := hevi( sin( (row + 1) * 0.125 * 90 * pic  - 9 * 22.5*pic     )) - 0.1;


         colorAR[4,0] := hevi( sin( (row + 1) * 0.125 * 90 * pic  - 10* 22.5*pic - 45)) - 0.1;
         colorAR[4,1] := hevi( sin( (row + 1) * 0.125 * 90 * pic  - 10* 22.5*pic     )) - 0.1;

         colorAR[8,0] := hevi( sin( (row + 1) * 0.125 * 90 * pic  - 11 * 22.5*pic - 45)) - 0.1;
         colorAR[8,1] := hevi( sin( (row + 1) * 0.125 * 90 * pic  - 11 * 22.5*pic     )) - 0.1;

         colorAR[12,0] := hevi( sin( (row + 1) * 0.125 * 90 * pic - 12 * 22.5*pic - 45)) - 0.1;
         colorAR[12,1] := hevi( sin( (row + 1) * 0.125 * 90 * pic - 12 * 22.5*pic     )) - 0.1;

         colorAR[13,0] := hevi( sin( (row + 1) * 0.125 * 90 * pic - 13 * 22.5*pic - 45)) - 0.1;
         colorAR[13,1] := hevi( sin( (row + 1) * 0.125 * 90 * pic - 13 * 22.5*pic     )) - 0.1;

         colorAR[14,0] := hevi( sin( (row + 1) * 0.125 * 90 * pic - 14 * 22.5*pic - 45)) - 0.1;
         colorAR[14,1] := hevi( sin( (row + 1) * 0.125 * 90 * pic - 14 * 22.5*pic     )) - 0.1;

         colorAR[15,0] := hevi( sin( (row + 1) * 0.125 * 90 * pic - 15 * 22.5*pic - 45)) - 0.1;
         colorAR[15,1] := hevi( sin( (row + 1) * 0.125 * 90 * pic - 15 * 22.5*pic     )) - 0.1;

      end;

      5..7: begin
      
        glRotatef( 30 , 1,0,0);
        glRotatef( -60 , 0,1,0);

      for i := 0 to count do begin
        colorAR[i,0] := hevi( sin( (row + 1) * 0.125 * 90 * pic   - i * 22.5*pic - 45)) - 0.1;;
        colorAR[i,1] := hevi( sin( (row + 1) * 0.125 * 90 * pic   - i * 22.5*pic     )) - 0.1;
        colorAR[i,2] := 0;
      end;

      end;

      8..10: begin

        glRotatef( _FMUSIC_GetTime(Module)* 0.05 , -1,0,0);
        glRotatef( 30 , 0,0,1);

        for i := 0 to count do begin
         colorAR[i,0] :=  0.0 ;
         colorAR[i,1] := hevi( sin( (row + 1) * 0.125 * 90 * pic - i * 22.5*pic - 45) ) ;
         colorAR[i,2] := 0;
        end;

      end;
       
      11..12: begin

        glRotatef( _FMUSIC_GetTime(Module)* 0.05 , 1,1,0);
        glRotatef( 30 , 1,0,0);
        glRotatef( -60 , 0,1,0);

        for i := 0 to count do begin
         colorAR[i,0] :=  sin( (row + 1) * 0.25 * 90 * pic - i * 22.5*pic    )+ 1.1 ;
         colorAR[i,1] := hevi( sin( (row + 1) * 0.125 * 90 * pic - i * 22.5*pic - 45) ) ;
         colorAR[i,2] := 0;
       end;



      end;

      13..15: begin
        glRotatef( 30 , 1,0,0);
        glRotatef( 60 , 0,1,0);
        glRotatef( _FMUSIC_GetTime(Module)* 0.05 , -1,1,0);
      end;
              
      16..18:begin
        glRotatef( -30 , 1,0,0);
        glRotatef( 60 , 0,1,0);
        glRotatef( _FMUSIC_GetTime(Module)* 0.05 , -1,1,0);
      end;

      19..21:begin
        glRotatef( 30 , 1,0,0);
        glRotatef( 60 , 0,1,0);
        glRotatef( _FMUSIC_GetTime(Module)* 0.05 , -1,1,0);
      end;

      22..24:begin
        glRotatef( 30 , 1,0,0);
        glRotatef( 60 , 0,1,0);
        glRotatef( _FMUSIC_GetTime(Module)* 0.05 , 0,1,0);
      end;

      25..28:begin
        glRotatef( 60 , 1,0,0);
        glRotatef( 60 , 0,1,0);
        glRotatef( _FMUSIC_GetTime(Module)* 0.05 , 0,1,0);
      end;

      29..31:begin
        glRotatef( 60 , -1,0,0);
        glRotatef( _FMUSIC_GetTime(Module)* 0.05 , 0,1,0);
      end;

      32..35:begin
        glRotatef( 60 , -1,0,1);
        glRotatef( _FMUSIC_GetTime(Module)* 0.05 , 0,1,0);
      end;

      
      36..37:begin
        glRotatef( 60 , -1,0,1);
        glTranslatef(0,1.5,0);

        for i := 16 to count do begin

          colorAR[i,0] := 0;
          colorAR[i,1] := 0;
          colorAR[i,2] := 0;

        end;

        If Row < 32 then

          for i := 0 to 15 do begin
            colorAR[i,0] := hevi( sin( (row + 1) * 0.125 * 90 * pic  - i * 5.625 * pic -  45)) ;
            colorAR[i,1] := hevi( sin( (row + 1) * 0.125 * 90 * pic  - i * 5.625 * pic)) - 0.1 ;
            colorAR[i,2] := 0;
          end
        else
          for i := 0 to 15 do begin
            colorAR[i,0] := hevi( sin( (row + 1) * 0.125 * 90 * pic  - i * 5.625 * pic )) ;
            colorAR[i,1] := hevi( sin( (row + 1) * 0.125 * 90 * pic  - i * 5.625 * pic - 45))  ;
            colorAR[i,2] := 0;
          end;
      end;

      38:;

      39:begin
        glRotatef( _FMUSIC_GetTime(Module)* 0.05 , 0,1,0);
      end;
               
      40..42:begin
        glRotatef( 30 , 1,0,0);
        glRotatef( 60 , 0,1,0);
        glRotatef( _FMUSIC_GetTime(Module)* 0.05 , -1,1,0);
      end;
      
      43:begin

        case Row of

          0..31:begin
            glTranslatef(0, 0, -5);
            glRotatef( 30 , 1,0,0);
            glRotatef( 60 , 0,1,0);
            glRotatef( _FMUSIC_GetTime(Module)* 0.01 , 0,1,0);
          end;

          32..39:begin
            glTranslatef(0, 0, -7);
            glRotatef( -30 , 1,0,0);
            glRotatef( 60 , 0,1,0);
            glRotatef( _FMUSIC_GetTime(Module)* 0.01 , 0,1,0);
          end;

          40..47:begin
            glTranslatef(0, 0, -9);
            glRotatef( 30 , 1,0,0);
            glRotatef( -60 , 0,1,0);
            glRotatef( _FMUSIC_GetTime(Module)* 0.01 , 0,1,0);
          end;

          48..55:begin
            glTranslatef(0, 0, -7);
            glRotatef( -30 , 1,0,0);
            glRotatef( 60 , 0,1,0);
            glRotatef( _FMUSIC_GetTime(Module)* 0.01 , 0,1,0);
          end;

          56..63:begin
            glTranslatef(0, 0, -5);
            glRotatef( 30 , 1,0,0);
            glRotatef( -60 , 0,1,0);
            glRotatef( _FMUSIC_GetTime(Module)* 0.01 , 0,1,0);
          end; 
        end;
                
      end;

      44,45:begin

            glTranslatef(0, 0, -5);
            glRotatef( 30 , 1,0,0);

        for i := 0 to count do begin
          colorAR[i,0] := 0;
          colorAR[i,1] := 0;
          colorAR[i,2] := 0;
        end;

        If Row < 23 then  begin

          for i := 0 to count do begin

            colorAR[i,0] := hevi( sin( (row + 1) * 0.125 * 90 * pic  - 90)) ;
            colorAR[i,1] := hevi( sin( (row + 1) * 0.125 * 90 * pic  - i *  pic     )) - 0.1 ;
            colorAR[i,2] := 0;
          end;

            glRotatef( _FMUSIC_GetTime(Module)* 0.01 + 45, 0,1,0);

        end
        else begin
          for i := 0 to count do begin

            colorAR[i,0] := hevi( sin( (row + 1) * 0.125 * 90 * pic  - i * (360/56) * pic )) ;
            colorAR[i,1] := hevi( sin( (row + 1) * 0.125 * 90 * pic  - i * (360/56) * pic - 45))  ;
            colorAR[i,2] := 0;
          end;

           glRotatef( _FMUSIC_GetTime(Module)* 0.01 , 0,1,0);

        end;

        if (Order = 45) and (Row > 62) then keys_ := True;

      end;    


    end;

  //first
    //first
    glColor3fv(@colorAr[0,0]);
    glTranslatef(-2.25,-2.25,2.25);
    glutSolidCube(1);

    glColor3fv(@colorAr[1,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[2,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[3,0]);    
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    //second
    glTranslatef(-1.5,1.5,0);

    glColor3fv(@colorAr[16,0]);
    glTranslatef(-3,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[17,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[18,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[19,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    //third
    glTranslatef(-1.5,1.5,0);

    glColor3fv(@colorAr[28,0]);
    glTranslatef(-3,0,0);
    glutSolidCube(1);


    glColor3fv(@colorAr[29,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[30,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[31,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    //forth
    glTranslatef(-1.5,1.5,0);

    glColor3fv(@colorAr[40,0]);
    glTranslatef(-3,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[41,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[42,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[43,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);



  //second
    //first
    glColor3fv(@colorAr[4,0]);
    glTranslatef(-4.5,-4.5,-1.5);
    glutSolidCube(1);

    glColor3fv(@colorAr[5,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[6,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[7,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    //second
    glTranslatef(-1.5,1.5,0);

    glColor3fv(@colorAr[20,0]);
    glTranslatef(-3,0,0);
    glutSolidCube(1);

        //color := sin( (row + 1) * 0.25 * 90*pic - 90*pic);
        //glColor3f(color,0,0);
    glTranslatef(1.5,0,0);
        //glutSolidCube(1);

        //color := sin( (row + 1) * 0.25 * 90*pic - 90*pic);
        //glColor3f(color,0,0);
    glTranslatef(1.5,0,0);
        //glutSolidCube(1);

    glColor3fv(@colorAr[21,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    //third
    glTranslatef(-1.5,1.5,0);

    glColor3fv(@colorAr[32,0]);
    glTranslatef(-3,0,0);
    glutSolidCube(1);

        //color := sin( (row + 1) * 0.25 * 90*pic - 90*pic);
        //glColor3f(color,0,0);
    glTranslatef(1.5,0,0);
        //glutSolidCube(1);

        //color := sin( (row + 1) * 0.25 * 90*pic - 90*pic);
        //glColor3f(color,0,0);
    glTranslatef(1.5,0,0);
        //glutSolidCube(1);

    glColor3fv(@colorAr[33,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    //forth
    glTranslatef(-1.5,1.5,0);

    glColor3fv(@colorAr[44,0]);
    glTranslatef(-3,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[45,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[46,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[47,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);



  //third
    //first
    glColor3fv(@colorAr[8,0]);
    glTranslatef(-4.5,-4.5,-1.5);
    glutSolidCube(1);

    glColor3fv(@colorAr[9,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[10,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[11,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    //second
    glTranslatef(-1.5,1.5,0);

    glColor3fv(@colorAr[22,0]);
    glTranslatef(-3,0,0);
    glutSolidCube(1);

        //color := sin( (row + 1) * 0.25 * 90*pic - 90*pic);
        //glColor3f(color,0,0);
    glTranslatef(1.5,0,0);
        //glutSolidCube(1);

        //color := sin( (row + 1) * 0.25 * 90*pic - 90*pic);
        //glColor3f(color,0,0);
    glTranslatef(1.5,0,0);
        //glutSolidCube(1);

    glColor3fv(@colorAr[23,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    //third
    glTranslatef(-1.5,1.5,0);

    glColor3fv(@colorAr[34,0]);
    glTranslatef(-3,0,0);
    glutSolidCube(1);

        //color := sin( (row + 1) * 0.25 * 90*pic - 90*pic);
        //glColor3f(color,0,0);
    glTranslatef(1.5,0,0);
    //glutSolidCube(1);

        //color := sin( (row + 1) * 0.25 * 90*pic - 90*pic);
        //glColor3f(color,0,0);
    glTranslatef(1.5,0,0);
    //glutSolidCube(1);

    glColor3fv(@colorAr[35,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    //forth
    glTranslatef(-1.5,1.5,0);

    glColor3fv(@colorAr[48,0]);
    glTranslatef(-3,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[49,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[50,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[51,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);




  //forth
    //first
    glColor3fv(@colorAr[12,0]);
    glTranslatef(-4.5,-4.5,-1.5);
    glutSolidCube(1);

    glColor3fv(@colorAr[13,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[14,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[15,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    //second
    glTranslatef(-1.5,1.5,0);

    glColor3fv(@colorAr[24,0]);
    glTranslatef(-3,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[25,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[26,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[27,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    //third
    glTranslatef(-1.5,1.5,0);

    glColor3fv(@colorAr[36,0]);
    glTranslatef(-3,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[37,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[38,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[39,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    //forth
    glTranslatef(-1.5,1.5,0);

    glColor3fv(@colorAr[52,0]);
    glTranslatef(-3,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[53,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[54,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    glColor3fv(@colorAr[55,0]);
    glTranslatef(1.5,0,0);
    glutSolidCube(1);

    case Order of

      22..35 :begin


        Textro := Row + 64 * (Order - 22);

        glPushMatrix;

          glDisable(GL_DEPTH_TEST);
          glDisable(GL_LIGHTING);

          glLoadIdentity();

//          glTranslatef(72 - Textro * 0.8 ,-54.0,-140.0);
          glTranslatef(59 - Textro * 0.8 ,20.0,-110.0);
             glColor3f(1,1,1);

             glCallList(_T_G);
             glCallList(_T_R);
             glCallList(_T_E);
             glCallList(_T_E);
             glCallList(_T_T);
             glCallList(_T_I);
             glCallList(_T_N);
             glCallList(_T_G);
          glTranslatef(5  ,0,0);
             glCallList(_T_T);
             glCallList(_T_O);
          glTranslatef(-15 ,-20,0);
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
          glTranslatef(15 ,20,0);
             glCallList(_T_B);
             glCallList(_T_I);
             glCallList(_T_T);
             glCallList(_T_L);
          glTranslatef(5 ,-30,0);
             glCallList(_T_M);
             glCallList(_T_A);
             glCallList(_T_N);
             glCallList(_T_W);
             glCallList(_T_E);
          glTranslatef(5 ,40,0);
             glCallList(_T_F);
             glCallList(_T_O);
             glCallList(_T_X);
          glTranslatef(5 ,-60,0);
             glCallList(_T_T);
             glCallList(_T_O);
             glCallList(_T_N);
             glCallList(_T_E);
          glTranslatef(5 ,40,0);
             glCallList(_T_L);
             glCallList(_T_I);
             glCallList(_T_Z);
             glTranslatef(0.5 ,0,0);
             glCallList(_T_Z);
             glCallList(_T_A);
             glCallList(_T_R);
             glCallList(_T_D);
          glTranslatef(5 ,-30,0);
             glCallList(_T_P);
             glCallList(_T_R);
             glCallList(_T_E);
             glCallList(_T_S);
             glCallList(_T_T);
             glCallList(_T_O);
             glCallList(_T_N);
          glTranslatef(5 ,20,0);
             glCallList(_T_v);
             glCallList(_T_e);
             glCallList(_T_D);
             glCallList(_T_E);
             glCallList(_T_m);
          glTranslatef(5 ,-20,0);
             glCallList(_T_u);
             glCallList(_T_n);
             glCallList(_T_c);
          glTranslatef(5 ,30,0);
             glCallList(_T_I);
             glCallList(_T_Z);
             glCallList(_T_e);
             glCallList(_T_D);
          glTranslatef(5 ,-40,0);
             glCallList(_T_I);
             glCallList(_T_c);
             glCallList(_T_e);
             glCallList(_T_f);
             glCallList(_T_a);
             glCallList(_T_l);
             glCallList(_T_l);
          glTranslatef(-15 ,50,0);
             glCallList(_T_v);
             glCallList(_T_I);
             glCallList(_T_N);
             glCallList(_T_N);
             glCallList(_T_N);
             glCallList(_T_Y);
          glTranslatef(5 ,-20,0);
             glCallList(_T_f);
             glCallList(_T_l);
             glCallList(_T_a);
             glCallList(_T_f);
             glCallList(_T_x);
          glTranslatef(15 ,-20,0);
             glCallList(_T_Q);
             glCallList(_T_U);
             glCallList(_T_I);
             glCallList(_T_T);
             glCallList(_T_E);
          glTranslatef(5 ,30,0);
             glCallList(_T_D);
             glCallList(_T_E);
             glCallList(_T_M);
             glCallList(_T_A);
             glCallList(_T_R);
             glCallList(_T_c);
             glCallList(_T_H);
             glCallList(_T_E);
          glTranslatef(5 ,-40,0);
             glCallList(_T_t);
             glCallList(_T_R);
             glCallList(_T_E);
             glCallList(_T_X);
          glTranslatef(5 ,50,0);
             glCallList(_T_s);
             glCallList(_T_a);
             glCallList(_T_n);
             glCallList(_T_d);
             glCallList(_T_s);
          glTranslatef(5 ,-20,0);
             glCallList(_T_s);
             glCallList(_T_k);
             glCallList(_T_r);
             glCallList(_T_j);
             glCallList(_T_u);

          glEnable(GL_LIGHTING);
          glEnable(GL_DEPTH_TEST);

        glPopMatrix;

      end;

      45:BEGIN
        glPushMatrix;

          glDisable(GL_DEPTH_TEST);
          glDisable(GL_LIGHTING);

          glLoadIdentity();

          glTranslatef(-25 ,10.0,-70.0);
             glColor3f(1,1,1);

             glCallList(_T_T);
             glCallList(_T_H);
             glCallList(_T_A);
             glCallList(_T_N);
             glCallList(_T_K);
             glCallList(_T_S);
          glTranslatef(5  ,0,0);
             glCallList(_T_F);
             glCallList(_T_O);
             glCallList(_T_r);
          glTranslatef(-42  ,-10,0);
             glCallList(_T_L);
             glCallList(_T_I);
             glCallList(_T_S);
             glCallList(_T_T);
             glCallList(_T_E);
             glCallList(_T_N);
             glCallList(_T_I);
             glCallList(_T_N);
             glCallList(_T_G);
          glTranslatef(-47 ,-10,0);
             glCallList(_T_O);
             glCallList(_T_r);
          glTranslatef(5  ,0,0);
             glCallList(_T_W);
             glCallList(_T_A);
             glCallList(_T_T);
             glCallList(_T_C);
             glCallList(_T_H);
             glCallList(_T_I);
             glCallList(_T_N);
             glCallList(_T_G);


          glTranslatef(-30 ,-30,-50);
             glCallList(_T_d);
             glCallList(_T_I);
             glCallList(_T_H);
             glCallList(_T_A);
             glCallList(_T_L);
             glCallList(_T_T);
          glTranslatef(5  ,0,0);
             glCallList(_T_Z);
             glCallList(_T_O);
             glCallList(_T_I);
             glCallList(_T_O);

          glEnable(GL_LIGHTING);
          glEnable(GL_DEPTH_TEST);

        glPopMatrix;

      end;

    end;

  glFlush;
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
      {
    WM_TIMER :                     // Add code here for all timers to be used.
      begin

        if wParam = FPS_TIMER then
        begin
          Result := 0;
        end;
      end;
      }
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
//  SetTimer(h_Wnd, FPS_TIMER, FPS_INTERVAL, nil);

  // Settings to ensure that the window is the topmost window
  ShowWindow(h_Wnd, SW_SHOW);
  SetForegroundWindow(h_Wnd);
  SetFocus(h_Wnd);

  // Ensure the OpenGL window is resized properly
  glResizeWnd(Width, Height);


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

  If MessageBox(h_Wnd,'Fullscreen (1024x768x16) ?','SCRIMERS First 32K Trackmo',MB_OKCANCEL) = IDOK then begin
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
//  glClearDepth(1.0);                       // Depth Buffer Setup
  glEnable(GL_DEPTH_TEST);                 // Enable Depth Buffer
  glDepthFunc(GL_LESS);		           // The Type Of Depth Test To Do

  glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);   //Realy Nice perspective calculations
  {
  glClearAccum(0.0, 0.0, 0.0, 1.0);
  glClear(GL_ACCUM_BUFFER_BIT);

  glHint(GL_LINE_SMOOTH_HINT, GL_NICEST);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); ///!!!  FIRE
  //используйте GL_ONE если вам нужен аддитивный цвет
                  }
//    glBlendFunc(GL_SRC_ALPHA, GL_DST_ALPHA);

  glEnable(GL_LINE_SMOOTH);
  glEnable(GL_POINT_SMOOTH);
  glEnable(GL_SMOOTH);
  glEnable(GL_BLEND);

 glEnable(GL_LIGHTING);
 glEnable(GL_LIGHT0);

 glEnable (GL_COLOR_MATERIAL);  //BLACK_AND_WHITE - in comment
 {
 glEnable (GL_ALPHA_TEST);
 glAlphaFunc( GL_GREATER, 0.1 );
 glLightModeli(GL_LIGHT_MODEL_TWO_SIDE,1);

}
  PreSceneWords;

  XMPlayFromRes('XMMOD','MUSIC');    //play music

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


//      ElapsedTime :=_FMUSIC_GetTime(Module);//GetTickCount();                // Calculate elapsed time in milliseconds                                       !!!!!!!!!!!!!

      glDraw();                           // Draw the scene

      SwapBuffers(h_DC);                  // Display the scene

      SetWindowText(h_Wnd,Inttostr(_FMUSIC_GetOrder(Module)))
      if keys_ then           // If user pressed ESC then set finised TRUE
        finished := True ;

    end;
  end;
  glKillWnd(FALSE);
  Result := msg.wParam;
end;


begin
  WinMain( hInstance, hPrevInst, CmdLine, CmdShow );
  XMFree;
end.
