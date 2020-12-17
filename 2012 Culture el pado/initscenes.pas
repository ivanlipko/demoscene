unit initscenes;

interface

uses
  OpenGL
  ,Textures
  ,Classes
  ,Windows
  ,Particle
  ;


const

  path_gfx = 'data\gfx\';
  path_obj = 'data\obj\';
  TIMER_PARTICLES = 2;
  INTERVAL_PARTICLES = 50;

  //OpenGL
  opengl32  = 'opengl32.dll';
  kernel32  = 'kernel32.dll';

  GL_VERTEX_ARRAY                            = $8074;
  GL_NORMAL_ARRAY                            = $8075;
  GL_COLOR_ARRAY                             = $8076;
  GL_TEXTURE_COORD_ARRAY                     = $8078;

  // InterleavedArrayFormat
  GL_V2F                                     = $2A20;
  GL_V3F                                     = $2A21;
  GL_C4UB_V2F                                = $2A22;
  GL_C4UB_V3F                                = $2A23;
  GL_C3F_V3F                                 = $2A24;
  GL_N3F_V3F                                 = $2A25;
  GL_C4F_N3F_V3F                             = $2A26;
  GL_T2F_V3F                                 = $2A27;
  GL_T4F_V4F                                 = $2A28;
  GL_T2F_C4UB_V3F                            = $2A29;
  GL_T2F_C3F_V3F                             = $2A2A;
  GL_T2F_N3F_V3F                             = $2A2B;
  GL_T2F_C4F_N3F_V3F                         = $2A2C;
  GL_T4F_C4F_N3F_V4F                         = $2A2D;

  GL_POLYGON_OFFSET_FILL                     = $8037 ;

  //data
  pic = 1/180*pi;

  //time
  TIME_BULB = 2060;
  TIME_STAIRWAY = 34028;

  partyscol = 10;

type

  //OpenGL
  PGLHandleARB = ^GLHandleARB;
  GLHandleARB = integer;
  PPGLCharARB  = ^PGLCharARB;
  PGLCharARB   = ^GLCharARB;
  GLCharARB    = Char;

  TMyStream = class(TThread)
    private
    protected
       procedure Execute; override;
    public
  end;

  party = record
   x,y,z : glfloat;
   xp,yp,zp : glfloat;
   life : glfloat;
   lifep : glfloat;
  end;

  Array36 = //array [0..323] of GLfloat;
            //array [0..6107] of GLfloat;
            //array [0..10079] of GLfloat;   //1680
            //array [0..20999] of GLfloat;   //1680+1503
            array [0..27299] of GLfloat;   //4550
var
  h_Wnd  : HWND;                     // Global window handle
  h_DC   : HDC;                      // Global device context
  h_RC   : HGLRC;                    // OpenGL rendering context
  h_RC_res   : HGLRC;                    // OpenGL rendering context for resources

  xx_x : glfloat = 0;
  xx_y : glfloat = 0;
  xx_z : glfloat = 0;
           {
  cc_r : glfloat = 1;
  cc_g : glfloat = 1;
  cc_b : glfloat = 1;        }
  PartyIndex : GLint = 0;
  PointsCount : GLint = 0;
  PointsCount1 : GLint = 0;
   count: array [0..15] of word;  

  path_exe : String;
  
  //synhro
  Stage : byte = 0;
  Progress : byte = 0;
  ElapsedTime : Integer = 0;
//  delta : Extended = 0;

  //particle systems
  ParticalsRain : TParticlesGL;
  ParticalsFog : TParticlesGL;
  ParticalsSmoke : TParticlesGL;

  //textures
  array_text : array [0..30] of GLuint;



  intertwined{, intertwined1}: Array36 ;
  
  //OpenGL
  procedure glVertexPointer(size:GLint; atype:GLenum; stride:GLsizei; data:pointer); stdcall; external OpenGL32;
  procedure glColorPointer(size:GLint; atype:GLenum; stride:GLsizei; data:pointer); stdcall; external OpenGL32;
  procedure glNormalPointer(atype:GLenum; stride:GLsizei; data:pointer); stdcall; external OpenGL32;
  procedure glTexCoordPointer(size: GLint; atype: GLEnum; stride: GLsizei; data: pointer); stdcall; external OpenGL32;
  procedure glDrawArrays(mode:GLenum; first:GLint; count:GLsizei); stdcall; external OpenGL32;
  procedure glDrawElements(mode: GLEnum; count: GLsizei; atype: GLEnum; indices: Pointer); stdcall; external OpenGL32;
  procedure glEnableClientState(aarray:GLenum); stdcall; external OpenGL32;
  procedure glDisableClientState(aarray:GLenum); stdcall; external OpenGL32;
  procedure glInterleavedArrays (format: GlEnum; stride: Glsizei; data: pointer);     stdcall;     external OpenGL32;

  procedure glBindTexture(target: GLenum; texture: GLuint);  stdcall; external OpenGL32;
  procedure glDeleteTextures(n: GLsizei; var textures: GLuint); stdcall; external opengl32;
  procedure glPolygonOffset(Factor, Bias: glFloat); stdcall; external opengl32;

  //Secondary
  function Hevi( into : GLfloat) : GLfloat;
  function IntToStr(Num : Integer) : String;

  //Initial
  procedure InitLoadScreen;
  procedure InitLoadData;  


implementation

//uses //SysUtils,
// Windows
// ;


function Hevi( into : GLfloat) : GLfloat;
begin

  if into > 0 then Result := into
  else Result := 0;

end;


function IntToStr(Num : Integer) : String;
begin
  Str(Num, result);
end;    


procedure InitLoadScreen;
var
 i:byte;
begin
//glInterleavedArrays (GL_C3F_V3F, 0, @intertwined);
   LoadTexture(path_exe + path_gfx + 'loader.jpg',array_text[0]);

   glEnable(GL_TEXTURE_2D);
end;


procedure InitLoadData;
var
  Stream :TMyStream;
begin
  Stream:=TMyStream.Create(true);
  Stream.FreeOnTerminate := true;
  Stream.Priority := tpLower;
  Stream.Resume;
end;


procedure TMyStream.Execute;
var
   i,j,k: word;
   f: TextFile;
   tempar : array [0..11] of array [0..1241] of GLfloat; //935

begin
wglMakeCurrent(h_DC, h_RC_res) ;
 //here is code to data load
   LoadTexture(path_exe + path_gfx + 'loader_0.jpg',array_text[1]);
   LoadTexture(path_exe + path_gfx + 'loader_1.jpg',array_text[2]);
   LoadTexture(path_exe + path_gfx + 'loader_2.jpg',array_text[3]);
   LoadTexture(path_exe + path_gfx + 'loader_3.jpg',array_text[4]);
   LoadTexture(path_exe + path_gfx + 'loader_4.jpg',array_text[5]);
   LoadTexture(path_exe + path_gfx + 'loader_5.jpg',array_text[6]);
   LoadTexture(path_exe + path_gfx + 'loader_6.jpg',array_text[7]);
 inc(Progress);
   LoadTexture(path_exe + path_gfx + 'rain.tga', array_text[8]);
   LoadTexture(path_exe + path_gfx + 'street.jpg', array_text[9]);
   LoadTexture(path_exe + path_gfx + 'street_car.jpg', array_text[10]);
   LoadTexture(path_exe + path_gfx + 'street_man.jpg', array_text[11]); { }
   LoadTexture(path_exe + path_gfx + 'movie_screen.tga', array_text[12]);
 inc(Progress);
   LoadTexture(path_exe + path_gfx + 'rainsplash_1.tga', array_text[13]);
   LoadTexture(path_exe + path_gfx + 'stage.jpg', array_text[14]);
   LoadTexture(path_exe + path_gfx + 'stage.tga', array_text[15]);      {}
   LoadTexture(path_exe + path_gfx + 'spot.tga', array_text[16]);
   //LoadTexture(path_exe + path_gfx + 'bar_table.jpg', array_text[17]);
   LoadTexture(path_exe + path_gfx + 'culture.tga', array_text[18]);
   LoadTexture(path_exe + path_gfx + 'elpado.tga', array_text[19]);
 inc(Progress);                                      {}
   LoadTexture(path_exe + path_gfx + 'smoketube.tga', array_text[20]);
   LoadTexture(path_exe + path_gfx + 'smoke.tga', array_text[21]);     {}
   LoadTexture(path_exe + path_gfx + 'pokerwall.jpg', array_text[22]);
   LoadTexture(path_exe + path_gfx + 'pokerhands.tga', array_text[23]);
   LoadTexture(path_exe + path_gfx + 'pokerlight.tga', array_text[24]);
   LoadTexture(path_exe + path_gfx + 'pokertable.tga', array_text[25]);  {}
   LoadTexture(path_exe + path_gfx + 'greets.jpg', array_text[26]);

 inc(Progress);
  //inc(Progress);


  ParticalsRain:=TParticlesGl.create;

  ParticalsRain.posis[0] := 0;
  ParticalsRain.posis[1] := 0;
  ParticalsRain.posis[2] := -80;

  ParticalsRain.Narvl[0] := -0.2;
  ParticalsRain.Narvl[1] := -3;
  ParticalsRain.Narvl[2] := -1;

  ParticalsRain.color[0] := 1;
  ParticalsRain.color[1] := 0.8;
  ParticalsRain.color[2] := 0.5;
  ParticalsRain.color[3] := 0.5;

  ParticalsRain.coldz[0] := 0;
  ParticalsRain.coldz[1] := 0;
  ParticalsRain.coldz[2] := 0;
  ParticalsRain.coldz[3] := 0;

  ParticalsRain.colpr := 0;
  ParticalsRain.rand  := 30;
  ParticalsRain.lifeS := 5;
  ParticalsRain.lifeD := -0.2;

  ParticalsRain.cordz_cpf[0] := 3;
  ParticalsRain.cordz_cpf[1] := 2;
  ParticalsRain.cordz_cpf[2] := 6;
                 {    }
  for i:=0 to 2000 do begin
   ParticalsRain.add_particle;
   ParticalsRain.reset_pr;
  end;
  for i:=0 to 300 do ParticalsRain.reset_pr;
                      {}
 inc(Progress);

  ParticalsFog:=TParticlesGl.create;

  ParticalsFog.posis[0] := 0;
  ParticalsFog.posis[1] := 0;  //-200
  ParticalsFog.posis[2] := -20;// -165;

  ParticalsFog.Narvl[0] := 0;
  ParticalsFog.Narvl[1] := 0.150;
  ParticalsFog.Narvl[2] := 0.0;

  ParticalsFog.color[0] := 1.0;
  ParticalsFog.color[1] := 1.0;
  ParticalsFog.color[2] := 1.0;
  ParticalsFog.color[3] := 0.4;

  ParticalsFog.coldz[0] := 0.0;
  ParticalsFog.coldz[1] := 0.015;
  ParticalsFog.coldz[2] := 0.015;
  ParticalsFog.coldz[3] := 0.02;

  ParticalsFog.cordz_cpf[0] := 5;
  ParticalsFog.cordz_cpf[1] := 0.1;
  ParticalsFog.cordz_cpf[2] := 1;

  ParticalsFog.colpr := 0;
  ParticalsFog.rand  := 20;
  ParticalsFog.lifeS := 20;
  ParticalsFog.lifeD := -0.1;
                       {}
  for i:=0 to 1000 do begin
   ParticalsFog.add_particle;
   ParticalsFog.reset_pr;
  end;
  for i:=0 to 100 do ParticalsFog.reset_pr;
                    {  }

 inc(Progress);

  ParticalsSmoke:=TParticlesGl.create;

  ParticalsSmoke.posis[0] := -35;
  ParticalsSmoke.posis[1] := -5;  //-200
  ParticalsSmoke.posis[2] := -50;// -165;

  ParticalsSmoke.Narvl[0] := 0.0;
  ParticalsSmoke.Narvl[1] := 0.80;
  ParticalsSmoke.Narvl[2] := 0.0;

  ParticalsSmoke.color[0] := 1.0;
  ParticalsSmoke.color[1] := 1.0;
  ParticalsSmoke.color[2] := 1.0;
  ParticalsSmoke.color[3] := 2.4;

  ParticalsSmoke.coldz[0] := -0.02;//0.0;
  ParticalsSmoke.coldz[1] := -0.005;//0.015;
  ParticalsSmoke.coldz[2] := -0.005;//0.015;
  ParticalsSmoke.coldz[3] := 0.020;

  ParticalsSmoke.cordz_cpf[0] := 0.31;
  ParticalsSmoke.cordz_cpf[1] := 0.31;
  ParticalsSmoke.cordz_cpf[2] := 0.1;

  ParticalsSmoke.colpr := 0;
  ParticalsSmoke.rand  := 20;
  ParticalsSmoke.lifeS := 20;
  ParticalsSmoke.lifeD := -0.101;
                       { }
  for i:=0 to 200 do begin
   ParticalsSmoke.add_particle;
   ParticalsSmoke.reset_pr;
  end;
  for i:=0 to 100 do ParticalsSmoke.reset_pr;
                       {}

 inc(Progress);

  //i := 0;
                             { }
  AssignFile(f, path_exe + path_obj + 'out_joker.txt');
  Reset(f);
  Readln(f, count[0]);
  for i:=0 to count[0]-1 do begin
     //color
     Read(f, intertwined[i*6  ] );
     Read(f, intertwined[i*6+1] );
     Read(f, intertwined[i*6+2] );
     //coords
     Read(f, intertwined[i*6+3] );
     Read(f, intertwined[i*6+4] );
     Read(f, intertwined[i*6+5] );
     Readln(f);
  end;
  CloseFile(f);
//  PointsCount := PointsCount + count[0];

  AssignFile(f, path_exe + path_obj + 'out_karts.txt');
  Reset(f);
  Readln(f, count[1]);
  for j:=0 to count[1]-1 do begin
     //color
     Read(f, intertwined[i*6  ] );
     Read(f, intertwined[i*6+1] );
     Read(f, intertwined[i*6+2] );
     //coords
     Read(f, intertwined[i*6+3] );
     Read(f, intertwined[i*6+4] );
     Read(f, intertwined[i*6+5] );
     Readln(f);
     i := i + 1;
  end;
  CloseFile(f);


  AssignFile(f, path_exe + path_obj + 'out_cvet.txt');
  Reset(f);
  Readln(f, count[2]);
  for j:=0 to count[2]-1 do begin
     //color
     Read(f, intertwined[i*6  ] );
     Read(f, intertwined[i*6+1] );
     Read(f, intertwined[i*6+2] );
     //coords
     Read(f, intertwined[i*6+3] );
     Read(f, intertwined[i*6+4] );
     Read(f, intertwined[i*6+5] );
     Readln(f);
     i := i + 1;
  end;
  CloseFile(f);
//  PointsCount := count[1];


  AssignFile(f, path_exe + path_obj + 'out_cvet1.txt');
  Reset(f);
  Readln(f, count[3]);
  for j:=0 to count[3]-1 do begin
     //color
     Read(f, intertwined[i*6  ] );
     Read(f, intertwined[i*6+1] );
     Read(f, intertwined[i*6+2] );
     //coords
     Read(f, intertwined[i*6+3] );
     Read(f, intertwined[i*6+4] );
     Read(f, intertwined[i*6+5] );
     Readln(f);
     i := i + 1;
  end;
  CloseFile(f);             { }

  AssignFile(f, path_exe + path_obj + 'out_cityline.txt');
  Reset(f);
  Readln(f, count[4]);
  for j:=0 to count[4]-1 do begin
     //color
     Read(f, intertwined[i*6  ] );
     Read(f, intertwined[i*6+1] );
     Read(f, intertwined[i*6+2] );
     //coords
     Read(f, intertwined[i*6+3] );
     Read(f, intertwined[i*6+4] );
     Read(f, intertwined[i*6+5] );
     Readln(f);
     i := i + 1;
  end;
  CloseFile(f);

  AssignFile(f, path_exe + path_obj + 'out_zd.txt');
  Reset(f);
  Readln(f, count[5]);
  for j:=0 to count[5]-1 do begin
     //color
     Read(f, intertwined[i*6  ] );
     Read(f, intertwined[i*6+1] );
     Read(f, intertwined[i*6+2] );
     //coords
     Read(f, intertwined[i*6+3] );
     Read(f, intertwined[i*6+4] );
     Read(f, intertwined[i*6+5] );
     Readln(f);
     i := i + 1;
  end;
  CloseFile(f);

  AssignFile(f, path_exe + path_obj + 'out_zds.txt');
  Reset(f);
  Readln(f, count[6]);
  for j:=0 to count[6]-1 do begin
     //color
     Read(f, intertwined[i*6  ] );
     Read(f, intertwined[i*6+1] );
     Read(f, intertwined[i*6+2] );
     //coords
     Read(f, intertwined[i*6+3] );
     Read(f, intertwined[i*6+4] );
     Read(f, intertwined[i*6+5] );
     Readln(f);
     i := i + 1;
  end;
  CloseFile(f);

  AssignFile(f, path_exe + path_obj + 'out_mzd.txt');
  Reset(f);
  Readln(f, count[7]);
  for j:=0 to count[7]-1 do begin
     //color
     Read(f, intertwined[i*6  ] );
     Read(f, intertwined[i*6+1] );
     Read(f, intertwined[i*6+2] );
     //coords
     Read(f, intertwined[i*6+3] );
     Read(f, intertwined[i*6+4] );
     Read(f, intertwined[i*6+5] );
     Readln(f);
     i := i + 1;
  end;
  CloseFile(f);

  AssignFile(f, path_exe + path_obj + 'out_sunline.txt');
  Reset(f);
  Readln(f, count[8]);
  for j:=0 to count[8]-1 do begin
     //color
     Read(f, intertwined[i*6  ] );
     Read(f, intertwined[i*6+1] );
     Read(f, intertwined[i*6+2] );
     //coords
     Read(f, intertwined[i*6+3] );
     Read(f, intertwined[i*6+4] );
     Read(f, intertwined[i*6+5] );
     Readln(f);
     i := i + 1;
  end;
  CloseFile(f);

  AssignFile(f, path_exe + path_obj + 'out_sunlines.txt');
  Reset(f);
  Readln(f, count[9]);
  for j:=0 to count[9]-1 do begin
     //color
     Read(f, intertwined[i*6  ] );
     Read(f, intertwined[i*6+1] );
     Read(f, intertwined[i*6+2] );
     //coords
     Read(f, intertwined[i*6+3] );
     Read(f, intertwined[i*6+4] );
     Read(f, intertwined[i*6+5] );
     Readln(f);
     i := i + 1;
  end;
  CloseFile(f);

  AssignFile(f, path_exe + path_obj + 'out_lakeline.txt');
  Reset(f);
  Readln(f, count[10]);
  for j:=0 to count[10]-1 do begin
     //color
     Read(f, intertwined[i*6  ] );
     Read(f, intertwined[i*6+1] );
     Read(f, intertwined[i*6+2] );
     //coords
     Read(f, intertwined[i*6+3] );
     Read(f, intertwined[i*6+4] );
     Read(f, intertwined[i*6+5] );
     Readln(f);
     i := i + 1;
  end;
  CloseFile(f);

  AssignFile(f, path_exe + path_obj + 'out_man.txt');
  Reset(f);
  Readln(f, count[11]);
  for j:=0 to count[11]-1 do begin
     //color
     Read(f, intertwined[i*6  ] );
     Read(f, intertwined[i*6+1] );
     Read(f, intertwined[i*6+2] );
     //coords
     Read(f, intertwined[i*6+3] );
     Read(f, intertwined[i*6+4] );
     Read(f, intertwined[i*6+5] );
     Readln(f);
     i := i + 1;
  end;
  CloseFile(f);

  AssignFile(f, path_exe + path_obj + 'out_krug.txt');
  Reset(f);
  Readln(f, count[12]);
  for j:=0 to count[12]-1 do begin
     //color
     Read(f, intertwined[i*6  ] );
     Read(f, intertwined[i*6+1] );
     Read(f, intertwined[i*6+2] );
     //coords
     Read(f, intertwined[i*6+3] );
     Read(f, intertwined[i*6+4] );
     Read(f, intertwined[i*6+5] );
     Readln(f);
     i := i + 1;
  end;
  CloseFile(f);

  AssignFile(f, path_exe + path_obj + 'out_quest.txt');
  Reset(f);
  Readln(f, count[13]);
  for j:=0 to count[13]-1 do begin
     //color
     Read(f, intertwined[i*6  ] );
     Read(f, intertwined[i*6+1] );
     Read(f, intertwined[i*6+2] );
     //coords
     Read(f, intertwined[i*6+3] );
     Read(f, intertwined[i*6+4] );
     Read(f, intertwined[i*6+5] );
     Readln(f);
     i := i + 1;
  end;
  CloseFile(f);


                       (*
  AssignFile(f, path_exe + 'out_legr.txt');
  Reset(f);
  Readln(f, count[0]);
  for i:=0 to count[0]-1 do begin
     //color
     Read(f, tempar[0][i*6  ] );
     Read(f, tempar[0][i*6+1] );
     Read(f, tempar[0][i*6+2] );
     //coords
     Read(f, tempar[0][i*6+3] );
     Read(f, tempar[0][i*6+4] );
     Read(f, tempar[0][i*6+5] );
     Readln(f);
  end;
  PointsCount := PointsCount + count[0];
  CloseFile(f);

  AssignFile(f, path_exe + 'out_hands.txt');
  Reset(f);
  Readln(f, count[1]);
  for i:=0 to count[1]-1 do begin
     //color
     Read(f, tempar[1][i*6  ] );
     Read(f, tempar[1][i*6+1] );
     Read(f, tempar[1][i*6+2] );
     //coords
     Read(f, tempar[1][i*6+3] );
     Read(f, tempar[1][i*6+4] );
     Read(f, tempar[1][i*6+5] );
     Readln(f);
  end;
  PointsCount := PointsCount + count[1];
  CloseFile(f);

  AssignFile(f, path_exe + 'out_legs.txt');
  Reset(f);
  Readln(f, count[2]);
  for i:=0 to count[2]-1 do begin
     //color
     Read(f, tempar[2][i*6  ] );
     Read(f, tempar[2][i*6+1] );
     Read(f, tempar[2][i*6+2] );
     //coords
     Read(f, tempar[2][i*6+3] );
     Read(f, tempar[2][i*6+4] );
     Read(f, tempar[2][i*6+5] );
     Readln(f);
  end;
  PointsCount := PointsCount + count[2];
  CloseFile(f);

  AssignFile(f, path_exe + 'out_man.txt');
  Reset(f);
  Readln(f, count[3]);
  for i:=0 to count[3]-1 do begin
     //color
     Read(f, tempar[3][i*6  ] );
     Read(f, tempar[3][i*6+1] );
     Read(f, tempar[3][i*6+2] );
     //coords
     Read(f, tempar[3][i*6+3] );
     Read(f, tempar[3][i*6+4] );
     Read(f, tempar[3][i*6+5] );
     Readln(f);
  end;
  PointsCount := PointsCount + count[3];
  CloseFile(f);
                                    {
  AssignFile(f, path_exe + 'out_line1-all.txt');
  Reset(f);
  Readln(f, count[4]);
  for i:=0 to count[4]-1 do begin
     //color
     Read(f, tempar[4][i*6  ] );
     Read(f, tempar[4][i*6+1] );
     Read(f, tempar[4][i*6+2] );
     //coords
     Read(f, tempar[4][i*6+3] );
     Read(f, tempar[4][i*6+4] );
     Read(f, tempar[4][i*6+5] );
     Readln(f);
  end;
  PointsCount := PointsCount + count[4];
  CloseFile(f);
                                 {
  AssignFile(f, path_exe + path_obj + 'out_stebel.txt');
  Reset(f);
  Readln(f, count[5]);
  for i:=0 to count[5]-1 do begin
     //color
     Read(f, tempar[5][i*6  ] );
     Read(f, tempar[5][i*6+1] );
     Read(f, tempar[5][i*6+2] );
     //coords
     Read(f, tempar[5][i*6+3] );
     Read(f, tempar[5][i*6+4] );
     Read(f, tempar[5][i*6+5] );
     Readln(f);
  end;
  PointsCount := PointsCount + count[5];
  CloseFile(f);            }

  j := 0;
  i := 0;

  for k:=0 to count[0]-1 do begin
     //color
     intertwined[j*6  ] := tempar[0][i*6  ] ;
     intertwined[j*6+1] := tempar[0][i*6+1] ;
     intertwined[j*6+2] := tempar[0][i*6+2] ;
     //coords                    
     intertwined[j*6+3] := tempar[0][i*6+3] ;
     intertwined[j*6+4] := tempar[0][i*6+4] ;
     intertwined[j*6+5] := tempar[0][i*6+5] ;
     j:=j+1;                            
     //color                     
     intertwined[j*6  ] := tempar[1][i*6  ] ;
     intertwined[j*6+1] := tempar[1][i*6+1] ;
     intertwined[j*6+2] := tempar[1][i*6+2] ;
     //coords                    
     intertwined[j*6+3] := tempar[1][i*6+3] ;
     intertwined[j*6+4] := tempar[1][i*6+4] ;
     intertwined[j*6+5] := tempar[1][i*6+5] ;
     j:=j+1;
     //color
     intertwined[j*6  ] := tempar[2][i*6  ] ;
     intertwined[j*6+1] := tempar[2][i*6+1] ;
     intertwined[j*6+2] := tempar[2][i*6+2] ;
     //coords                    
     intertwined[j*6+3] := tempar[2][i*6+3] ;
     intertwined[j*6+4] := tempar[2][i*6+4] ;
     intertwined[j*6+5] := tempar[2][i*6+5] ;
     j:=j+1;
     //color                     
     intertwined[j*6  ] := tempar[3][i*6  ] ;
     intertwined[j*6+1] := tempar[3][i*6+1] ;
     intertwined[j*6+2] := tempar[3][i*6+2] ;
     //coords                    
     intertwined[j*6+3] := tempar[3][i*6+3] ;
     intertwined[j*6+4] := tempar[3][i*6+4] ;
     intertwined[j*6+5] := tempar[3][i*6+5] ;
     j:=j+1;                       {
     //color
     intertwined[j*6  ] := tempar[4][i*6  ] ;
     intertwined[j*6+1] := tempar[4][i*6+1] ;
     intertwined[j*6+2] := tempar[4][i*6+2] ;
     //coords                    
     intertwined[j*6+3] := tempar[4][i*6+3] ;
     intertwined[j*6+4] := tempar[4][i*6+4] ;
     intertwined[j*6+5] := tempar[4][i*6+5] ;
     j:=j+1;                        {
     //color
     intertwined[j*6  ] := tempar[5][i*6  ] ;
     intertwined[j*6+1] := tempar[5][i*6+1] ;
     intertwined[j*6+2] := tempar[5][i*6+2] ;
     //coords                    
     intertwined[j*6+3] := tempar[5][i*6+3] ;
     intertwined[j*6+4] := tempar[5][i*6+4] ;
     intertwined[j*6+5] := tempar[5][i*6+5] ;
     j:=j+1;                            
     //color                               }

	 //j:=j+1;
	 i:=i+1;
  end;

  for k:=0 to count[1]-count[0]-1 do begin
     //color
     intertwined[j*6  ] := tempar[1][i*6  ] ;
     intertwined[j*6+1] := tempar[1][i*6+1] ;
     intertwined[j*6+2] := tempar[1][i*6+2] ;
     //coords                    
     intertwined[j*6+3] := tempar[1][i*6+3] ;
     intertwined[j*6+4] := tempar[1][i*6+4] ;
     intertwined[j*6+5] := tempar[1][i*6+5] ;
     j:=j+1;
     //color
     intertwined[j*6  ] := tempar[2][i*6  ] ;
     intertwined[j*6+1] := tempar[2][i*6+1] ;
     intertwined[j*6+2] := tempar[2][i*6+2] ;
     //coords                    
     intertwined[j*6+3] := tempar[2][i*6+3] ;
     intertwined[j*6+4] := tempar[2][i*6+4] ;
     intertwined[j*6+5] := tempar[2][i*6+5] ;
     j:=j+1;
     //color
     intertwined[j*6  ] := tempar[3][i*6  ] ;
     intertwined[j*6+1] := tempar[3][i*6+1] ;
     intertwined[j*6+2] := tempar[3][i*6+2] ;
     //coords                    
     intertwined[j*6+3] := tempar[3][i*6+3] ;
     intertwined[j*6+4] := tempar[3][i*6+4] ;
     intertwined[j*6+5] := tempar[3][i*6+5] ;
     j:=j+1;                        {
     //color      
     intertwined[j*6  ] := tempar[4][i*6  ] ;
     intertwined[j*6+1] := tempar[4][i*6+1] ;
     intertwined[j*6+2] := tempar[4][i*6+2] ;
     //coords                    
     intertwined[j*6+3] := tempar[4][i*6+3] ;
     intertwined[j*6+4] := tempar[4][i*6+4] ;
     intertwined[j*6+5] := tempar[4][i*6+5] ;
     j:=j+1;                         {
     //color      
     intertwined[j*6  ] := tempar[5][i*6  ] ;
     intertwined[j*6+1] := tempar[5][i*6+1] ;
     intertwined[j*6+2] := tempar[5][i*6+2] ;
     //coords                    
     intertwined[j*6+3] := tempar[5][i*6+3] ;
     intertwined[j*6+4] := tempar[5][i*6+4] ;
     intertwined[j*6+5] := tempar[5][i*6+5] ;
     j:=j+1;            
     //color                       }

	 //j:=j+1;
	 i:=i+1;
  end;

  for k:=0 to count[2]-count[1]-1 do begin
     //color
     intertwined[j*6  ] := tempar[2][i*6  ] ;
     intertwined[j*6+1] := tempar[2][i*6+1] ;
     intertwined[j*6+2] := tempar[2][i*6+2] ;
     //coords                    
     intertwined[j*6+3] := tempar[2][i*6+3] ;
     intertwined[j*6+4] := tempar[2][i*6+4] ;
     intertwined[j*6+5] := tempar[2][i*6+5] ;
     j:=j+1;
     //color      
     intertwined[j*6  ] := tempar[3][i*6  ] ;
     intertwined[j*6+1] := tempar[3][i*6+1] ;
     intertwined[j*6+2] := tempar[3][i*6+2] ;
     //coords                    
     intertwined[j*6+3] := tempar[3][i*6+3] ;
     intertwined[j*6+4] := tempar[3][i*6+4] ;
     intertwined[j*6+5] := tempar[3][i*6+5] ;
     j:=j+1;                         {
     //color
     intertwined[j*6  ] := tempar[4][i*6  ] ;
     intertwined[j*6+1] := tempar[4][i*6+1] ;
     intertwined[j*6+2] := tempar[4][i*6+2] ;
     //coords                    
     intertwined[j*6+3] := tempar[4][i*6+3] ;
     intertwined[j*6+4] := tempar[4][i*6+4] ;
     intertwined[j*6+5] := tempar[4][i*6+5] ;
     j:=j+1;                           {
     //color
     intertwined[j*6  ] := tempar[5][i*6  ] ;
     intertwined[j*6+1] := tempar[5][i*6+1] ;
     intertwined[j*6+2] := tempar[5][i*6+2] ;
     //coords                    
     intertwined[j*6+3] := tempar[5][i*6+3] ;
     intertwined[j*6+4] := tempar[5][i*6+4] ;
     intertwined[j*6+5] := tempar[5][i*6+5] ;
     j:=j+1;             
     //color                              }

	 //j:=j+1;
	 i:=i+1;
  end;

  for k:=0 to count[3]-count[2]-1 do begin
     //color
     intertwined[j*6  ] := tempar[3][i*6  ] ;
     intertwined[j*6+1] := tempar[3][i*6+1] ;
     intertwined[j*6+2] := tempar[3][i*6+2] ;
     //coords                        
     intertwined[j*6+3] := tempar[3][i*6+3] ;
     intertwined[j*6+4] := tempar[3][i*6+4] ;
     intertwined[j*6+5] := tempar[3][i*6+5] ;
     j:=j+1;                         {
     //color
     intertwined[j*6  ] := tempar[4][i*6  ] ;
     intertwined[j*6+1] := tempar[4][i*6+1] ;
     intertwined[j*6+2] := tempar[4][i*6+2] ;
     //coords                        
     intertwined[j*6+3] := tempar[4][i*6+3] ;
     intertwined[j*6+4] := tempar[4][i*6+4] ;
     intertwined[j*6+5] := tempar[4][i*6+5] ;
     j:=j+1;
     //color                        {
     intertwined[j*6  ] := tempar[5][i*6  ] ;
     intertwined[j*6+1] := tempar[5][i*6+1] ;
     intertwined[j*6+2] := tempar[5][i*6+2] ;
     //coords                        
     intertwined[j*6+3] := tempar[5][i*6+3] ;
     intertwined[j*6+4] := tempar[5][i*6+4] ;
     intertwined[j*6+5] := tempar[5][i*6+5] ;
     j:=j+1;
     //color                               }

	 //j:=j+1;
	 i:=i+1;
  end;
                                     (*
  for k:=0 to count[4]-count[3]-1 do begin
     //color
     intertwined[j*6  ] := tempar[4][i*6  ] ;
     intertwined[j*6+1] := tempar[4][i*6+1] ;
     intertwined[j*6+2] := tempar[4][i*6+2] ;
     //coords                        
     intertwined[j*6+3] := tempar[4][i*6+3] ;
     intertwined[j*6+4] := tempar[4][i*6+4] ;
     intertwined[j*6+5] := tempar[4][i*6+5] ;
     j:=j+1;                      {
     //color
     intertwined[j*6  ] := tempar[5][i*6  ] ;
     intertwined[j*6+1] := tempar[5][i*6+1] ;
     intertwined[j*6+2] := tempar[5][i*6+2] ;
     //coords                        
     intertwined[j*6+3] := tempar[5][i*6+3] ;
     intertwined[j*6+4] := tempar[5][i*6+4] ;
     intertwined[j*6+5] := tempar[5][i*6+5] ;
     j:=j+1;
     //color          }

	 //j:=j+1;
	 i:=i+1;
  end;                    {

  for k:=0 to count[5]-count[4]-1 do begin
     //color
     intertwined[j*6  ] := tempar[5][i*6  ] ;
     intertwined[j*6+1] := tempar[5][i*6+1] ;
     intertwined[j*6+2] := tempar[5][i*6+2] ;
     //coords                        
     intertwined[j*6+3] := tempar[5][i*6+3] ;
     intertwined[j*6+4] := tempar[5][i*6+4] ;
     intertwined[j*6+5] := tempar[5][i*6+5] ;
     j:=j+1;
     //color

	 j:=j+1;
	 i:=i+1;
  end;                }

  PointsCount := j; //maybe this is delete line
                              (**)
//                              PointsCount := i;

 inc(Progress);
 inc(Progress);


//  wglMakeCurrent(h_DC, 0) ;
  wglDeleteContext(h_RC_res);

  SetTimer(h_Wnd, TIMER_PARTICLES, INTERVAL_PARTICLES, nil);

  inc(Progress);
  inc(Progress);

  //inc(Stage);
end;


end.


