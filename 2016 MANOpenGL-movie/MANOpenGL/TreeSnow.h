#ifndef _TREESNOW_H

#define _TREESNOW_H


#include <windows.h> 

#include "gl/gl.h"
#include "glut/glut.h"
#include "egl/glext.h"

#include "time.h"

const short snowCount = 250;

struct Snow {
	float posX,posY;
	float startX, startY;
	float endX,endY;
	float timeX,timeY;
	float startColor[4];
	float color[4];
	float endColor[4];
	float colorTime;
	float timeStart;
};

extern Snow snow[snowCount];

struct Tree {
	float pos;
	float endColor[4];
	struct Part{
		float color[4];
		float startColor[4];
		float colorTime;
		float timeStart;
	} part[3];
};

extern Tree tree[8];

//struct Snow {
//	float posX, posY;
//	float timeX, timeY;
//	float startColor[4];
//	float color[4];
//	float endColor[4];
//	float colorTime;
//	float timeStart;
//};
//
//extern Snow snow[1];

void initTreeSnow();
void drawStaticElki(float pos);
void drawGround();

extern time_t startTimeSnow;


#endif

