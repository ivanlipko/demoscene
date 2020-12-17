unit Partical;

interface
uses OpenGL,
        bmp
//        DGlut
//        Dialogs
//        SysUtils
        ;
type
        TP_M3=array [0..2] of real;
        TP_M3I=array [0..2] of Integer;
        TP_M4=array [0..3] of real;

        Particle = record
          Size:real; //размер частицы
          Cord:TP_M3; //тек. положение в пространстве
//          Napr:TP_M3; //вектор направления частицы
          Color:TP_M4; //тек. цвет частицы в rgba
          Rotate:TP_M3;
        end;

        TP_Particle = class
          MAXCount,Count:word;
          TP_random, TP_random1,TP_random2:word;
          TP_randomC, TP_randomC1,TP_randomC2:word;
          TP_Density:real;      

          TP_Nil_Color:TP_M4;
          TP_Nil_Size:Real;
          TP_Nil_Position:TP_M3;

          TP_Nil_Rotate:TP_M3;
          TP_Check_Rotate:TP_M3;

          TP_Check_Napr:TP_M3;
          TP_Check_Color:TP_M4;
          TP_Check_Size:real;          

          d1,d2:real;

          ISIF:boolean;// to stop particals          
//          AlphaQ:real;

          particles:array [1..500] of Particle;

          procedure Add_particle(num:integer);
          procedure Change_particle;
          procedure Draw_particle{(cam:TP_M3)};
          procedure Delete_particle(num:integer);
        end;

        function distance_di(a,b:TP_M3):real;
{var
  ISIF:boolean = true;// to stop particals
 }
implementation

  procedure TP_Particle.Add_particle;
  begin
   if  Count >= MAXCount then exit;
   Count:=Count+1;

   particles[num].Size:=TP_Nil_Size-random(TP_random1)*0.1;

//Standart   particles[num].Size:=TP_Nil_Size;

   particles[num].cord[0]:=random(TP_random)+TP_Nil_Position[0];
   particles[num].cord[1]:=random(TP_random1)+TP_Nil_Position[1];
   particles[num].cord[2]:=random(TP_random2)+TP_Nil_Position[2];

//   particles[num].Color:=TP_Nil_Color;

   particles[num].Color[0]:=-random(TP_randomC )*0.01+TP_Nil_Color[0];
   particles[num].Color[1]:=-random(TP_randomC1)*0.01+TP_Nil_Color[1];
   particles[num].Color[2]:=-random(TP_randomC2)*0.01+TP_Nil_Color[2];
   particles[num].Color[3]:={-random(TP_random2)/3+}TP_Nil_Color[3];

   //particles[num].Rotate:= TP_Nil_Rotate;
   particles[num].Rotate[0]:= TP_Nil_Rotate[0]-random(TP_random)/6;
   particles[num].Rotate[1]:= TP_Nil_Rotate[1]-random(TP_random1)/6;
   particles[num].Rotate[2]:= TP_Nil_Rotate[2]-random(TP_random2)/6;

  end;

  procedure TP_Particle.Change_particle;
  var i,InCount:integer;
  begin
   if not ISIF then exit;   
   i:=1;
   repeat
 {
    particles[i].Color[0]:=particles[i].Color[0]-TP_Check_Color[0]*TP_Check_Color[0]; Значения очень маленькие и квадрат походу не катит)
    particles[i].Color[1]:=particles[i].Color[1]-TP_Check_Color[1]*TP_Check_Color[1];
    particles[i].Color[2]:=particles[i].Color[2]-TP_Check_Color[2]*TP_Check_Color[2];
    particles[i].Color[3]:=particles[i].Color[3]-TP_Check_Color[3];

{}
    particles[i].Color[0]:=particles[i].Color[0]-TP_Check_Color[0];
    particles[i].Color[1]:=particles[i].Color[1]-TP_Check_Color[1];
    particles[i].Color[2]:=particles[i].Color[2]-TP_Check_Color[2];
    particles[i].Color[3]:=particles[i].Color[3]-TP_Check_Color[3]{-random(TP_random)*0.001};
            {
    if particles[i].cord[1]>-15 then
    begin
      particles[i].cord[0]:=particles[i].cord[0]+TP_Check_Napr[0];
      particles[i].cord[1]:=particles[i].cord[1]+TP_Check_Napr[1];
      particles[i].cord[2]:=particles[i].cord[2]+TP_Check_Napr[2];
    end;
                }
      particles[i].cord[0]:=particles[i].cord[0]+TP_Check_Napr[0];
      particles[i].cord[1]:=particles[i].cord[1]+TP_Check_Napr[1];
      particles[i].cord[2]:=particles[i].cord[2]+TP_Check_Napr[2];

   particles[i].Rotate[0]:= particles[i].Rotate[0]+TP_Check_Rotate[0];
   particles[i].Rotate[1]:= particles[i].Rotate[1]+TP_Check_Rotate[1];
   particles[i].Rotate[2]:= particles[i].Rotate[2]+TP_Check_Rotate[2];

           if particles[i].Rotate[0]>360 then particles[i].Rotate[0]:=0;
           if particles[i].Rotate[1]>360 then particles[i].Rotate[1]:=0;
           if particles[i].Rotate[2]>360 then particles[i].Rotate[2]:=0;
 {
    particles[i].cord[1]:=particles[i].cord[1]+TP_Check_Napr[1];
    particles[i].cord[0]:=(10-particles[i].cord[1])*sin(particles[i].cord[1]);
    particles[i].cord[2]:=(10-particles[i].cord[1])*cos(particles[i].cord[1]);
     
{    ПРУЖИНА
    particles[i].cord[1]:=particles[i].cord[1]+TP_Check_Napr[1];
    particles[i].cord[0]:=5*sin(particles[i].cord[1]);
    particles[i].cord[2]:=5*cos(particles[i].cord[1]);
{
    СТАНДАРТ  
    particles[i].cord[0]:=particles[i].cord[0]+TP_Check_Napr[0];
    particles[i].cord[1]:=particles[i].cord[1]+TP_Check_Napr[1];
    particles[i].cord[2]:=particles[i].cord[2]+TP_Check_Napr[2];
{
    particles[i].cord[1]:=particles[i].cord[1]+abs(1/(particles[i].cord[2]))
    particles[i].cord[2]:=particles[i].cord[2]+TP_Check_Napr[2];

}  
{ Standart}
    particles[i].Size:=particles[i].Size-TP_Check_Size;
     {}
//    particles[i].Size:=particles[i].Size-TP_Check_Size-particles[i].cord[1]*0.0005;

// Standart
        if particles[i].Color[3]<=0 then
                        Delete_particle(i);

//    if (particles[i].Size<=0.0)or(particles[i].Color[3]<0.0) then Delete_particle(i);

   inc(i);
   until i>=Count+1;




  d2:=distance_di(particles[Count].cord,TP_Nil_Position);
      if d2>=TP_Density then
                        Add_particle(Count+1);

  end;

procedure TP_Particle.Draw_particle;
//const
        //z:TP_M3 = (1,1,0);
//      AlphaQ = 0.9;
var //p:array[0..3] of TP_M3;
//    v1,v2:TP_M3;
    i:integer;
//    cam:TP_M3;
//k:Integer;
begin
//       k:=ElapsedTime;
//      glPushAttrib(GL_ALL_ATTRIB_BITS);
//    glPushMatrix;      true vrode
          glTranslate(-TP_random/2,-TP_random1/2,-TP_random2/2);
   for i:=1 to Count do
    begin
      glTranslate(particles[i].cord[0], particles[i].cord[1],particles[i].cord[2]);

      glRotatef(particles[i].Rotate[0],1,0,0);
      glRotatef(particles[i].Rotate[1],0,1,0);
      glRotatef(particles[i].Rotate[2],0,0,1);


                                       glColor4f(particles[i].Color[0],particles[i].Color[1],particles[i].Color[2],particles[i].Color[3]);
                                          glutSolidCube(particles[i].Size);
                                       glColor4f(particles[i].Color[0],particles[i].Color[1],particles[i].Color[2],particles[i].Color[3]-0.5);
                                          glutSolidCube(particles[i].Size+0.03);

      glRotatef(particles[i].Rotate[2],0,0,-1);
      glRotatef(particles[i].Rotate[1],0,-1,0);
      glRotatef(particles[i].Rotate[0],-1,0,0);

      glTranslate(-particles[i].cord[0], -particles[i].cord[1],-particles[i].cord[2]);
    end;
      glTranslate(TP_random/2,TP_random1/2,TP_random2/2);

//    glPopMatrix;       true vrode
    {
glAccum(GL_MULT, AlphaQ);
glAccum(GL_ACCUM, 1-AlphaQ);
glAccum(GL_RETURN, 1);
     {}
  //    glPopAttrib();

end;

  procedure TP_Particle.Delete_particle(num:integer);
  var i:Word;
  begin

   if Count<=1 then exit;
   for i:=num to Count do // i:=1
   begin
    particles[i].Size    :=particles[i+1].Size;
    particles[i].cord[0] :=particles[i+1].cord[0];
    particles[i].cord[1] :=particles[i+1].cord[1];
    particles[i].cord[2] :=particles[i+1].cord[2];
    particles[i].Color[0]:=particles[i+1].Color[0];
    particles[i].Color[1]:=particles[i+1].Color[1];
    particles[i].Color[2]:=particles[i+1].Color[2];
    particles[i].Color[3]:=particles[i+1].Color[3];
   end;

   Dec(Count);
end;

function distance_di(a,b:TP_M3):real;
begin
 distance_di:= (a[1] - b[1])*(a[1] - b[1])+(a[2] - b[2])*(a[2] - b[2])+(a[0] - b[0])*(a[0] - b[0]);
end;


end.
