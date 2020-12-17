unit scene;

interface
uses
  OpenGL
  ,initscenes

  ;

const

  // Definition of a complete font 
   rasters :array[0..94] of array[0..12] of GLubyte = (
    ($00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00),
    ($00, $00, $18, $18, $00, $00, $18, $18, $18, $18, $18, $18, $18),
    ($00, $00, $00, $00, $00, $00, $00, $00, $00, $36, $36, $36, $36),
    ($00, $00, $00, $66, $66, $ff, $66, $66, $ff, $66, $66, $00, $00),
    ($00, $00, $18, $7e, $ff, $1b, $1f, $7e, $f8, $d8, $ff, $7e, $18),
    ($00, $00, $0e, $1b, $db, $6e, $30, $18, $0c, $76, $db, $d8, $70),
    ($00, $00, $7f, $c6, $cf, $d8, $70, $70, $d8, $cc, $cc, $6c, $38),
    ($00, $00, $00, $00, $00, $00, $00, $00, $00, $18, $1c, $0c, $0e),
    ($00, $00, $0c, $18, $30, $30, $30, $30, $30, $30, $30, $18, $0c),
    ($00, $00, $30, $18, $0c, $0c, $0c, $0c, $0c, $0c, $0c, $18, $30),
    ($00, $00, $00, $00, $99, $5a, $3c, $ff, $3c, $5a, $99, $00, $00),
    ($00, $00, $00, $18, $18, $18, $ff, $ff, $18, $18, $18, $00, $00),
    ($00, $00, $30, $18, $1c, $1c, $00, $00, $00, $00, $00, $00, $00),
    ($00, $00, $00, $00, $00, $00, $ff, $ff, $00, $00, $00, $00, $00),
    ($00, $00, $00, $38, $38, $00, $00, $00, $00, $00, $00, $00, $00),
    ($00, $60, $60, $30, $30, $18, $18, $0c, $0c, $06, $06, $03, $03),
    ($00, $00, $3c, $66, $c3, $e3, $f3, $db, $cf, $c7, $c3, $66, $3c),
    ($00, $00, $7e, $18, $18, $18, $18, $18, $18, $18, $78, $38, $18),
    ($00, $00, $ff, $c0, $c0, $60, $30, $18, $0c, $06, $03, $e7, $7e),
    ($00, $00, $7e, $e7, $03, $03, $07, $7e, $07, $03, $03, $e7, $7e),
    ($00, $00, $0c, $0c, $0c, $0c, $0c, $ff, $cc, $6c, $3c, $1c, $0c),
    ($00, $00, $7e, $e7, $03, $03, $07, $fe, $c0, $c0, $c0, $c0, $ff),
    ($00, $00, $7e, $e7, $c3, $c3, $c7, $fe, $c0, $c0, $c0, $e7, $7e),
    ($00, $00, $30, $30, $30, $30, $18, $0c, $06, $03, $03, $03, $ff),
    ($00, $00, $7e, $e7, $c3, $c3, $e7, $7e, $e7, $c3, $c3, $e7, $7e),
    ($00, $00, $7e, $e7, $03, $03, $03, $7f, $e7, $c3, $c3, $e7, $7e),
    ($00, $00, $00, $38, $38, $00, $00, $38, $38, $00, $00, $00, $00),
    ($00, $00, $30, $18, $1c, $1c, $00, $00, $1c, $1c, $00, $00, $00),
    ($00, $00, $06, $0c, $18, $30, $60, $c0, $60, $30, $18, $0c, $06),
    ($00, $00, $00, $00, $ff, $ff, $00, $ff, $ff, $00, $00, $00, $00),
    ($00, $00, $60, $30, $18, $0c, $06, $03, $06, $0c, $18, $30, $60),
    ($00, $00, $18, $00, $00, $18, $18, $0c, $06, $03, $c3, $c3, $7e),
    ($00, $00, $3f, $60, $cf, $db, $d3, $dd, $c3, $7e, $00, $00, $00),
    ($00, $00, $c3, $c3, $c3, $c3, $ff, $c3, $c3, $c3, $66, $3c, $18),
    ($00, $00, $fe, $c7, $c3, $c3, $c7, $fe, $c7, $c3, $c3, $c7, $fe),
    ($00, $00, $7e, $e7, $c0, $c0, $c0, $c0, $c0, $c0, $c0, $e7, $7e),
    ($00, $00, $fc, $ce, $c7, $c3, $c3, $c3, $c3, $c3, $c7, $ce, $fc),
    ($00, $00, $ff, $c0, $c0, $c0, $c0, $fc, $c0, $c0, $c0, $c0, $ff),
    ($00, $00, $c0, $c0, $c0, $c0, $c0, $c0, $fc, $c0, $c0, $c0, $ff),
    ($00, $00, $7e, $e7, $c3, $c3, $cf, $c0, $c0, $c0, $c0, $e7, $7e),
    ($00, $00, $c3, $c3, $c3, $c3, $c3, $ff, $c3, $c3, $c3, $c3, $c3),
    ($00, $00, $7e, $18, $18, $18, $18, $18, $18, $18, $18, $18, $7e),
    ($00, $00, $7c, $ee, $c6, $06, $06, $06, $06, $06, $06, $06, $06),
    ($00, $00, $c3, $c6, $cc, $d8, $f0, $e0, $f0, $d8, $cc, $c6, $c3),
    ($00, $00, $ff, $c0, $c0, $c0, $c0, $c0, $c0, $c0, $c0, $c0, $c0),
    ($00, $00, $c3, $c3, $c3, $c3, $c3, $c3, $db, $ff, $ff, $e7, $c3),
    ($00, $00, $c7, $c7, $cf, $cf, $df, $db, $fb, $f3, $f3, $e3, $e3),
    ($00, $00, $7e, $e7, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $e7, $7e),
    ($00, $00, $c0, $c0, $c0, $c0, $c0, $fe, $c7, $c3, $c3, $c7, $fe),
    ($00, $00, $3f, $6e, $df, $db, $c3, $c3, $c3, $c3, $c3, $66, $3c),
    ($00, $00, $c3, $c6, $cc, $d8, $f0, $fe, $c7, $c3, $c3, $c7, $fe),
    ($00, $00, $7e, $e7, $03, $03, $07, $7e, $e0, $c0, $c0, $e7, $7e),
    ($00, $00, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $ff),
    ($00, $00, $7e, $e7, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3),
    ($00, $00, $18, $3c, $3c, $66, $66, $c3, $c3, $c3, $c3, $c3, $c3),
    ($00, $00, $c3, $e7, $ff, $ff, $db, $db, $c3, $c3, $c3, $c3, $c3),
    ($00, $00, $c3, $66, $66, $3c, $3c, $18, $3c, $3c, $66, $66, $c3),
    ($00, $00, $18, $18, $18, $18, $18, $18, $3c, $3c, $66, $66, $c3),
    ($00, $00, $ff, $c0, $c0, $60, $30, $7e, $0c, $06, $03, $03, $ff),
    ($00, $00, $3c, $30, $30, $30, $30, $30, $30, $30, $30, $30, $3c),
    ($00, $03, $03, $06, $06, $0c, $0c, $18, $18, $30, $30, $60, $60),
    ($00, $00, $3c, $0c, $0c, $0c, $0c, $0c, $0c, $0c, $0c, $0c, $3c),
    ($00, $00, $00, $00, $00, $00, $00, $00, $00, $c3, $66, $3c, $18),
    ($ff, $ff, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00),
    ($00, $00, $00, $00, $00, $00, $00, $00, $00, $18, $38, $30, $70),
    ($00, $00, $7f, $c3, $c3, $7f, $03, $c3, $7e, $00, $00, $00, $00),
    ($00, $00, $fe, $c3, $c3, $c3, $c3, $fe, $c0, $c0, $c0, $c0, $c0),
    ($00, $00, $7e, $c3, $c0, $c0, $c0, $c3, $7e, $00, $00, $00, $00),
    ($00, $00, $7f, $c3, $c3, $c3, $c3, $7f, $03, $03, $03, $03, $03),
    ($00, $00, $7f, $c0, $c0, $fe, $c3, $c3, $7e, $00, $00, $00, $00),
    ($00, $00, $30, $30, $30, $30, $30, $fc, $30, $30, $30, $33, $1e),
    ($7e, $c3, $03, $03, $7f, $c3, $c3, $c3, $7e, $00, $00, $00, $00),
    ($00, $00, $c3, $c3, $c3, $c3, $c3, $c3, $fe, $c0, $c0, $c0, $c0),
    ($00, $00, $18, $18, $18, $18, $18, $18, $18, $00, $00, $18, $00),
    ($38, $6c, $0c, $0c, $0c, $0c, $0c, $0c, $0c, $00, $00, $0c, $00),
    ($00, $00, $c6, $cc, $f8, $f0, $d8, $cc, $c6, $c0, $c0, $c0, $c0),
    ($00, $00, $7e, $18, $18, $18, $18, $18, $18, $18, $18, $18, $78),
    ($00, $00, $db, $db, $db, $db, $db, $db, $fe, $00, $00, $00, $00),
    ($00, $00, $c6, $c6, $c6, $c6, $c6, $c6, $fc, $00, $00, $00, $00),
    ($00, $00, $7c, $c6, $c6, $c6, $c6, $c6, $7c, $00, $00, $00, $00),
    ($c0, $c0, $c0, $fe, $c3, $c3, $c3, $c3, $fe, $00, $00, $00, $00),
    ($03, $03, $03, $7f, $c3, $c3, $c3, $c3, $7f, $00, $00, $00, $00),
    ($00, $00, $c0, $c0, $c0, $c0, $c0, $e0, $fe, $00, $00, $00, $00),
    ($00, $00, $fe, $03, $03, $7e, $c0, $c0, $7f, $00, $00, $00, $00),
    ($00, $00, $1c, $36, $30, $30, $30, $30, $fc, $30, $30, $30, $00),
    ($00, $00, $7e, $c6, $c6, $c6, $c6, $c6, $c6, $00, $00, $00, $00),
    ($00, $00, $18, $3c, $3c, $66, $66, $c3, $c3, $00, $00, $00, $00),
    ($00, $00, $c3, $e7, $ff, $db, $c3, $c3, $c3, $00, $00, $00, $00),
    ($00, $00, $c3, $66, $3c, $18, $3c, $66, $c3, $00, $00, $00, $00),
    ($c0, $60, $60, $30, $18, $3c, $66, $66, $c3, $00, $00, $00, $00),
    ($00, $00, $ff, $60, $30, $18, $0c, $06, $ff, $00, $00, $00, $00),
    ($00, $00, $0f, $18, $18, $18, $38, $f0, $38, $18, $18, $18, $0f),
    ($18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18),
    ($00, $00, $f0, $18, $18, $18, $1c, $0f, $1c, $18, $18, $18, $f0),
    ($00, $00, $00, $00, $00, $00, $06, $8f, $f1, $60, $00, $00, $00)
);

var

  // Font
  fontOffset : GLuint;                // Offset for the Display list
  white : array[0..2] of GLfloat = ( 1.0, 1.0, 1.0 );

//  ang : GLfloat = 1;

procedure MakeRasterFont;
procedure PrintString(s : string);
procedure glutSolidCube(Size :GLDouble);

procedure ShowLoad;
procedure ShowMovie;

procedure SceneStreet;
procedure SceneStreetCar;
procedure SceneStreetMan;
procedure SceneStage;
//procedure SceneBartable;
procedure SceneSmoketube;
procedure ScenePokerGame;
procedure ShowPokerTable;
procedure ShowPokerLight;

implementation

{------------------------------------------------------------------}
{  Create the display lists for our raster font                    }
{------------------------------------------------------------------}
procedure MakeRasterFont;
var i : GLuint;
begin
    glPixelStorei(GL_UNPACK_ALIGNMENT, 1);      // set the bit alignment
    fontOffset := glGenLists (128);             // generate 128 display lists
    for i := 32 to 126 do
    begin
        glNewList(i+fontOffset, GL_COMPILE);    // Create but dont execute a list
            glBitmap(8, 13, 0.0, 2.0, 10.0, 0.0, @rasters[i-32]); // Add a character to the current Display list 
        glEndList();                            // End the display list creation
    end;
end;


{------------------------------------------------------------------}
{  Draw a string of characters to the scene                        }
{------------------------------------------------------------------}
procedure PrintString(s : string);
begin
  glPushAttrib (GL_LIST_BIT);
    glListBase(fontOffset);
    glCallLists(length(s), GL_UNSIGNED_BYTE,  PChar(s));
  glPopAttrib();
end;


{------------------------------------------------------------------}
{  Draw a box to the scene                                         }
{------------------------------------------------------------------}
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
    glNormal3fv(@BoxPoints[I, 0]);
    glVertex3fv(@V[BoxFaces[I, 0], 0]);
    glVertex3fv(@V[BoxFaces[I, 1], 0]);
    glVertex3fv(@V[BoxFaces[I, 2], 0]);
    glVertex3fv(@V[BoxFaces[I, 3], 0]);
   end;
  glEnd;

end;


procedure ShowLoad;
begin
  glTranslatef(0,-15,-200);
  glColor3f(1, 1, 1);
   // background
  glBindTexture(GL_TEXTURE_2D, array_text[0]);
  glBegin(GL_POLYGON);
  glTexCoord2f(0.0, 0.0); glVertex3f(-320.0, -320.0,  0.0);
  glTexCoord2f(1.0, 0.0); glVertex3f( 320.0, -320.0,  0.0);
  glTexCoord2f(1.0, 1.0); glVertex3f( 320.0,  320.0,  0.0);
  glTexCoord2f(0.0, 1.0); glVertex3f(-320.0,  320.0,  0.0);
  glEnd;
          
  if Progress > 0 then begin
   glTranslatef(-201.3, 143, 0.05);
   glBindTexture(GL_TEXTURE_2D, array_text[1]);
   glBegin(GL_POLYGON);
    glTexCoord2f(0.0, 0.0); glVertex3f( 0.0, 0.0,  0.0);
    glTexCoord2f(1.0, 0.0); glVertex3f( 76.0, 0.0, 0.0);
    glTexCoord2f(1.0, 1.0); glVertex3f( 76.0, 85.0, 0.0);
    glTexCoord2f(0.0, 1.0); glVertex3f( 0.0, 85.0, 0.0);
   glEnd;
   if Progress > 1 then begin
     glTranslatef(56.1, 0, 0.05);
     glBindTexture(GL_TEXTURE_2D, array_text[2]);
     glBegin(GL_POLYGON);
      glTexCoord2f(0.0, 0.0); glVertex3f( 0.0, 0.0,  0.0);
      glTexCoord2f(1.0, 0.0); glVertex3f( 76.0, 0.0, 0.0);
      glTexCoord2f(1.0, 1.0); glVertex3f( 76.0, 85.0, 0.0);
      glTexCoord2f(0.0, 1.0); glVertex3f( 0.0, 85.0, 0.0);
     glEnd;
     if Progress > 2 then begin
        glTranslatef(51.20, 0, 0.05);
        glBindTexture(GL_TEXTURE_2D, array_text[3]);
        glBegin(GL_POLYGON);
         glTexCoord2f(0.0, 0.0); glVertex3f( 0.0, 0.0,  0.0);
         glTexCoord2f(1.0, 0.0); glVertex3f( 76.0, 0.0, 0.0);
         glTexCoord2f(1.0, 1.0); glVertex3f( 76.0, 85.0, 0.0);
         glTexCoord2f(0.0, 1.0); glVertex3f( 0.0, 85.0, 0.0);
        glEnd;
        if Progress > 3 then begin
           glTranslatef(58.0, 0, 0.05);
           glBindTexture(GL_TEXTURE_2D, array_text[4]);
           glBegin(GL_POLYGON);
            glTexCoord2f(0.0, 0.0); glVertex3f( 0.0, 0.0,  0.0);
            glTexCoord2f(1.0, 0.0); glVertex3f( 76.0, 0.0, 0.0);
            glTexCoord2f(1.0, 1.0); glVertex3f( 76.0, 85.0, 0.0);
            glTexCoord2f(0.0, 1.0); glVertex3f( 0.0, 85.0, 0.0);
           glEnd;
           if Progress > 4 then begin
              glTranslatef(55.0, 0, 0.05);
              glBindTexture(GL_TEXTURE_2D, array_text[5]);
              glBegin(GL_POLYGON);
               glTexCoord2f(0.0, 0.0); glVertex3f( 0.0, 0.0,  0.0);
               glTexCoord2f(1.0, 0.0); glVertex3f( 76.0, 0.0, 0.0);
               glTexCoord2f(1.0, 1.0); glVertex3f( 76.0, 85.0, 0.0);
               glTexCoord2f(0.0, 1.0); glVertex3f( 0.0, 85.0, 0.0);
              glEnd;
              if Progress > 5 then begin
                 glTranslatef(45.9, 0, 0.05);
                 glBindTexture(GL_TEXTURE_2D, array_text[6]);
                 glBegin(GL_POLYGON);
                  glTexCoord2f(0.0, 0.0); glVertex3f( 0.0, 0.0,  0.0);
                  glTexCoord2f(1.0, 0.0); glVertex3f( 76.0, 0.0, 0.0);
                  glTexCoord2f(1.0, 1.0); glVertex3f( 76.0, 85.0, 0.0);
                  glTexCoord2f(0.0, 1.0); glVertex3f( 0.0, 85.0, 0.0);
                 glEnd;
                 if Progress > 6 then begin
                   glTranslatef(55.7, 0, 0.05);
                   glBindTexture(GL_TEXTURE_2D, array_text[7]);
                   glBegin(GL_POLYGON);
                    glTexCoord2f(0.0, 0.0); glVertex3f( 0.0, 0.0,  0.0);
                    glTexCoord2f(1.0, 0.0); glVertex3f( 76.0, 0.0, 0.0);
                    glTexCoord2f(1.0, 1.0); glVertex3f( 76.0, 85.0, 0.0);
                    glTexCoord2f(0.0, 1.0); glVertex3f( 0.0, 85.0, 0.0);
                   glEnd;
                   if Progress > 8
                     then Inc(Stage);
                 end;
              end;
           end;
        end;
     end;
   end;
  end;
end;


procedure ShowMovie;
begin
//  if ElapsedTime < 9900 then Delta := -20 + ElapsedTime*0.0014
  //movie
  glLoadIdentity();
  glColor3f(1, 1, 1);
  glDepthMask(GL_FALSE);
  glBindTexture(GL_TEXTURE_2D, array_text[12]);
  glBegin(GL_POLYGON);
  glTexCoord2f(0.0, 0.0); glVertex3f(-130.0, -101.0, -56);
  glTexCoord2f(1.0, 0.0); glVertex3f( 126.0, -101.0, -56);
  glTexCoord2f(1.0, 1.0); glVertex3f( 126.0,  91.0,  -56);
  glTexCoord2f(0.0, 1.0); glVertex3f(-130.0,  91.0,  -56);
  glEnd;
  glDepthMask(GL_TRUE);
end;


procedure SceneStreet;
begin
  glColor3f(1, 1, 1);
 //street
  glBindTexture(GL_TEXTURE_2D, array_text[9]);
  glBegin(GL_POLYGON);
  glTexCoord2f(0.0, 0.0); glVertex3f(-128.0, -101.0,  -60);
  glTexCoord2f(1.0, 0.0); glVertex3f( 128.0, -101.0,  -60);
  glTexCoord2f(1.0, 1.0); glVertex3f( 128.0,  91.0,  -60);
  glTexCoord2f(0.0, 1.0); glVertex3f(-128.0,  91.0,  -60);
  glEnd;

  ParticalsRain.draw_par1;

  ShowMovie;

  if ElapsedTime < 13000
     then glColor4f(0, 0, 0, 1 + (3000 - ElapsedTime)*0.0002)
        else
           if ElapsedTime < 17000
              then glColor4f(0, 0, 0, (ElapsedTime - 13000)*0.0005)
                          else Inc(Stage);
  glBegin(GL_POLYGON);
  glTexCoord2f(0.0, 0.0);glVertex3f(-130.0, -101.0, -54);
  glTexCoord2f(0.1, 0.0);glVertex3f( 126.0, -101.0, -54);
  glTexCoord2f(0.1, 0.1);glVertex3f( 126.0,  91.0,  -54);
  glTexCoord2f(0.0, 0.1);glVertex3f(-130.0,  91.0,  -54);
  glEnd;
end;

procedure SceneStreetCar;
begin
  if ElapsedTime < 25500
     then glTranslatef(31 - (ElapsedTime-17000)*0.004, 86 - (ElapsedTime-17000)*(ElapsedTime-17000)*0.000005,0)
        else Inc(Stage);
  glColor3f(1, 1, 1);
 //street_car
  glBindTexture(GL_TEXTURE_2D, array_text[10]);
  glBegin(GL_POLYGON);
  glTexCoord2f(0.0, 0.0); glVertex3f(-381.0, -340.0, -152);
  glTexCoord2f(1.0, 0.0); glVertex3f( 381.0, -340.0, -152);
  glTexCoord2f(1.0, 1.0); glVertex3f( 381.0,  340.0, -152);
  glTexCoord2f(0.0, 1.0); glVertex3f(-381.0,  340.0, -152);
  glEnd;

  ParticalsRain.draw_par2;

  ShowMovie;

  glColor4f(0, 0, 0, 1 + (17000 - ElapsedTime)*0.0005);
  glBegin(GL_POLYGON);
  glTexCoord2f(0.0, 0.0);glVertex3f(-130.0, -101.0, -54);
  glTexCoord2f(0.1, 0.0);glVertex3f( 126.0, -101.0, -54);
  glTexCoord2f(0.1, 0.1);glVertex3f( 126.0,  91.0,  -54);
  glTexCoord2f(0.0, 0.1);glVertex3f(-130.0,  91.0,  -54);
  glEnd;
end;

procedure SceneStreetMan;
begin
  glColor3f(1, 1, 1);
 //street_man
  glBindTexture(GL_TEXTURE_2D, array_text[11]);
  glBegin(GL_POLYGON);
  glTexCoord2f(0.0, 0.0); glVertex3f(-472.0, -316.0,  -210);
  glTexCoord2f(1.0, 0.0); glVertex3f( 472.0, -316.0,  -210);
  glTexCoord2f(1.0, 1.0); glVertex3f( 472.0,  316.0,  -210);
  glTexCoord2f(0.0, 1.0); glVertex3f(-472.0,  316.0,  -210);
  glEnd;
  glTranslatef(-50, 0, 0);
  ParticalsRain.draw_par1;

  ShowMovie;
  if ElapsedTime < 39000
     then glColor4f(0, 0, 0, (ElapsedTime - 35000)*0.0005)
                 else Inc(Stage);
  glBegin(GL_POLYGON);
  glTexCoord2f(0.0, 0.0);glVertex3f(-130.0, -101.0, -54);
  glTexCoord2f(0.1, 0.0);glVertex3f( 126.0, -101.0, -54);
  glTexCoord2f(0.1, 0.1);glVertex3f( 126.0,  91.0,  -54);
  glTexCoord2f(0.0, 0.1);glVertex3f(-130.0,  91.0,  -54);
  glEnd;
end;

procedure SceneStage;
begin
   //glLoadIdentity();
 //stage
  glColor3f(1, 1, 1);
  glBindTexture(GL_TEXTURE_2D, array_text[14]);
  glBegin(GL_POLYGON);
  glTexCoord2f(0.0, 0.0); glVertex3f(-350.0, -232.0,  -160);
  glTexCoord2f(1.0, 0.0); glVertex3f( 350.0, -232.0,  -160);
  glTexCoord2f(1.0, 1.0); glVertex3f( 350.0,  232.0,  -160);
  glTexCoord2f(0.0, 1.0); glVertex3f(-350.0,  232.0,  -160);
  glEnd;

  glTranslatef(0,-20,0);
  //glTranslatef(0, (ElapsedTime - 35000)*0.01,0);

  ParticalsFog.draw_par3;
               {     // cubes
  glTranslatef(8,12,-15);
  glRotatef((ElapsedTime - 35000)*0.01,1,1,0);
  glDisable(GL_TEXTURE_2D);
  glutSolidCube(5);
  glLoadIdentity();
  glTranslatef(+13, +6, -7);
  glRotatef((ElapsedTime - 36000)*0.02,-1,1,0);
  glutSolidCube(5);
  glEnable(GL_TEXTURE_2D);   }


  glColor3f(1, 1, 1);
  glTranslatef((ElapsedTime - 44000)*0.0051, 0,0);
  //logan culture
//  glColor3f(0.07, 0.85, 0.0);
  glBindTexture(GL_TEXTURE_2D, array_text[18]);
  glBegin(GL_POLYGON);
  glTexCoord2f(0.0, 0.0); glVertex3f(-127.0, 84.0,  -385);
  glTexCoord2f(1.0, 0.0); glVertex3f( 673.0, 84.0,  -385);
  glTexCoord2f(1.0, 1.0); glVertex3f( 673.0,  305.0,  -385);
  glTexCoord2f(0.0, 1.0); glVertex3f(-127.0,  305.0,  -385);
  glEnd;

  glLoadIdentity();
 //stage_visible
  glColor3f(1, 1, 1);
  glBindTexture(GL_TEXTURE_2D, array_text[15]);
  glBegin(GL_POLYGON);
  glTexCoord2f(0.0, 0.0); glVertex3f(-350.0, -232.0,  -159);
  glTexCoord2f(1.0, 0.0); glVertex3f( 350.0, -232.0,  -159);
  glTexCoord2f(1.0, 1.0); glVertex3f( 350.0,  232.0,  -159);
  glTexCoord2f(0.0, 1.0); glVertex3f(-350.0,  232.0,  -159);
  glEnd;


  glTranslatef(-1*(ElapsedTime - 44000)*0.0051, -2,0);
  //logan el pado
//  glColor3f( 0.85, 0.95, 0);
  glBindTexture(GL_TEXTURE_2D, array_text[19]);
  glBegin(GL_POLYGON);
  glTexCoord2f(0.0, 0.0); glVertex3f( 150.0, -151.0,  -480);
  glTexCoord2f(1.0, 0.0); glVertex3f( 750.0, -151.0,  -480);
  glTexCoord2f(1.0, 1.0); glVertex3f( 750.0,  151.0,  -480);
  glTexCoord2f(0.0, 1.0); glVertex3f( 150.0,  151.0,  -480);
  glEnd;


  ShowMovie;

  if ElapsedTime > 50000 then Inc(Stage);
end;
                     {
procedure SceneBartable;
begin
  //bar table
  glColor3f(1, 1, 1);
  glBindTexture(GL_TEXTURE_2D, array_text[17]);
  glBegin(GL_POLYGON);
  glTexCoord2f(0.0, 0.0); glVertex3f(-435.0, -257.0,  -180);
  glTexCoord2f(1.0, 0.0); glVertex3f( 365.0, -257.0,  -180);
  glTexCoord2f(1.0, 1.0); glVertex3f( 365.0,  258.0,  -180);
  glTexCoord2f(0.0, 1.0); glVertex3f(-435.0,  258.0,  -180);
  glEnd;

  glTranslatef((ElapsedTime - 44000)*0.0051, 0,0);
  //logan culture
  glColor3f(0.07, 0.85, 0.0);
  glBindTexture(GL_TEXTURE_2D, array_text[18]);
  glBegin(GL_POLYGON);
  glTexCoord2f(0.0, 0.0); glVertex3f(-127.0, 84.0,  -385);
  glTexCoord2f(1.0, 0.0); glVertex3f( 673.0, 84.0,  -385);
  glTexCoord2f(1.0, 1.0); glVertex3f( 673.0,  305.0,  -385);
  glTexCoord2f(0.0, 1.0); glVertex3f(-127.0,  305.0,  -385);
  glEnd;

  glTranslatef(-2*(ElapsedTime - 44000)*0.0051, 0,0);
  //logan el pado
  glColor3f( 0.85, 0.95, 0);
  glBindTexture(GL_TEXTURE_2D, array_text[19]);
  glBegin(GL_POLYGON);
  glTexCoord2f(0.0, 0.0); glVertex3f( 150.0, -151.0,  -480);
  glTexCoord2f(1.0, 0.0); glVertex3f( 750.0, -151.0,  -480);
  glTexCoord2f(1.0, 1.0); glVertex3f( 750.0,  151.0,  -480);
  glTexCoord2f(0.0, 1.0); glVertex3f( 150.0,  151.0,  -480);
  glEnd;

  ShowMovie;
  if ElapsedTime > 55000 then Inc(Stage);
end;                 }


procedure SceneSmoketube;
begin
  //smoke tube
  glColor3f(1, 1, 1);
  glBindTexture(GL_TEXTURE_2D, array_text[20]);
  glBegin(GL_POLYGON);
  glTexCoord2f(0.0, 0.0); glVertex3f(-388.0-110, -301.0+66,  -205);
  glTexCoord2f(1.0, 0.0); glVertex3f( 120.0-110, -301.0+66,  -205);
  glTexCoord2f(1.0, 1.0); glVertex3f( 120.0-110,   10.0+66,  -205);
  glTexCoord2f(0.0, 1.0); glVertex3f(-388.0-110,   10.0+66,  -205);
  glEnd;
  glTranslatef(-447, 4, 71);
  ParticalsSmoke.draw_par4;
end;

procedure ShowPokerTable;
begin
  //poker table
  glColor3f(1, 1, 1);
  glBindTexture(GL_TEXTURE_2D, array_text[25]);
  glBegin(GL_POLYGON);
  glTexCoord2f(0.0, 0.0); glVertex3f(-322.0, -72.0-295-41,  -284);
  glTexCoord2f(1.0, 0.0); glVertex3f( 406.0, -72.0-295-41,  -284);
  glTexCoord2f(1.0, 1.0); glVertex3f( 406.0,  71.0-295-41,  -284);
  glTexCoord2f(0.0, 1.0); glVertex3f(-322.0,  71.0-295-41,  -284);
  glEnd;
end;

procedure ShowPokerLight;
begin
  //poker light
  glColor3f(1, 1, 1);
  glBindTexture(GL_TEXTURE_2D, array_text[24]);
  glBegin(GL_POLYGON);
  glTexCoord2f(0.0, 0.0); glVertex3f(-394.0+38, -364.0+37,  -241-77);
  glTexCoord2f(1.0, 0.0); glVertex3f( 394.0+38, -364.0+37,  -241-77);
  glTexCoord2f(1.0, 1.0); glVertex3f( 394.0+38,  364.0+37,  -241-77);
  glTexCoord2f(0.0, 1.0); glVertex3f(-394.0+38,  364.0+37,  -241-77);
  glEnd;
end;

procedure ScenePokerGame;
begin
  //poker wall
  glColor3f(1, 1, 1);
  glBindTexture(GL_TEXTURE_2D, array_text[22]);
  glBegin(GL_POLYGON);
  glTexCoord2f(0.0, 0.0); glVertex3f(-588.0, -305.0,  -241);
  glTexCoord2f(1.0, 0.0); glVertex3f( 588.0, -305.0,  -241);
  glTexCoord2f(1.0, 1.0); glVertex3f( 588.0,  306.0,  -241);
  glTexCoord2f(0.0, 1.0); glVertex3f(-588.0,  306.0,  -241);
  glEnd;

  //poker hands
  glColor3f(1, 1, 1);
  glBindTexture(GL_TEXTURE_2D, array_text[23]);
  glBegin(GL_POLYGON);
  glTexCoord2f(0.0, 0.0); glVertex3f(-688.0, -454.0, -285);
  glTexCoord2f(1.0, 0.0); glVertex3f( 688.0, -454.0, -285);
  glTexCoord2f(1.0, 1.0); glVertex3f( 688.0,  84.0,  -285);
  glTexCoord2f(0.0, 1.0); glVertex3f(-688.0,  84.0,  -285);
  glEnd;

  ShowPokerLight;

  if ElapsedTime > 60000 then Inc(Stage);
end;


end.

//glTranslatef(xx_x, xx_y,xx_z);
//glColor3f(xx_x, xx_y,xx_z);

        (*
var
  i: GLint;

begin

    glTranslatef(70,-100,-750+ElapsedTime*0.01);
//    glTranslatef(-10,-15,-25);

    glLineWidth(1);
  glbegin(GL_LINES);
   glColor3f(1,0,0);
    glVertex3f(0,0,0);
    glVertex3f(100,0,0);
   glColor3f(0,1,0);
    glVertex3f(0,0,0);
    glVertex3f(0,30,0);
   glColor3f(0,0,1);
    glVertex3f(0,0,0);
    glVertex3f(0,0,100);
  glEnd;

  glEnable(GL_LIGHTING);
  glEnable(GL_LIGHT0);
  
//    glRotatef(ElapsedTime*0.05,0,0,1);

  i:=0;

  while i<1440+1440 do begin

    glColor3f( 0.5, 0.7+sin(ElapsedTime*pic*i/360), 0.2 );
//    glTranslatef( 5*cos(i*pic), 5*sin(i*pic), -0.001*i);
    glTranslatef( -0.0005*i+5*cos(i*pic), 5*sin(i*pic), -0.001*i);

    glPushMatrix;
    glScalef(5,5, 25);
      glutSolidCube(1);
    glPopMatrix;
                       {
    glColor3f( 0.7+sin(ElapsedTime*pic*i/320), 0, 0 );
    glPushMatrix;
    glTranslatef( 0,0,-20);
    glScalef(5,5, 25);
      glutSolidCube(1);
    glPopMatrix;

    glColor3f( 1, 1, 0.7+sin(ElapsedTime*pic*i/180) );
    glPushMatrix;
    glTranslatef( 0,0,-40);
    glScalef(5,5, 35);
      glutSolidCube(1);
    glPopMatrix;
                      }
    i := i + 5;
    
  end;
              *)



    glAccum(GL_MULT, q);
    glAccum(GL_ACCUM, 1-q);
    glAccum(GL_RETURN, 1);


  glColor3fv(@white);

  glDisable(GL_LIGHTING);
  glDisable(GL_LIGHT0);
  glRasterPos2i(-4, 0);
  printString('Loading intro');
  glEnable(GL_LIGHTING);
  glEnable(GL_LIGHT0);










//    glTranslatef(xx_x, xx_y,xx_z);
