#include "tree.h"
#include "time.h"

 SalutTree salutTree[salutCountTree];

 void drawPixel(float sizePixel, float col1, float col2, float col3, float dx1, float dy1)
{
	
	glEnable(GL_POINT_SMOOTH);
	glPointSize(sizePixel);
	glBegin(GL_POINTS);
	glColor3f(col1, col2, col3);
	glVertex2f(dx1, dy1);
	glEnd();
	return;
}
 
void drawLine(float col1, float col2, float col3, float dx1, float dy1, float dx2, float dy2)
{
	glBegin(GL_LINES);
	glColor3f(col1, col2, col3);
	glVertex2f(dx1, dy1);
	glVertex2f(dx2, dy2);
	glEnd();
	return;
}


float koord;
void DrawK() {
	/*float koord;
	koord = (float)rand() / RAND_MAX;
	koord = koord *10;*/
	glBegin(GL_QUADS);
	glColor3f(1, 1, 1);
	glVertex2f(1 + koord, 1 + koord);
	glVertex2f(5 + koord, 1 + koord);
	glVertex2f(5 + koord, 5 + koord);
	glVertex2f(1 + koord, 5 + koord);
	glEnd();
	return;
}


int trigger = 0;
int currentTimeTree = GetTickCount();
//int startTime;

void initTree(){
	if (trigger == 0){
		srand(time(NULL));
		int startTime = GetTickCount();

		for (int i = 0; i < salutCountTree; i++){
			salutTree[i].trig = true;
			salutTree[i].startX = 10 *(float)rand() / RAND_MAX;
			salutTree[i].startY = 15 *(float)rand() / RAND_MAX;
			salutTree[i].posX = salutTree[i].startX;
			salutTree[i].posY = salutTree[i].startY;
			salutTree[i].endX = /*11 * (float)rand() / RAND_MAX;*/ salutTree[i].startX;
			salutTree[i].endY = /*10 + 10 * (float)rand() / RAND_MAX*/-10;
			salutTree[i].timeX = 5000;
			salutTree[i].timeY = 5000;

			salutTree[i].startCol[0] =-0.1-0.3*(float)rand() / RAND_MAX;
			salutTree[i].startCol[1] =0.6 + 0.2*(float)rand() / RAND_MAX;
			salutTree[i].startCol[2] = 0.1 /*+ 0.1*(float)rand() / RAND_MAX;*/;
		/*	salutTree[i].startCol[3] = 0.9 + 0.3*(float)rand() / RAND_MAX;*/

			salutTree[i].Col[0] = 0;
			salutTree[i].Col[1] = 0;
			salutTree[i].Col[2] = 0;
			salutTree[i].Col[3] = 1;

			salutTree[i].endCol[0] = 0.8+ 30*(float)rand() / RAND_MAX;
			salutTree[i].endCol[1] = 0.5 + 0.5*(float)rand() / RAND_MAX;
			salutTree[i].endCol[2] = 0.1 /*+ 0.4*(float)rand() / RAND_MAX*/;
			/*salutTree[i].endCol[3] = 0;*/
			salutTree[i].colorTime = 20000;

			//
			///*koord = (float)rand() / RAND_MAX * 10;*/
			/*salutTree[i].timeStart = startTime+(int)(15000 * (float)rand() / RAND_MAX);*/
			//
			salutTree[i].timeStart = startTime+4000;
			
		}

		glPointSize(10);
		glEnable(GL_POINT_SMOOTH);  

		
		
		
		trigger++;
	}
	
	return;
}