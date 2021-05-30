/*
Возможные улучшения:
	1. Было замечено, что float timeX,timeY; в struct Salut можно объединить.
	2. Ещё частицы рождаются в том же месте - это незаметно, когда их много. Что будет, если они будут рождаться в разных местах.
*/

#ifndef _SUPERSDK_H

#define _SUPERSDK_H


#include <windows.h> // чтобы OpenGL не матерился на отсутствие констант

// Enable usage of OpenGL
#include "gl/gl.h"
#include "glut/glut.h"
#include "egl/glext.h"

#include "time.h"

const short salutCount = 250;

struct Salut {
	float posX,posY;
	float startX, startY;
	float endX,endY;
	float timeX,timeY;
	// для красоты 
	float startColor[4];
	float color[4];
	float endColor[4];
	float colorTime;
	// для цикла
	float timeStart;
};

extern Salut salut[salutCount];

void init();
void drawTree(float dx);



#endif

