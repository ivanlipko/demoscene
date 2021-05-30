/*
��������� ���������:
	1. ���� ��������, ��� float timeX,timeY; � struct Salut ����� ����������.
	2. ��� ������� ��������� � ��� �� ����� - ��� ���������, ����� �� �����. ��� �����, ���� ��� ����� ��������� � ������ ������.
*/

#ifndef _SUPERSDK_H

#define _SUPERSDK_H


#include <windows.h> // ����� OpenGL �� ��������� �� ���������� ��������

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
	// ��� ������� 
	float startColor[4];
	float color[4];
	float endColor[4];
	float colorTime;
	// ��� �����
	float timeStart;
};

extern Salut salut[salutCount];

void init();
void drawTree(float dx);



#endif

