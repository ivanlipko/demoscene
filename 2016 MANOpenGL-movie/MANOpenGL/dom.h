#ifndef _DOM_H

#define _DOM_H

#include <windows.h> // чтобы OpenGL не матерился на отсутствие констант

// Enable usage of OpenGL
#include "gl/gl.h"
#include "glut/glut.h"
#include "egl/glext.h"

#include <time.h>
#include <math.h>

struct Salut {
	float posX, posY;
	float startX, startY;
	float endX, endY;
	float timeX, timeY;
	float colorR, colorG, colorB;
};
extern Salut salut[250];

struct XandY
{
	float x, y;
};
extern XandY StaticStarArray[500];
extern XandY DinamicStarArray[500];
extern XandY Sputnik;

extern int sign, currentTimeTree;

extern time_t start_time;

extern bool Init_Salut, isInitDinamicStarRandom, isInitStaticStarRandom, trigger;

void initParticle();
void RGBColor3f(float red, float green, float blue, float alpha = 255);
void InitDinamicStarRandom();
void InitStaticStarRandom();
void InitTimeDom();
void DLine(float PositionX1, float PositionY1, float PositionX2, float PositionY2, GLfloat Width = 2);
void DTriangleFree(float PosX1, float PosY1, float PosX2, float PosY2, float PosX3, float PosY3);
float AnimatePosition(float start_point, float end_point, float time_lenght);

void DCubeDiagonal(float PosX1, float PosY1, float PosX2, float PosY2);

void drawShariki();
void drawDom();
void drawSputnik();

#endif