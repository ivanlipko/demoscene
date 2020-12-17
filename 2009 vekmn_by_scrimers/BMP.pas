unit BMP;

interface

uses
  Windows,
  OpenGL;

const
//      GL_N3F_V3F                                 = $2A25;

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


procedure DrawBox(Size : GLfloat; DrawType : GLenum);
procedure glutSolidCube(Size : GLDouble);
procedure glInterleavedArrays (format: GlEnum; stride: Glsizei; data: pointer);     stdcall;     external OpenGL32;
procedure glDrawArrays(mode:GLenum; first:GLint; count:GLsizei); stdcall; external OpenGL32;
procedure glBindTexture(target: GLenum; texture: GLuint); stdcall; external opengl32;

var
// light
  LightPos : Array [0..3] of GLfloat;
  Delta : GLfloat;
  Ambient, Specular, Diffuse : Array [0..3] of GLfloat;
//  MaterialAmbient, MaterialSpecular,
//  MaterialDiffuse, MaterialEmission : Array [0..3] of GLfloat;
//  SHININESS : GLfloat;

  //geometry
  ArrayBOX : array [0..71] of GLfloat;//72   // BOX

        //alpha channel
        q:GLfloat = 0.9;//0.9

//timer
  ElapsedTime : Integer=0;             // Elapsed time between frames
  ElapsedTime_ : Integer=0;             // Elapsed time between 0,1 amd 2 row
  ElapsedTime_1 : Integer=0;             // Elapsed time between

//very importnat ; SOUND Synhro
  //***
  NowOrder, NowRow :Integer;

implementation

procedure DrawBox(Size :GLfloat; DrawType : GLenum);
        var  V :array[0..7, 0..2] of GLfloat;
          I,j : GLint;
          HalfSize : GLfloat;
        begin { DrawBox }
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
          for I := 0 to 5 do
           begin
                {}
            glBegin(DrawType);
            glNormal3fv(@BoxPoints[I, 0]);

            glVertex3fv(@V[BoxFaces[I, 0], 0]);
            glVertex3fv(@V[BoxFaces[I, 1], 0]);
            glVertex3fv(@V[BoxFaces[I, 2], 0]);
            glVertex3fv(@V[BoxFaces[I, 3], 0]);
            glEnd;

                    {

            ArrayBOX[j+3] := V[BoxFaces[I, 0], 0];
            ArrayBOX[j+4] := V[BoxFaces[I, 0], 1];
            ArrayBOX[j+5] := V[BoxFaces[I, 0], 2];

            ArrayBOX[j+3] := V[BoxFaces[I, 0], 0];
            ArrayBOX[j+4] := V[BoxFaces[I, 0], 1];
            ArrayBOX[j+5] := V[BoxFaces[I, 0], 2];

            inc(j,24);
                         {}

           end;
//                 glInterleavedArrays (GL_V3F, 0, @ArrayBOX);
         end; { DrawBox }



procedure glutSolidCube(Size :GLDouble);
        begin { glutSolidCube }
                DrawBox(Size, GL_QUADS);

//    glPushMatrix;                  // uncalculate machine  }
   {  glScalef(Size,Size,Size);
     glDrawArrays(GL_QUADS, 0, 144);
     glScalef(1/Size,1/Size,1/Size);  // calculate machine
//    glPopMatrix;                  // uncalculate machine}
        end; { glutSolidCube}

end.


///////////////////////////////////////////////////////////////////
                 rozatreee
            ArrayBOX[j]   := BoxPoints[I, 0];
            ArrayBOX[j+1] := BoxPoints[I, 1];
            ArrayBOX[j+2] := BoxPoints[I, 2];

            ArrayBOX[j+3] := V[BoxFaces[I, 0], 0];
            ArrayBOX[j+4] := V[BoxFaces[I, 0], 1];
            ArrayBOX[j+5] := V[BoxFaces[I, 0], 2];

            ArrayBOX[j+6] := 0;//BoxPoints[I, 0];
            ArrayBOX[j+7] := 0;//BoxPoints[I, 1];
            ArrayBOX[j+8] := 0;//BoxPoints[I, 2];

            ArrayBOX[j+9]  := V[BoxFaces[I, 1], 0];
            ArrayBOX[j+10] := V[BoxFaces[I, 1], 1];
            ArrayBOX[j+11] := V[BoxFaces[I, 1], 2];

            ArrayBOX[j+12] := 0;//BoxPoints[I, 0];
            ArrayBOX[j+13] := 0;//BoxPoints[I, 1];
            ArrayBOX[j+14] := 0;//BoxPoints[I, 2];

            ArrayBOX[j+15] := V[BoxFaces[I, 2], 0];
            ArrayBOX[j+16] := V[BoxFaces[I, 2], 1];
            ArrayBOX[j+17] := V[BoxFaces[I, 2], 2];

            ArrayBOX[j+18] := 0;//BoxPoints[I, 0];
            ArrayBOX[j+19] := 0;//BoxPoints[I, 1];
            ArrayBOX[j+20] := 0;//BoxPoints[I, 2];

            ArrayBOX[j+21] := V[BoxFaces[I, 3], 0];
            ArrayBOX[j+22] := V[BoxFaces[I, 3], 1];
            ArrayBOX[j+23] := V[BoxFaces[I, 3], 2];
