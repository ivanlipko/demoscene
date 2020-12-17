unit genom;

interface
uses
  OpenGL;

type

    TGLNrf4=array[0..3] of glfloat;
    TGLNrf3=array[0..2] of glfloat;
    TGLNrf2=array[0..1] of glfloat;
    TGLNri3=array[0..2] of integer;

    function g_ang(x,y:glfloat):real;
    function cross_pr(a,b:TGLNrf3):TGLNrf3;

    procedure rotate_point(angle:glfloat;var x,y:glfloat);
    procedure normalize(var a:TGLNrf3);
    procedure multiple(var v:TGLNrf3;cof:glfloat);
    procedure Swap_TGLNrf3(var a,b:TGLNrf3);
    procedure Swap_TGLNrf4(var a,b:TGLNrf4);

implementation


procedure Swap_TGLNrf3(var a,b:TGLNrf3);
var temp:TGLNrf3;
begin
  temp:=a;
  a:=b;b:=temp;
end;

procedure Swap_TGLNrf4(var a,b:TGLNrf4);
var temp:TGLNrf4;
begin
  temp:=a;
  a:=b;b:=temp;
end;


function cross_pr(a,b:TGLNrf3):TGLNrf3;
begin
 cross_pr[0]:= a[1] * b[2] - a[2] * b[1];
 cross_pr[1]:= a[2] * b[0] - a[0] * b[2];
 cross_pr[2]:= a[0] * b[1] - a[1] * b[0];
end;

procedure normalize(var a:TGLNrf3);
var d:glfloat;
begin
 d:=sqrt(a[0]*a[0]+a[1]*a[1]+a[2]*a[2]);
 a[0]:=a[0]/d; a[1]:=a[1]/d; a[2]:=a[2]/d;
end;

procedure multiple(var v:TGLNrf3;cof:glfloat);
begin
  v[0]:=v[0]*cof;
  v[1]:=v[1]*cof;
  v[2]:=v[2]*cof;
end;

procedure rotate_point(angle:glfloat;var x,y:glfloat);
var a,r:real;
begin
 if x=0 then
 begin
   r:=abs(y);
   if y>=0 then a:=90;
   if y<0 then a:=270;
 end else
 begin
   r:=sqrt((x*x)+(y*y));
   a:=abs(arctan(y/x)*180/pi);
 end;

 if (x<0)and(y>0)then a:=180-a;
 if (x<0)and(y<0)then a:=180+a;
 if (x>0)and(y<0)then a:=360-a;

 a:=((a+angle)*pi/180);
 x:=r*cos(a);
 y:=r*sin(a);
end;


function g_ang(x,y:glfloat):real;
var a:glfloat;
begin
 if x=0 then
 begin
   if y>0 then a:=90;
   if y<0 then a:=270;
 end else
 begin
   a:=abs(arctan(y/x)*180/pi);
   if (x<0)and(y>0)then a:=180-a; {2-я четверть}
   if (x<0)and(y<0)then a:=180+a; {3-я четверть}
   if (x>0)and(y<0)then a:=360-a; {4-я четверть}
   if (y=0)and(x<0)then a:=180;
 end;
 g_ang:=a;
end;

end.
