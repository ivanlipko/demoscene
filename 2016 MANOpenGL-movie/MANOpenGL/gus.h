#ifndef _GUS_H

#define _GUS_H


#include <windows.h> // чтобы OpenGL не матерился на отсутствие констант

// Enable usage of OpenGL
#include "gl/gl.h"
#include "glut/glut.h"
#include "egl/glext.h"

#include <time.h>
#include <math.h>

extern unsigned int startTimeGus;
extern int sign1;
extern float SmezhX;

void initGus();
//Нарисуй куб (использовать 2 кооардинаты)
void drawCoube2(float PositionXleft, float PositionYleft, float PositionXright, float PositionYright);
//Нарисуй круг
void drawCirce(float PositionX, float PositionY, float Radius, int AmountSegments, GLfloat Width );
//Нарисуй усы(гусеницы)
void drawusy(float PositionX, float PositionY, float Radius, int AmountSegments, GLfloat Width);
//Color RGB (4 переменной водить прозрачность значение в проценах)
void ColorRGB(float Red, float Grey, float Blye, float alpha);
//Нарисуй шахмотную доску (x,y,колличество ячеек,ширина ячеек)
void drawchess(float ax, float ay, float p, float shyrina);

void drawHeadGus(float xh , float yh );

void draw1Gus(float x1 , float y1 );
void draw2Gus(float x2 , float y2 );
void draw3Gus(float x3 , float y3 );
void draw4Gus(float x4 , float y4 );
void drawGive(float x = 15, float y = 0);


#endif