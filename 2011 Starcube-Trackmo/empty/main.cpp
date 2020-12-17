#pragma comment(linker,"/MERGE:.rdata=.text")
#define WIN32_LEAN_AND_MEAN
#define WIN32_EXTRA_LEAN
#include <windows.h>
//#include <stdlib.h>
//#include <stdio.h>
#include <math.h>
#include "qsp/qsp.h"
#include "lib/minifmod.h"
#include "my_synth.h"
#include "gl/gl.h"
#include "glut/glut.h"
#include "egl/glext.h"


///////////////////////////////////////////////////////////////////////////////
// sample generation section
///////////////////////////////////////////////////////////////////////////////
#define SEEK_CUR    1
#define SEEK_END    2
#define SEEK_SET    0

int* outlen = 0;
double** output = 0;
FMUSIC_MODULE *mod;
unsigned int STIME = 0;
//char buffer [50];


void sampleloadcallback(void *buff, int lenbytes, int numbits, int instno, int sampno){
	double val;
	double* wave;

	switch(instno)
	{
	case 0:
		wave = output[1];
		break;
	case 1:
		wave = output[2];
		break;
	case 2:
		wave = output[3];
		break;
	case 3:
		wave = output[4];
		break;
	case 4:
		wave = output[5];
		break;
	case 5:
		wave = output[6];
		break;
	default:
		return;
	}

	for (int i=0; i<lenbytes/2; i++)
	{
		val = wave[i];
		val = QSP::Clip(val);
		((signed short int*)(buff))[i] = 32765.0*val;
	}
}

typedef struct 
{
	int length;
	int pos;
	void *data;
} MEMFILE;

unsigned int memopen(char *name)
{
	MEMFILE *memfile;

	memfile = (MEMFILE *)calloc(sizeof(MEMFILE),1);
	{	// hey look some load from resource code!
		HRSRC		rec;
		HGLOBAL		handle;

		//rec = FindResource(NULL, name, RT_RCDATA);
		rec = FindResource(NULL, name, "MUSIC");
		handle = LoadResource(NULL, rec);
		
		memfile->data = LockResource(handle);
		memfile->length = SizeofResource(NULL, rec);
		memfile->pos = 0;
	}
	return (unsigned int)memfile;
}

void memclose(unsigned int handle)
{
	MEMFILE *memfile = (MEMFILE *)handle;
	free(memfile);
}

int memread(void *buffer, int size, unsigned int handle)
{
	MEMFILE *memfile = (MEMFILE *)handle;

	if (memfile->pos + size >= memfile->length)
		size = memfile->length - memfile->pos;

	memcpy(buffer, (char *)memfile->data+memfile->pos, size);
	memfile->pos += size;
	
	return size;
}

void memseek(unsigned int handle, int pos, signed char mode)
{
	MEMFILE *memfile = (MEMFILE *)handle;

	if (mode == SEEK_SET) 
		memfile->pos = pos;
	else if (mode == SEEK_CUR) 
		memfile->pos += pos;
	else if (mode == SEEK_END)
		memfile->pos = memfile->length + pos;

	if (memfile->pos > memfile->length)
		memfile->pos = memfile->length;
}

int memtell(unsigned int handle)
{
	MEMFILE *memfile = (MEMFILE *)handle;

	return memfile->pos;
}

///////////////////////////////////////////////////////////////////////////////
// opengl initialize section
///////////////////////////////////////////////////////////////////////////////
#define GLUT_BITMAP_9_BY_15		((void*)2)

HWND hWnd;
HGLRC hGLRC;
HDC hDC;


bool FullScreen;

//long width = 640;
//long height = 480;
long width = 1024;
long height = 768;
long bits = 32;



void initLights(){
    // set up light colors (ambient, diffuse, specular)
    GLfloat lightKa[] = {.2f, .2f, .2f, 1.0f};  // ambient light
    GLfloat lightKd[] = {.7f, .7f, .7f, 1.0f};  // diffuse light
    GLfloat lightKs[] = {1, 1, 1, 1};           // specular light
    glLightfv(GL_LIGHT0, GL_AMBIENT, lightKa);
    glLightfv(GL_LIGHT0, GL_DIFFUSE, lightKd);
    glLightfv(GL_LIGHT0, GL_SPECULAR, lightKs);


    // position the light
    float lightPos[4] = {20, 20, 20, 1}; // positional light
    glLightfv(GL_LIGHT0, GL_POSITION, lightPos);

    glEnable(GL_LIGHT0);                        // MUST enable each light source after configuration
}


//void setCamera(float posX, float posY, float posZ, float targetX, float targetY, float targetZ){
//	glMatrixMode(GL_MODELVIEW);
//	glLoadIdentity();
//	gluLookAt(posX, posY, posZ, targetX, targetY, targetZ, 0, 1, 0); // eye(x,y,z), focal(x,y,z), up(x,y,z)
//}


void *font = GLUT_BITMAP_9_BY_15;



void initGLmode(){
	glClearColor(0, 0, 0, 0);                   // background color
//	glClearStencil(0);                          // clear stencil buffer
//	glClearDepth(1.0f);                         // 0 is near, 1 is far
//	glDepthFunc(GL_ALWAYS);

	glShadeModel(GL_SMOOTH);                    // shading mathod: GL_SMOOTH or GL_FLAT
	//glPixelStorei(GL_UNPACK_ALIGNMENT, 4);      // 4-byte pixel alignment
	
	// enable /disable features
	glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);
	glHint(GL_LINE_SMOOTH_HINT, GL_NICEST);
	glHint(GL_POINT_SMOOTH_HINT, GL_NICEST);
	glHint(GL_POLYGON_SMOOTH_HINT, GL_NICEST);
	glEnable(GL_DEPTH_TEST);
	glEnable(GL_LIGHTING);
	glEnable(GL_TEXTURE_2D);
	glEnable(GL_CULL_FACE);
	glEnable(GL_BLEND);
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA
		//GL_SOURCE_ALPHA,GL_ONE
		);

	 // track material ambient and diffuse from surface color, call it before glEnable(GL_COLOR_MATERIAL)
	glColorMaterial(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE);
	glEnable(GL_COLOR_MATERIAL);
	
	//setCamera(0, 0, 5, 0, 0, 0);
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	gluLookAt(0, 0, 5, 0, 0, 0, 0, 1, 0); // eye(x,y,z), focal(x,y,z), up(x,y,z)

	glLightModeli(GL_LIGHT_MODEL_TWO_SIDE, 1);
	glPointSize(5);
}

int FinalAge = 12;
GLuint gr = 0;

//const unsigned int items = 32768;
float ar[32768];

void drawdragon(int age, float x1, float y1, float x2, float y2, float n){
	float dx,dy,AC,cx,cy;
	
	age++;
	if (age==FinalAge){

		ar[gr  ] = x1;
		ar[gr+1] = y1;
		//ar[gr+2] = x2;
		//ar[gr+3] = y2;
		gr+=2;
		//line(x1,y1,x2,y2, form1.image3.canvas);
		//glTranslatef(x1,y1,0);
		//glutSolidCube(1);
		//glTranslatef(-x1,-y1,0);
		//glTranslatef(x2,y2,0);
		//glutSolidCube(1);
		//glTranslatef(-x2,-y2,0);
	}else{
		cx=(x2+x1)/2;
		cy=(y2+y1)/2;
		
		AC=sqrt(pow(cx-x1,2)+pow(cy-y1,2));
		dx=cx + AC * (cos(n+PI/2));
		dy=cy + AC * (sin(n+PI/2));
		drawdragon(age,x1,y1,dx,dy,n+45*0.01745329251994329576923690768489);
		drawdragon(age,x2,y2,dx,dy,n+90*0.01745329251994329576923690768489+45*0.01745329251994329576923690768489);
		
	};
}


bool initsound(){
	outlen = new int [SAMPLENUM+1];
	output = new double* [SAMPLENUM+1];
	QSP::GenerateSamples(ACTIONNUM, SAMPLENUM, REALDATA, INTDATA, CHARDATA, ACTIONS, DEST, output, outlen);
	FSOUND_File_SetCallbacks(memopen, memclose, memread, memseek, memtell);
	mod = FMUSIC_LoadSong("XMMOD", sampleloadcallback);
	if (!mod){
		return false;
	};
	FMUSIC_PlaySong(mod);
	return true;
}

///////////////////////////////////////////////////////////////////////////////
// intro section
///////////////////////////////////////////////////////////////////////////////
int stage = -3;


void drawString3D(const char *str, float pos[3], float color[4], void *font){
	glPushAttrib(GL_LIGHTING_BIT | GL_CURRENT_BIT); // lighting and color mask
	glDisable(GL_LIGHTING);     // need to disable lighting for proper text color
	
	glColor4fv(color);          // set text color
	glRasterPos3fv(pos);        // place text position
	
	// loop all characters in the string
	while(*str){
		glutBitmapCharacter(font, *str);
		++str;
	}
	
	glEnable(GL_LIGHTING);
	glPopAttrib();
}


float p;
float pos[3] = {-0.7,0,0};
float color[4] = {1,1,1,1};

void drawFirst(){
	if(STIME<5500){
	}else{
		if(STIME<12000){
				pos[0] = -15;
				pos[1] = -15;
				pos[2] = 0;
				//color[0] = 1;
				//color[1] = 1;
				//color[2] = 1;
				color[3] = 2.4-STIME/5000.0;
				drawString3D("a new trackmo", pos, color, font);

			for(GLuint i=0;i<gr;i+=2){
				glPushMatrix();
				p = (STIME-5500)*0.0032 - i/(PI*180);
				glColor3f( sin(0.3*(p )) ,0,sin( 0.3*(p-45) ) );
				glTranslatef(ar[i],ar[i+1],0);
				glutSolidCube(1);
				glPopMatrix();
			};
		}else{
			if(STIME<17400){
				pos[0] = -15;
				pos[1] = -15;
				pos[2] = 0;
				//color[0] = 1;
				//color[1] = 1;
				//color[2] = 1;
				color[3] = 2.4-(STIME-5500)/5000.0;
				drawString3D("by SCRIMERS", pos, color, font);
				
				for(GLuint i=0;i<gr;i+=2){
					glPushMatrix();
					p = (STIME-12000)*0.0032 - i/(PI*180);
					glColor3f( sin( 0.3*(p-60) ), sin(0.3*(p )),0 );
					glTranslatef(ar[i],ar[i+1],0);
					glutSolidCube(1);
					glPopMatrix();
				};
			}else{
				//for(GLuint i=0;i<STIME;i+=2){
				for(GLuint i=0;i<gr;i+=2){
					glPushMatrix();
					p = STIME*0.01 - i/(PI*180);
					glColor3f( sin(0.3*(p )) ,0,sin( 0.3*(p-45) ) );
					glTranslatef(ar[i],ar[i+1],0);
					glutSolidCube(1);
					glPopMatrix();
				};
				if(STIME>45000)stage++;
			};
		};
	};


}


void ShowLoad(){
	float pos[3] = {-0.2,0,0};
	float color[4] = {1,1,1,1};

	drawString3D("Loading...", pos, color, font);
}


void drawBulb(){
	if(STIME<119000){
		for(GLuint i=0;i<(STIME-107000);i+=2){
			glPushMatrix();
			p = (STIME)*0.1 - i/(PI*180);
			glColor3f( sin(0.02*(p )) ,0,sin( 0.01*(p-45) ) );
			glTranslatef(ar[i],ar[i+1],-2);
			glRotatef(STIME*0.1,0,1,0);
			glutSolidCube(1);
			glPopMatrix();
		};
	}else{
		stage++;
	};
}


void drawMove(){
	glRotatef(90.,0,1,0);
	glRotatef(90.,1,0,0);

	for(GLuint i=0;i<gr;i+=2){
		glPushMatrix();
		p = STIME*0.01 - i/(PI*180);
		glColor3f( sin(0.3*(p )) ,0,sin( 0.3*(p-45) ) );
		glTranslatef(ar[i],ar[i+1],-2);
		glRotatef(STIME*0.1,0,1,0);
		glutSolidCube(1);
		glPopMatrix();
		glPushMatrix();
		p = (STIME-5000)*0.01 - i/(PI*180);
		glColor3f( sin(0.3*(p )) ,0,sin( 0.3*(p-45) ) );
		glTranslatef(ar[i],ar[i+1],-10);
		glRotatef(STIME*0.1,0,1,0);
		glutSolidCube(1);
		glPopMatrix();

	};
	glTranslatef(30,0,0);
	for(GLuint i=0;i<gr;i+=2){
		glPushMatrix();
		p = (STIME-5000)*0.01 - i/(PI*180);
		glColor3f( sin(0.3*(p )) ,0,sin( 0.3*(p-45) ) );
		glTranslatef(ar[i],ar[i+1],-2);
		glRotatef(STIME*0.1,0,1,0);
		glutSolidCube(1);
		glPopMatrix();
		glPushMatrix();
		p = (STIME-5000)*0.01 - i/(PI*180);
		glColor3f( sin(0.3*(p )) ,0,sin( 0.3*(p-45) ) );
		glTranslatef(ar[i],ar[i+1],-10);
		glRotatef(STIME*0.1,0,1,0);
		glutSolidCube(1);
		glPopMatrix();
	};
	glTranslatef(30,0,0);
	for(GLuint i=0;i<gr;i+=2){
		glPushMatrix();
		p = (STIME-5000)*0.01 - i/(PI*180);
		glColor3f( sin(0.3*(p )) ,0,sin( 0.3*(p-45) ) );
		glTranslatef(ar[i],ar[i+1],-2);
		glRotatef(STIME*0.1,0,1,0);
		glutSolidCube(1);
		glPopMatrix();
		glPushMatrix();
		p = (STIME-5000)*0.01 - i/(PI*180);
		glColor3f( sin(0.3*(p )) ,0,sin( 0.3*(p-45) ) );
		glTranslatef(ar[i],ar[i+1],-10);
		glRotatef(STIME*0.1,0,1,0);
		glutSolidCube(1);
		glPopMatrix();
	};
	glTranslatef(30,0,0);
	for(GLuint i=0;i<gr;i+=2){
		glPushMatrix();
		p = (STIME-5000)*0.01 - i/(PI*180);
		glColor3f( sin(0.3*(p )) ,0,sin( 0.3*(p-45) ) );
		glTranslatef(ar[i],ar[i+1],-2);
		glRotatef(STIME*0.1,0,1,0);
		glutSolidCube(1);
		glPopMatrix();
		glPushMatrix();
		p = (STIME-5000)*0.01 - i/(PI*180);
		glColor3f( sin(0.3*(p )) ,0,sin( 0.3*(p-45) ) );
		glTranslatef(ar[i],ar[i+1],-10);
		glRotatef(STIME*0.1,0,1,0);
		glutSolidCube(1);
		glPopMatrix();
	};

}

void drawPlast(){
	for(GLuint i=0;i<gr;i+=2){
		glPushMatrix();
		p = STIME*0.01 - i/(PI*180);
		glColor3f( sin(0.3*(p )) ,0,sin( 0.3*(p-45) ) );
		glTranslatef(ar[i],ar[i+1],-ar[i+1]);
		glRotatef(STIME*0.1,0,1,0);
		glutSolidCube(1);
		glPopMatrix();
	};
}

void drawColor(){
	if(STIME<55000){
		for(GLuint i=0;i<gr;i+=2){
			glPushMatrix();
			p = STIME*0.01 - i/(PI*180);
			glColor3f( sin(0.3*(p )) ,0,sin( 0.3*(p-45) ) );
			glTranslatef(ar[i],ar[i+1],0);
			glutSolidCube(1);
			glPopMatrix();
		};
	}else{
		if(STIME<75000){
			for(GLuint i=0;i<gr;i+=2){
				glPushMatrix();
				p = STIME*0.01 - i/(PI*180);
				glColor3f( sin( 0.3*(p-60) ), sin(0.3*(p )),0 );
				glTranslatef(ar[i],ar[i+1],0);
				glutSolidCube(1);
				glPopMatrix();
			};
		}else{
			stage++;
		};
	};
}

GLfloat fogColor[4] = {0.01, 0.01, 0.01, 1.0};


void drawscene(){
	glColor3f(1,1,1);
	//glutSolidCube(1);

glPushMatrix();
glTranslatef(-3,-7,-75);

	switch(stage){
	case -3:
		ShowLoad();
		stage++; break;
	case -2:
			stage++;
			drawdragon(0,-30,-10,50,0,0);
			
			if(!initsound()){
				MessageBox(NULL, "Error music load.", "Error", MB_OK | MB_ICONERROR);
				SendMessage(hWnd,WM_CLOSE,0,0);
			};
			break;
	case -1 : 
		if(STIME//-107000
			>0)stage++;
		break;
	case 0 : 
		drawFirst(); break;
	case 1 : 
		drawColor(); break;
	case 2:
		if(STIME<90000){
			glTranslatef(5,12,-10);
			glRotatef((float)(120000-STIME)*0.01,0,1,0);
			drawPlast(); 
		}else{
			stage++;
		};
		break;
	case 3:
		glEnable(GL_FOG);
		glFogi(GL_FOG_MODE, GL_EXP);
		glFogfv(GL_FOG_COLOR, fogColor);
		glFogf(GL_FOG_DENSITY, 0.03);
		glHint(GL_FOG_HINT, GL_NICEST);
		glFogf (GL_FOG_START, 200.0);
		glFogf (GL_FOG_END, 300.0);
		stage++; break;
	case 4:
		if(STIME<107000){
				glTranslatef(0,0,(float)(STIME-90000)*0.01);
				drawMove();
			}else{
				stage++;
			};
		break;
	case 5:
		glDisable(GL_FOG); 
		stage++;break;
	case 6:
		glPushMatrix();
		//glTranslatef(-2,0,0);
			//pos[0] = 70.0-(float)(STIME - 107000)*0.03;
			pos[0] = 70.0-(float)(STIME - 107000)*0.03;
			pos[1] = -37;
			pos[2] = 0;
			//color[0] = 1;
			//color[1] = 1;
			//color[2] = 1;
			color[3] = 1;
			drawString3D("MAM, ", pos, color, font);
				pos[0] = 78.0-(float)(STIME - 107000)*0.03;
			drawString3D("Manwe, ", pos, color, font);
				pos[0] = 89.0-(float)(STIME - 107000)*0.03;
			drawString3D("Preston, ", pos, color, font);
				pos[0] = 104.0-(float)(STIME - 107000)*0.03;
			drawString3D("B!TL, ", pos, color, font);
				pos[0] = 113.0-(float)(STIME - 107000)*0.03;
			drawString3D("Ized, ", pos, color, font);
				pos[0] = 123.0-(float)(STIME - 107000)*0.03;
			drawString3D("NightRadio, ", pos, color, font);
				pos[0] = 143.0-(float)(STIME - 107000)*0.03;
			drawString3D("tone, ", pos, color, font);
				pos[0] = 153.0-(float)(STIME - 107000)*0.03;
			drawString3D("Lyzzard, ", pos, color, font);
				pos[0] = 168.0-(float)(STIME - 107000)*0.03;
			drawString3D("Dimouse, ", pos, color, font);
				pos[0] = 183.0-(float)(STIME - 107000)*0.03;
			drawString3D("xiod, ", pos, color, font);
				pos[0] = 193.0-(float)(STIME - 107000)*0.03;
			drawString3D("unc, ", pos, color, font);
				pos[0] = 201.0-(float)(STIME - 107000)*0.03;
			drawString3D("Vinnny, ", pos, color, font);
				pos[0] = 214.0-(float)(STIME - 107000)*0.03;
			drawString3D("fox, ", pos, color, font);
				pos[0] = 222.0-(float)(STIME - 107000)*0.03;
			color[3] = 2.4-(float)((float)STIME-117500)*0.002;

			drawString3D("phantom lord, ", pos, color, font);
				pos[0] = 245.50-(float)(STIME - 107000)*0.03;
			drawString3D("f1af, ", pos, color, font);
				pos[0] = 255.0-(float)(STIME - 107000)*0.03;
			drawString3D("Valet2, ", pos, color, font);
				pos[0] = 268.0-(float)(STIME - 107000)*0.03;
			drawString3D("Icefall, ", pos, color, font);
				pos[0] = 283.0-(float)(STIME - 107000)*0.03;
			drawString3D("KASik, ",pos, color, font);
				pos[0] = 295.0-(float)(STIME - 107000)*0.03;
			drawString3D("Darkman, ", pos, color, font);
				pos[0] = 310.0-(float)(STIME - 107000)*0.03;
			drawString3D("tmk79, ", pos, color, font);
				pos[0] = 321.50-(float)(STIME - 107000)*0.03;
			drawString3D("random, ", pos, color, font);
				pos[0] = 335.0-(float)(STIME - 107000)*0.03;
			drawString3D("Zuf, ", pos, color, font);
				pos[0] = 343.0-(float)(STIME - 107000)*0.03;
			drawString3D("Silent ", pos, color, font);
				pos[0] = 357.0-(float)(STIME - 107000)*0.03;
			drawString3D("and ", pos, color, font);
				pos[0] = 365.0-(float)(STIME - 107000)*0.03;
			//drawString3D("all, ", pos, color, font);
			//	pos[0] = 373.0-(float)(STIME - 107000)*0.03;
			//drawString3D("all, ", pos, color, font);
			//	pos[0] = 385.0-(float)(STIME - 107000)*0.03;
			drawString3D("all...", pos, color, font);


//			drawString3D("MAM, Manwe, Preston, B!TL, Ized, NightRadio, tone, Lyzzard, Dimouse, xiod, unc, Vinnny, fox, phantom lord, f1af, Valet2, Icefall, KASik_KACuk, Darkman, tmk79, random, Zuf, Silent and all, all, all", pos, color, font);
		glPopMatrix();

		drawBulb(); 
		
		
		break;
	case 7:
		glEnable(GL_FOG);
		glFogi(GL_FOG_MODE, GL_EXP);
		glFogfv(GL_FOG_COLOR, fogColor);
		glFogf(GL_FOG_DENSITY, 0.03);
		glHint(GL_FOG_HINT, GL_NICEST);
		glFogf (GL_FOG_START, 200.0);
		glFogf (GL_FOG_END, 300.0);
		stage++; break;
	case 8:
		if(STIME<143500){
				glTranslatef(0,0,(float)(STIME-119000)*0.008-10);
				drawMove();
			}else{
				stage++;
			};
		break;
	case 9:
		glDisable(GL_FOG); 
		stage++;break;
	case 10:
		if(STIME<157000){
			glTranslatef(5,12,-10);
			glRotatef((float)(STIME)*0.01,1,1,0);
			drawPlast(); 
		}else{
			stage++;
		};
		break;
	case 11:
		SendMessage(hWnd,WM_CLOSE,0,0);
		break;

	};

	//glLineWidth(1);
	//glDisable(GL_LIGHTING);
	//glBegin(GL_LINES);
	//glColor3f(1,0,0);
	//	glVertex3f(0,0,0);
	//	glVertex3f(10,0,0);
	//glColor3f(0,1,0);
	//	glVertex3f(0,0,0);
	//	glVertex3f(0,10,0);
	//glColor3f(0,0,1);
	//	glVertex3f(0,0,0);
	//	glVertex3f(0,0,10);
	//glColor3f(1,0,0);
	//	glVertex3f(xp,yp,0);
	//	glVertex3f(xp+0.3,yp+0.5,0);
	//	glVertex3f(xp,yp,0);
	//	glVertex3f(xp+0.3,yp+0.3,0);
	//	glVertex3f(xp+0.3,yp+0.3,0);
	//	glVertex3f(xp+0.3,yp+0.5,0);
	//glEnd();
	//glEnable(GL_LIGHTING);

glPopMatrix();

STIME = FMUSIC_GetTime(mod)//+107000
	;
//sprintf(buffer,"time=%d   [] %d %d",STIME,stage, gr);
//SetWindowText(hWnd,buffer);
}

///////////////////////////////////////////////////////////////////////////////
// main section
///////////////////////////////////////////////////////////////////////////////
bool keys[256];
//FILE *fp;

LRESULT CALLBACK WindowFunc(HWND hWnd,UINT msg,WPARAM wParam,LPARAM lParam){
	switch(msg){
		case WM_CREATE:	
			hDC = GetDC(hWnd);
			int m_GLPixelIndex;
			PIXELFORMATDESCRIPTOR pfd;
			pfd.nSize       = sizeof(PIXELFORMATDESCRIPTOR);
			pfd.nVersion    = 1;
			pfd.dwFlags   = PFD_DRAW_TO_WINDOW | PFD_SUPPORT_OPENGL | PFD_DOUBLEBUFFER;
			pfd.iPixelType     = PFD_TYPE_RGBA;
			pfd.cColorBits     = 32;
			pfd.cRedBits       = 8;
			pfd.cRedShift      = 16;
			pfd.cGreenBits     = 8;
			pfd.cGreenShift    = 8;
			pfd.cBlueBits      = 8;
			pfd.cBlueShift     = 0;
			pfd.cAlphaBits     = 0;
			pfd.cAlphaShift    = 0;
			pfd.cAccumBits     = 64;
			pfd.cAccumRedBits  = 16;
			pfd.cAccumGreenBits   = 16;
			pfd.cAccumBlueBits    = 16;
			pfd.cAccumAlphaBits   = 0;
			pfd.cDepthBits        = 32;
			pfd.cStencilBits      = 8;
			pfd.cAuxBuffers       = 0;
			pfd.iLayerType        = PFD_MAIN_PLANE;
			pfd.bReserved         = 0;
			pfd.dwLayerMask       = 0;
			pfd.dwVisibleMask     = 0;
			pfd.dwDamageMask      = 0;
			m_GLPixelIndex = ChoosePixelFormat( hDC, &pfd);

			if(m_GLPixelIndex==0){
			 m_GLPixelIndex = 1;
			 DescribePixelFormat(hDC,m_GLPixelIndex,sizeof(PIXELFORMATDESCRIPTOR),&pfd)  ;
			};

			// инициализация OpenGL тут
			SetPixelFormat( hDC, m_GLPixelIndex, &pfd);
			hGLRC = wglCreateContext(hDC);
			wglMakeCurrent(hDC, hGLRC);


			initGLmode();
			initLights();
			SwapBuffers(hDC);
		break;
		case WM_DESTROY:
			FMUSIC_StopSong(mod);
			//FMUSIC_FreeSong(mod);

			if (FullScreen){             // Change back to non fullscreen
				ChangeDisplaySettings((DEVMODE *)NULL, 0);
			};
			ShowCursor(true);

			if (hGLRC){
				wglMakeCurrent(NULL, NULL);
				wglDeleteContext(hGLRC);
			}
			ReleaseDC(hWnd, hDC);
			PostQuitMessage(0);
		break;
  
		case WM_PAINT:
			glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );

			drawscene();

			SwapBuffers(hDC);
		break;
		case WM_SIZE:
			glViewport(0, 0, LOWORD(lParam), HIWORD(lParam));
			glMatrixMode(GL_PROJECTION);
			glLoadIdentity();
			gluPerspective(60.0f, (float)LOWORD(lParam)/HIWORD(lParam), 1.0f, 1000.0f); // FOV, AspectRatio, NearClip, FarClip
			glMatrixMode(GL_MODELVIEW);
		break;
		case WM_KEYDOWN:
			keys[wParam] = TRUE;
		break;
		case WM_KEYUP:
			if (keys[27])// DestroyWindow(hWnd);
				SendMessage(hWnd,WM_CLOSE,0,0);
			keys[wParam] = FALSE;
		break;
		default: // если пришло ненужное нам сообщение возвращаем его системе
			return DefWindowProc(hWnd,msg,wParam,lParam);
	}
	return 0;
}

#ifdef _DEBUG
	int WINAPI WinMain(HINSTANCE hInstance,HINSTANCE hPrevInstance,LPSTR lpCmdLine,int nCmdShow)
#else
	//int WinMainCRTStartup()
	int ENTRY_Main()
#endif
{
	MSG msg;

	FullScreen = false;
	if(MessageBox(NULL, "1024x768 fullscreen?.", "SCRIMERS Starcube-Trackmo", MB_YESNO | MB_ICONQUESTION)==IDYES){
		FullScreen = true;
	};
	
#ifdef _DEBUG
#else
    HINSTANCE	hInstance;				// Holds The Instance Of The Application
#endif



    WNDCLASS	wc;						// Windows Class Structure
    DWORD		dwExStyle;				// Window Extended Style
    DWORD		dwStyle;				// Window Style
    RECT		WindowRect;				// Grabs Rectangle Upper Left / Lower Right Values
    WindowRect.left=(long)0;			// Set Left Value To 0
    WindowRect.right=(long)width;		// Set Right Value To Requested Width
    WindowRect.top=(long)0;				// Set Top Value To 0
    WindowRect.bottom=(long)height;		// Set Bottom Value To Requested Height


    hInstance			= GetModuleHandle(NULL);				// Grab An Instance For Our Window
    wc.style			= CS_HREDRAW | CS_VREDRAW | CS_OWNDC;	// Redraw On Size, And Own DC For Window.
    wc.lpfnWndProc		= (WNDPROC) WindowFunc;					// WndProc Handles Messages
    wc.cbClsExtra		= 0;									// No Extra Window Data
    wc.cbWndExtra		= 0;									// No Extra Window Data
    wc.hInstance		= hInstance;							// Set The Instance
    wc.hIcon			= LoadIcon(NULL, IDI_WINLOGO);			// Load The Default Icon
    wc.hCursor			= LoadCursor(NULL, IDC_ARROW);			// Load The Arrow Pointer
    wc.hbrBackground	= NULL;									// No Background Required For GL
    wc.lpszMenuName		= NULL;									// We Don't Want A Menu
    wc.lpszClassName	= "OpenGL";								// Set The Class Name

    if (!RegisterClass(&wc)){									// Attempt To Register The Window Class
    	MessageBox(NULL,"Failed To Register The Window Class.","ERROR",MB_OK|MB_ICONEXCLAMATION);
    	return FALSE;											// Return FALSE
    }

    if (FullScreen){												// Attempt Fullscreen Mode?
    	DEVMODE dmScreenSettings;								// Device Mode
    	memset(&dmScreenSettings,0,sizeof(dmScreenSettings));	// Makes Sure Memory's Cleared
    	dmScreenSettings.dmSize=sizeof(dmScreenSettings);		// Size Of The Devmode Structure
    	dmScreenSettings.dmPelsWidth	= width;				// Selected Screen Width
    	dmScreenSettings.dmPelsHeight	= height;				// Selected Screen Height
    	dmScreenSettings.dmBitsPerPel	= bits;					// Selected Bits Per Pixel
    	dmScreenSettings.dmFields=DM_BITSPERPEL|DM_PELSWIDTH|DM_PELSHEIGHT;

    	// Try To Set Selected Mode And Get Results.  NOTE: CDS_FULLSCREEN Gets Rid Of Start Bar.
    	if (ChangeDisplaySettings(&dmScreenSettings,CDS_FULLSCREEN)!=DISP_CHANGE_SUCCESSFUL){
    		// If The Mode Fails, Offer Two Options.  Quit Or Use Windowed Mode.
    		if (MessageBox(NULL,"The Requested Fullscreen Mode Is Not Supported By\nYour Video Card. Use Windowed Mode Instead?","NeHe GL",MB_YESNO|MB_ICONEXCLAMATION)==IDYES){
    			FullScreen=FALSE;		// Windowed Mode Selected.  Fullscreen = FALSE
    		}else{
    			// Pop Up A Message Box Letting User Know The Program Is Closing.
    			MessageBox(NULL,"Program Will Now Close.","ERROR",MB_OK|MB_ICONSTOP);
    			return FALSE;									// Return FALSE
    		}
    	}
    }

    if (FullScreen){											// Are We Still In Fullscreen Mode?
    	dwExStyle=WS_EX_APPWINDOW;								// Window Extended Style
    	dwStyle=WS_POPUP | WS_CLIPSIBLINGS | WS_CLIPCHILDREN;	// Windows Style
    	ShowCursor(FALSE);										// Hide Mouse Pointer
    }else{
    	dwExStyle=WS_EX_APPWINDOW | WS_EX_WINDOWEDGE;						// Window Extended Style
    	dwStyle=WS_POPUP | WS_CLIPSIBLINGS | WS_CLIPCHILDREN;	// Windows Style
    }

    AdjustWindowRectEx(&WindowRect, dwStyle, FALSE, dwExStyle);		// Adjust Window To True Requested Size

    // Create The Window
    if (!(hWnd=CreateWindowEx(	dwExStyle,							// Extended Style For The Window
    							"OpenGL",							// Class Name
    							"SCRIMERS Starcube-Trackmo",		// Window Title
    							dwStyle |							// Defined Window Style
    							WS_CLIPSIBLINGS |					// Required Window Style
    							WS_CLIPCHILDREN,					// Required Window Style
    							0, 0,								// Window Position
    							WindowRect.right-WindowRect.left,	// Calculate Window Width
    							WindowRect.bottom-WindowRect.top,	// Calculate Window Height
    							NULL,								// No Parent Window
    							NULL,								// No Menu
    							hInstance,							// Instance
    							NULL)))								// Dont Pass Anything To WM_CREATE
    {
    	
    	MessageBox(NULL,"Window Creation Error.","ERROR",MB_OK|MB_ICONEXCLAMATION);
    	return FALSE;								// Return FALSE
    }

	ShowWindow(hWnd, 1);
	UpdateWindow(hWnd);
	ShowCursor(false);

	SetForegroundWindow(hWnd);
	SetFocus(hWnd);

	while(GetMessage(&msg,NULL,0,0)){
	   TranslateMessage(&msg);
	   DispatchMessage(&msg);
	}

	ExitProcess(0);
}


