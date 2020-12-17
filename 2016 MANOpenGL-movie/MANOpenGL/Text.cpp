#include "Text.h"
#include "math.h"
#include <time.h>

float button = 1, startTimeText, trig=1, TimeT;
GLfloat startAlphaT, endAlphaT, alphaT;

void InitText(){
	if (button == 1){
		button = 2;

		startTimeText = GetTickCount();

		startAlphaT = 0;
		endAlphaT = 1;
		alphaT=0;
		TimeT = 7000;
	}
}

void Textout(char* str, int x, int y, GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha){
	glColor4f(.8, .1, 0, alpha);
	glRasterPos2f(x, y);
	int i = 0;
	while (str[i] != '\0')
	{
		glutBitmapCharacter(GLUT_BITMAP_9_BY_15, str[i]);
		i++;
		glRasterPos2f(x + i*1.5, y);

	}
}

void writeText() {
	if (alphaT >= endAlphaT){
		trig = 2;
	}

	if (trig == 1){
		alphaT = startAlphaT + (endAlphaT - startAlphaT)*((float)(GetTickCount() - startTimeText) / TimeT);
	}
	else{
		if (GetTickCount() >= startTimeText + 10000){
			alphaT = endAlphaT + (startAlphaT - endAlphaT)*((float)(GetTickCount() - (startTimeText + 10000)) / TimeT);
		}
		if (alphaT<=0){
			alphaT = 0;
		}
	}

	Textout("Dima Zhukov", 0, 0, 0.8, 0.1, 0, alphaT);
	Textout("Denis Zhukov", 0, -3, 0.8, 0.1, 0, alphaT);
	Textout("Ilyha Poluyktov", 0, -6, 0.8, 0.1, 0, alphaT);
	Textout("Nastya Kibalova", 0, -9, 0.8, 0.1, 0, alphaT);
	Textout("Valeriya Pegushina", 0, -12, 0.8, 0.1, 0, alphaT);
}