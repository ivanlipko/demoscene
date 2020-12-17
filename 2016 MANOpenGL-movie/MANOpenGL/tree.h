#ifndef _TREE_H
#define _TREE_H

#include "time.h"
#include <Windows.h>
#include <gl\gl.h>

const short salutCountTree = 150;
struct SalutTree{
	float posX, posY;
	float startX, startY;
	float endX, endY;
	float timeX, timeY;

	float startCol[4];
	float Col[4];
	float endCol[4];
	float colorTime;
	
	bool trig;
	 
	float timeStart, timeStartPos;
};
extern SalutTree salutTree[salutCountTree];


void drawPixel(float sizePixel, float col1, float col2, float col3, float dx1, float dy1);

void drawLine(float col1, float col2, float col3, float dx1, float dy1, float dx2, float dy2);

extern int startTime;

void DrawK();


void initTree();
#endif

	