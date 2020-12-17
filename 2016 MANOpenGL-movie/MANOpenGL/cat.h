#ifndef _CAT_H

#define _CAT_H


#include <windows.h> // чтобы OpenGL не матерился на отсутствие констант

// Enable usage of OpenGL
#include "gl/gl.h"
#include "glut/glut.h"
#include "egl/glext.h"


extern float yCat, yCatTail, yCatRainbow, startTimeCat, startTimeCatTail, startTimeCatRainbow, allTimeCatTail, allTimeCat, allTimeCatRainbow, xMain, startTimeCatMain;
extern int button;
extern int set;


void drawSqr(float x1, float y1, float x2, float y2);
void drawPoint(float x1, float y1);
void drawLine(float x1, float y1, float x2, float y2);
void drawQuad(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4);
void drawNYAN();
void initCat();


#endif