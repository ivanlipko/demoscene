unit particle;

interface

uses opengl,genom;

const
  Particles_MAX = 2500;

Type
  TParticlesGL = class

    posis:TGLNrf3;
    Narvl:TGLNrf3;      Narvl_ang:TGLNrf2;
    color:TGLNrf4;

    colpr:word;
    cordz:array of tglnrf3;
     naprs:array of tglnrf3;
    colrs:array of TGLNrf4;
     coldz:TGLNrf4;
    rand : byte;
    lifeS : GLfloat;
    lifeD : GLfloat;
    lifers :array of GLfloat;
     lifedz :array of GLfloat;

    cordz_cpf: tglnrf3; 


    procedure add_particle;
    procedure del_particle(index:word);
    procedure reset_pr;
    procedure draw_par(cam:TGLNrf3);
    procedure draw_par1;
    procedure draw_par2;
    procedure draw_par3;
    procedure draw_par4;
  end;


  procedure DrawSprite(pos:TGLNrf3;cam_nap:TGLNrf3;size:glfloat);

implementation

uses
  initscenes;
var
// really this is   //glGetFloatv(GL_MODELVIEW_MATRIX, @modelview);
 modelview: array[0..15] of glfloat = (1,0,0,0,
                                       0,1,0,0,
                                       0,0,1,0,
                                       0,0,0,1
                                       );


procedure TParticlesGL.del_particle(index:word);
var
 temp : GLfloat;
begin
   colpr:=colpr-1;

   Swap_TGLNrf3(cordz[index],cordz[colpr]);
   Swap_TGLNrf3(naprs[index],naprs[colpr]);
   Swap_TGLNrf4(colrs[index],colrs[colpr]);

   temp := lifers[index];
   lifers[index] := lifers[colpr];
   lifers[colpr] := temp;
   temp := lifedz[index];
   lifedz[index] := lifedz[colpr];
   lifedz[colpr] := temp;

   setlength(cordz,colpr);
   setlength(naprs,colpr);
   setlength(colrs,colpr);

  setlength(lifers,colpr);
  setlength(lifedz,colpr);   
end;

procedure TParticlesGL.add_particle;
begin
  colpr:=colpr+1;

  setlength(cordz,colpr);
  setlength(naprs,colpr);
  setlength(colrs,colpr);

  setlength(lifers,colpr);
  setlength(lifedz,colpr);

  //cordz[colpr-1]:=posis;
  naprs[colpr-1]:=narvl;
  cordz[colpr-1][0]:=posis[0] + (random(rand)-rand*0.5)*cordz_cpf[0];
  cordz[colpr-1][1]:=posis[1] + (random(rand)-rand*0.5)*cordz_cpf[1];
  cordz[colpr-1][2]:=posis[2] + (random(rand)-rand*0.5)*cordz_cpf[2];

//    randomize;
//    rotate_point( random(rand)-rand*0.5, naprs[colpr-1][1], naprs[colpr-1][2]);
//    rotate_point( random(rand)-rand*0.5, naprs[colpr-1][0], naprs[colpr-1][2]);
//    rotate_point( random(rand)-rand*0.5, naprs[colpr-1][0], naprs[colpr-1][1]);

  colrs[colpr-1]:=color;
  colrs[colpr-1][3]:=color[3] + random(rand)* 0.005;

  lifedz[colpr-1] := lifeD - random(rand)* 0.01;
  lifers[colpr-1] := lifeS + random(rand)* 0.05;
end;

procedure TParticlesGL.reset_pr;
var i:integer;
begin
 for i:=0 to colpr-1 do
  if colpr>i then begin
   cordz[i][0] := cordz[i][0]+naprs[i][0];
   cordz[i][1] := cordz[i][1]+naprs[i][1];
   cordz[i][2] := cordz[i][2]+naprs[i][2];

   colrs[i][0] := colrs[i][0]-0.0   + coldz[0];
   colrs[i][1] := colrs[i][1]-0.015 + coldz[1];
   colrs[i][2] := colrs[i][2]-0.015 + coldz[2];
   colrs[i][3] := colrs[i][3]-0.01 + cordz[i][2] * 0.001 + coldz[3];

   lifers[i] := lifers[i] + lifedz[i];

   if cordz[i][1] < -4 then begin
      naprs[i][0] := 0;
      naprs[i][1] := 0;
      naprs[i][2] := 0;
   end;

   if lifers[i] < 0 then
   begin
    del_particle(i); //goto m1;
    if colpr < Particles_MAX then add_particle;
   end;

 end;
end;

procedure TParticlesGL.draw_par(cam:TGLNrf3);
var i:integer;
begin
  for i:=0 to colpr-1 do
  begin
   glcolor4fv(@colrs[i]);
   DrawSprite(cordz[i],cam,30);
  end;
end;

procedure TParticlesGL.draw_par1;
var
  i:integer;
  Size : glfloat;
begin

  for i:=0 to colpr-1 do
  begin
     glcolor4fv(@colrs[i]);
     size := colrs[i][3]*2;
    if cordz[i][1] > -5
      then begin
         glBindTexture(GL_TEXTURE_2D, array_text[8]);
         glBegin(GL_LINES);                     //GL_TRIANGLE_STRIP     GL_QUADS
          glTexCoord2f(1.0, 1.0);
          glVertex3f((cordz[i][0] + (( modelview[0] - modelview[1]))),
                     (cordz[i][1] + (( modelview[4] - modelview[5]))),
                     (cordz[i][2] + (( modelview[8] - modelview[9]))));
          glTexCoord2f(0.0, 0.0);
          glVertex3f((cordz[i][0] + (( modelview[0] + modelview[1]))),
                     (cordz[i][1] + (( modelview[4] + modelview[5]))),
                     (cordz[i][2] + (( modelview[8] + modelview[9]))));
         glEnd;
      end else begin
         glBindTexture(GL_TEXTURE_2D, array_text[13]);
         glBegin(GL_TRIANGLE_STRIP);
          glTexCoord2f(0.0, 1.0);
          glVertex3f((cordz[i][0] + (( -modelview[0] - modelview[1]) * Size)),
                     (cordz[i][1] + (( -modelview[4] - modelview[5]) * Size)),
                     (cordz[i][2] + (( -modelview[8] - modelview[9]) * Size)));
          glTexCoord2f(1.0, 1.0);
          glVertex3f((cordz[i][0] + (( modelview[0] - modelview[1]) * Size)),
                     (cordz[i][1] + (( modelview[4] - modelview[5]) * Size)),
                     (cordz[i][2] + (( modelview[8] - modelview[9]) * Size)));
          glTexCoord2f(0.0, 0.0);
          glVertex3f((cordz[i][0] + (( -modelview[0] + modelview[1]) * Size)),
                     (cordz[i][1] + (( -modelview[4] + modelview[5]) * Size)),
                     (cordz[i][2] + (( -modelview[8] + modelview[9]) * Size)));
          glTexCoord2f(1.0, 0.0);
          glVertex3f((cordz[i][0] + (( modelview[0] + modelview[1]) * Size)),
                     (cordz[i][1] + (( modelview[4] + modelview[5]) * Size)),
                     (cordz[i][2] + (( modelview[8] + modelview[9]) * Size)));
         glEnd;
      end;

  end;
end;

procedure TParticlesGL.draw_par2;
var
  i:integer;
  Size : glfloat;
begin
  glBindTexture(GL_TEXTURE_2D, array_text[8]);
  for i:=0 to colpr-1 do
  begin
     glcolor4fv(@colrs[i]);
     size := colrs[i][3]*2;
      glBegin(GL_LINES);                     //GL_TRIANGLE_STRIP     GL_QUADS
       glTexCoord2f(1.0, 1.0);
       glVertex3f((cordz[i][0] + (( modelview[0] - modelview[1]))),
                  (cordz[i][1] + (( modelview[4] - modelview[5]))),
                  (cordz[i][2] + (( modelview[8] - modelview[9]))));
       glTexCoord2f(0.0, 0.0);
       glVertex3f((cordz[i][0] + (( modelview[0] + modelview[1]))),
                  (cordz[i][1] + (( modelview[4] + modelview[5]))),
                  (cordz[i][2] + (( modelview[8] + modelview[9]))));
      glEnd;
  end;
end;


procedure TParticlesGL.draw_par3;
var
  i:integer;
  Size : glfloat;
begin
  glBindTexture(GL_TEXTURE_2D, array_text[16]);
  for i:=0 to colpr-1 do
  begin
     glcolor4fv(@colrs[i]);
     size := colrs[i][3]*20;
         glBegin(GL_TRIANGLE_STRIP);
          glTexCoord2f(0.0, 1.0);
          glVertex3f((cordz[i][0] + (( -modelview[0] - modelview[1]) * Size)),
                     (cordz[i][1] + (( -modelview[4] - modelview[5]) * Size)),
                     (cordz[i][2] + (( -modelview[8] - modelview[9]) * Size)));
          glTexCoord2f(1.0, 1.0);
          glVertex3f((cordz[i][0] + (( modelview[0] - modelview[1]) * Size)),
                     (cordz[i][1] + (( modelview[4] - modelview[5]) * Size)),
                     (cordz[i][2] + (( modelview[8] - modelview[9]) * Size)));
          glTexCoord2f(0.0, 0.0);
          glVertex3f((cordz[i][0] + (( -modelview[0] + modelview[1]) * Size)),
                     (cordz[i][1] + (( -modelview[4] + modelview[5]) * Size)),
                     (cordz[i][2] + (( -modelview[8] + modelview[9]) * Size)));
          glTexCoord2f(1.0, 0.0);
          glVertex3f((cordz[i][0] + (( modelview[0] + modelview[1]) * Size)),
                     (cordz[i][1] + (( modelview[4] + modelview[5]) * Size)),
                     (cordz[i][2] + (( modelview[8] + modelview[9]) * Size)));
         glEnd;
  end;
end;

procedure TParticlesGL.draw_par4;
var
  i:integer;
  Size : glfloat;
begin
  for i:=0 to colpr-1 do
  begin
   if lifers[i] > 12
      then glBindTexture(GL_TEXTURE_2D, array_text[16])
         else  glBindTexture(GL_TEXTURE_2D, array_text[21]);

     glcolor4fv(@colrs[i]);
     size := colrs[i][3]*3.0;
         glBegin(GL_TRIANGLE_STRIP);
          glTexCoord2f(0.0, 1.0);
          glVertex3f((cordz[i][0] + (( -modelview[0] - modelview[1]) * Size)),
                     (cordz[i][1] + (( -modelview[4] - modelview[5]) * Size)),
                     (cordz[i][2] + (( -modelview[8] - modelview[9]) * Size)));
          glTexCoord2f(1.0, 1.0);
          glVertex3f((cordz[i][0] + (( modelview[0] - modelview[1]) * Size)),
                     (cordz[i][1] + (( modelview[4] - modelview[5]) * Size)),
                     (cordz[i][2] + (( modelview[8] - modelview[9]) * Size)));
          glTexCoord2f(0.0, 0.0);
          glVertex3f((cordz[i][0] + (( -modelview[0] + modelview[1]) * Size)),
                     (cordz[i][1] + (( -modelview[4] + modelview[5]) * Size)),
                     (cordz[i][2] + (( -modelview[8] + modelview[9]) * Size)));
          glTexCoord2f(1.0, 0.0);
          glVertex3f((cordz[i][0] + (( modelview[0] + modelview[1]) * Size)),
                     (cordz[i][1] + (( modelview[4] + modelview[5]) * Size)),
                     (cordz[i][2] + (( modelview[8] + modelview[9]) * Size)));
         glEnd;
  end;
end;




  procedure DrawSprite(pos:TGLNrf3;cam_nap:TGLNrf3;size:glfloat);
  const z:TGLNrf3 = (0,1,1);
  var  p:array[0..3] of TGLNrf3;
       v1,v2:TGLNrf3;
  begin
    v1:=cross_pr(cam_nap,z);
    v2:=cross_pr(cam_nap,v1);

    normalize(v1); multiple(v1,size/2);
    normalize(v2); multiple(v2,size/2);

    p[0][0]:=pos[0]-v1[0]-v2[0];
    p[0][1]:=pos[1]-v1[1]-v2[1];
    p[0][2]:=pos[2]-v1[2]-v2[2];

    p[1][0]:=pos[0]+v1[0]-v2[0];
    p[1][1]:=pos[1]+v1[1]-v2[1];
    p[1][2]:=pos[2]+v1[2]-v2[2];

    p[2][0]:=pos[0]+v1[0]+v2[0];
    p[2][1]:=pos[1]+v1[1]+v2[1];
    p[2][2]:=pos[2]+v1[2]+v2[2];

    p[3][0]:=pos[0]-v1[0]+v2[0];
    p[3][1]:=pos[1]-v1[1]+v2[1];
    p[3][2]:=pos[2]-v1[2]+v2[2];

    glBegin(gl_quads);
     glTexCoord2f(0,0);  glVertex3fv(@p[0]);
     glTexCoord2f(1,0);  glVertex3fv(@p[1]);
     glTexCoord2f(1,1);  glVertex3fv(@p[2]);
     glTexCoord2f(0,1);  glVertex3fv(@p[3]);
    glEnd;

  end;

end.




{
   glBegin(GL_TRIANGLE_STRIP);                     //GL_TRIANGLE_STRIP
    glTexCoord2f(0.0, 1.0);
    glVertex3f((cordz[i][0] + (( -modelview[0] - modelview[1]) * Size)),
               (cordz[i][1] + (( -modelview[4] - modelview[5]) * Size)),
               (cordz[i][2] + (( -modelview[8] - modelview[9]) * Size)));
    glTexCoord2f(1.0, 1.0);
    glVertex3f((cordz[i][0] + (( modelview[0] - modelview[1]) * Size)),
               (cordz[i][1] + (( modelview[4] - modelview[5]) * Size)),
               (cordz[i][2] + (( modelview[8] - modelview[9]) * Size)));
    glTexCoord2f(0.0, 0.0);
    glVertex3f((cordz[i][0] + (( -modelview[0] + modelview[1]) * Size)),
               (cordz[i][1] + (( -modelview[4] + modelview[5]) * Size)),
               (cordz[i][2] + (( -modelview[8] + modelview[9]) * Size)));
    glTexCoord2f(1.0, 0.0);
    glVertex3f((cordz[i][0] + (( modelview[0] + modelview[1]) * Size)),
               (cordz[i][1] + (( modelview[4] + modelview[5]) * Size)),
               (cordz[i][2] + (( modelview[8] + modelview[9]) * Size)));

   glEnd;
}
