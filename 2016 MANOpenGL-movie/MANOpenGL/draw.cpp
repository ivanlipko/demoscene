#include "draw.h"
#include <math.h>
#include <time.h>
#include "Text.h"
#include "cat.h"
#include "gus.h"
#include "dom.h"
#include "tree.h"
#include "TreeSnow.h"

int startTime, trig=1;
time_t moveStartTime = GetTickCount(), startTimeScene = GetTickCount()+20000;

void drawScene() {

	initParticle();
	InitStaticStarRandom();


	unsigned int currentCat = GetTickCount();
	unsigned int currentCatTail = GetTickCount();
	unsigned int currentCatRainbow = GetTickCount();
	unsigned int currentCatMain = GetTickCount();

	unsigned int currentTimeFilm = GetTickCount();
	unsigned int currentTime = GetTickCount();



	float time_lenght = 1700;

	if (currentTimeFilm < moveStartTime + time_lenght * 9 + 20000){

		float point_end = 20;
		float time_end = 1;
		float time_lenght_Head = 1500;

		float t = 0;

		drawGround();
		drawStaticElki(-60);
		drawStaticElki(-45);
		drawStaticElki(-30);
		drawStaticElki(-15);
		drawStaticElki(15);
		drawStaticElki(30);
		drawStaticElki(45);
		drawStaticElki(60);

		if (startTimeScene <= GetTickCount()){

			initTreeSnow();

			//Изменение цвета и позиций снежинок
			for (int i = 0; i < snowCount; i++) {
				snow[i].posX = snow[i].startX + (snow[i].endX - snow[i].startX) * ((float)(GetTickCount() - snow[i].timeStart) / snow[i].timeX);
				snow[i].posY = snow[i].startY + (snow[i].endY - snow[i].startY) * ((float)(GetTickCount() - snow[i].timeStart) / snow[i].timeY);

				snow[i].color[0] = snow[i].startColor[0] + (snow[i].endColor[0] - snow[i].startColor[0]) * ((float)(GetTickCount() - snow[i].timeStart) / snow[i].colorTime);
				snow[i].color[1] = snow[i].startColor[1] + (snow[i].endColor[1] - snow[i].startColor[1]) * ((float)(GetTickCount() - snow[i].timeStart) / snow[i].colorTime);
				snow[i].color[2] = snow[i].startColor[2] + (snow[i].endColor[2] - snow[i].startColor[2]) * ((float)(GetTickCount() - snow[i].timeStart) / snow[i].colorTime);
				snow[i].color[3] = snow[i].startColor[3] + (snow[i].endColor[3] - snow[i].startColor[3]) * ((float)(GetTickCount() - snow[i].timeStart) / snow[i].colorTime);

				if (snow[i].color[3] < 0) {
					snow[i].timeStart = GetTickCount();
				}
			}

			//Прорисовка снега
			glBegin(GL_POINTS);
			for (int i = 0; i < snowCount; i++){
				if (snow[i].timeStart <= GetTickCount()){
					glColor4fv(snow[i].color);

					if (snow[i].posY > -1) {
						glVertex2f(snow[i].posX, snow[i].posY);
					}
					else {
					}
				}
			}
			glEnd();

			//Изменение цвета для частей елок
			for (int i = 0; i < 8; i++) {
				for (int j = 0; j < 3; j++){
					tree[i].part[j].color[0] = tree[i].part[j].startColor[0] + (tree[i].endColor[0] - tree[i].part[j].startColor[0]) * ((float)(GetTickCount() - tree[i].part[j].timeStart) / tree[i].part[0].colorTime);
					tree[i].part[j].color[1] = tree[i].part[j].startColor[1] + (tree[i].endColor[1] - tree[i].part[j].startColor[1]) * ((float)(GetTickCount() - tree[i].part[j].timeStart) / tree[i].part[2].colorTime);
					tree[i].part[j].color[2] = tree[i].part[j].startColor[2] + (tree[i].endColor[2] - tree[i].part[j].startColor[2]) * ((float)(GetTickCount() - tree[i].part[j].timeStart) / tree[i].part[1].colorTime);
					tree[i].part[j].color[3] = 1.1;
				}
			}

			//Прорисовка елок
			glBegin(GL_TRIANGLES);
			for (int i = 0; i < 8; i++){
				glColor3f(.8, .5, .3);
				glVertex2f(3 + tree[i].pos, -3);
				glVertex2f(9 + tree[i].pos, -3);
				glVertex2f(3 + tree[i].pos, 3);

				glVertex2f(9 + tree[i].pos, -3);
				glVertex2f(9 + tree[i].pos, 1.5);
				glVertex2f(3 + tree[i].pos, 3);

				glColor4fv(tree[i].part[0].color);
				glVertex2f(-3 + tree[i].pos, 1.5);
				glVertex2f(15 + tree[i].pos, 1.5);
				glVertex2f(6 + tree[i].pos, 9);

				glColor4fv(tree[i].part[1].color);
				glVertex2f(tree[i].pos, 6);
				glVertex2f(12 + tree[i].pos, 6);
				glVertex2f(6 + tree[i].pos, 15);

				glColor4fv(tree[i].part[2].color);
				glVertex2f(3 + tree[i].pos, 12);
				glVertex2f(9 + tree[i].pos, 12);
				glVertex2f(6 + tree[i].pos, 16.5);

			}
			glEnd();
		}

		initTree();
		glLineWidth(50);
		glBegin(GL_LINES);
		glColor3f(0.5, 0.3, 0.1);
		glVertex2f(5, -5);
		glVertex2f(5, 5);
		glEnd();

		glLineWidth(3);
		glBegin(GL_LINES);
		glVertex2f(5, 5);
		glVertex2f(7, 12);

		glVertex2f(5.8, 7.5);
		glVertex2f(9, 10);

		glVertex2f(4.5, 5);
		glVertex2f(3, 11);

		glVertex2f(4.8, 5);
		glVertex2f(4.8, 13);

		glVertex2f(5.5, 4);
		glVertex2f(10, 6);

		glVertex2f(5, 4.6);
		glVertex2f(9, 7);

		glVertex2f(5.5, 2);
		glVertex2f(10, 4);

		glVertex2f(5.5, 0);
		glVertex2f(8, 1.5);

		glVertex2f(5.5, -0.5);
		glVertex2f(7, 0);

		glVertex2f(4.5, 2);
		glVertex2f(0.5, 4);

		glVertex2f(4.5, -0.5);
		glVertex2f(2.5, 0);

		glVertex2f(4.5, 0);
		glVertex2f(1.8, 1.5);

		glVertex2f(4.5, 4.6);
		glVertex2f(1, 7);

		glVertex2f(4.5, 4);
		glVertex2f(1.1, 6);
		glEnd();

		glBegin(GL_POINTS);

		for (int i = 0; i < salutCountTree; i++){

			if (salutTree[i].Col[0] > 0.9) {
				if (salutTree[i].trig){
					salutTree[i].timeStartPos = GetTickCount();
					salutTree[i].trig = false;
				}

				if (salutTree[i].posY <= salutTree[i].endY){

					salutTree[i].posY = salutTree[i].endY;
				}
				else {
					salutTree[i].posX = salutTree[i].startX + (salutTree[i].endX - salutTree[i].startX)*((float)(GetTickCount() - salutTree[i].timeStartPos) / salutTree[i].timeX);
					salutTree[i].posY = salutTree[i].startY + (salutTree[i].endY - salutTree[i].startY)*((float)(GetTickCount() - salutTree[i].timeStartPos) / salutTree[i].timeY);
				}
			}
			else{
				salutTree[i].Col[0] = salutTree[i].startCol[0] + (salutTree[i].endCol[0] - salutTree[i].startCol[0]) * ((float)(GetTickCount() - salutTree[i].timeStart) / salutTree[i].colorTime);
				salutTree[i].Col[1] = salutTree[i].startCol[1] + (salutTree[i].endCol[1] - salutTree[i].startCol[1]) * ((float)(GetTickCount() - salutTree[i].timeStart) / salutTree[i].colorTime);
				salutTree[i].Col[2] = salutTree[i].startCol[2] + (salutTree[i].endCol[2] - salutTree[i].startCol[2]) * ((float)(GetTickCount() - salutTree[i].timeStart) / salutTree[i].colorTime);
			}

			glColor4fv(salutTree[i].Col);
			glVertex2f(salutTree[i].posX, salutTree[i].posY);
		}

		glEnd();

		//-- End of tree animaation --\\

		if (currentTimeFilm > moveStartTime + 20000){

			initGus();

			glTranslatef(-20, -12, 0);
			drawGive();

			float time_result = currentTime - startTimeGus;
			float	x1 = (0 + (16 + 0) * (time_result / time_lenght_Head));
			float	x = (0 + (5 + 0) * (time_result / time_lenght_Head));
			float	y = (0 + (5 + 0) * (time_result / time_lenght_Head));

			glTranslatef(0, -10, 0);

			drawHeadGus((2 * sin(x + 1.57)) + x1, 0);
			draw4Gus((3 * sin(x + 1.57) - 2) + x1, 2 * sin(y));
			draw3Gus((5 * sin(x - 0.1 + 1.57) - 3) + x1, 3 * sin(y));
			draw2Gus((4 * sin(x - 0.2 + 1.57) - 2) + x1, 2 * sin(y));
			draw1Gus((4 * sin(x + 1.57) - 3) + x1, 0);
			glTranslatef(20, 12, 0);
		}

	}
	else{
		if (currentTimeFilm < moveStartTime + time_lenght * 8 + 75000){

			InitTimeDom();

			glDisable(GL_POINT_SMOOTH);

			glBegin(GL_QUADS);
			glColor3f(0, .1, .2);
			glVertex2f(-60, -60);
			glColor3f(0, .1, .2);
			glVertex2f(60, -60);
			RGBColor3f(0, 0, 0);
			glVertex2f(60, 60);
			glColor3f(0, .1, .2);
			glVertex2f(-60, 60);
			glEnd();

			for (int i = 0; i < 200; i++){
				glPointSize((2 * rand() / RAND_MAX) + 1);
				glBegin(GL_POINTS);
				RGBColor3f(255, 255, 255);
				glVertex2f(StaticStarArray[i].x, StaticStarArray[i].y);
				glEnd();
			}


			glTranslatef(0, AnimatePosition(0, -30, 7000), 0);

			InitDinamicStarRandom();
			for (int i = 0; i < 500; i++){
				glPointSize((1 * rand() / RAND_MAX) + 2);
				glBegin(GL_POINTS);
				RGBColor3f(255, 255, 255);
				glVertex2f(DinamicStarArray[i].x, DinamicStarArray[i].y);
				glEnd();
			}

			glBegin(GL_QUADS);
			RGBColor3f(76, 240, 255);
			glVertex2f(-60, AnimatePosition(50, 0, 15000));
			glVertex2f(60, AnimatePosition(50, 0, 15000));
			RGBColor3f(0, 0, 0, AnimatePosition(600, 0, 10000));
			glVertex2f(60, AnimatePosition(300, 50, 15000));
			glVertex2f(-60, AnimatePosition(300, 50, 15000));
			glEnd();

			glTranslatef(0, AnimatePosition(0, 30, 7000), 0);

			glTranslatef(0, AnimatePosition(0, -30, 7000), 0);
			drawDom();
			drawShariki();
			glTranslatef(0, AnimatePosition(0, 30, 7000), 0);


			//-- Start of cat animation --\\

			if (currentTimeFilm < moveStartTime + time_lenght * 8 + 50000
				&& currentTimeFilm > moveStartTime + time_lenght * 8 + 35000){

				initCat();

				if (currentCat <= startTimeCat + allTimeCat){
					yCat = -1 + (1 + 1) * ((float)(currentCat - startTimeCat) / allTimeCat);
				}
				else{
					yCat = 1 + (-1 - 1) * ((float)(currentCat - (startTimeCat + allTimeCat)) / allTimeCat);
				};

				if (currentCatTail <= startTimeCatTail + allTimeCatTail){
					yCatTail = -.5 + (2.5 + .5) * ((float)(currentCatTail - startTimeCatTail) / allTimeCatTail);
				}
				else{
					yCatTail = 2.5 + (-.5 - 2.5) * ((float)(currentCatTail - (startTimeCatTail + allTimeCatTail)) / allTimeCatTail);
				};

				if (currentCatRainbow <= startTimeCatRainbow + allTimeCatRainbow){
					yCatRainbow = -.5 + (.5 + .5) * ((float)(currentCatRainbow - startTimeCatRainbow) / allTimeCatRainbow);
				}
				else{
					yCatRainbow = .5 + (-.5 - .5) * ((float)(currentCatRainbow - (startTimeCatRainbow + allTimeCatRainbow)) / allTimeCatRainbow);
				};

				if ((currentCatMain <= startTimeCatMain + 5000)){

					xMain = 0 + (100 - 0) * ((float)(currentCatMain - (startTimeCatMain)) / 5000);
				}
				else{
					if ((currentCatMain <= startTimeCatMain + 10000)){

						xMain = 100 + (100 - 100) * ((float)(currentCatMain - (startTimeCatMain + 5000)) / 8000);
					}
					else{

						xMain = 100 + (200 - 100) * ((float)(currentCatMain - (startTimeCatMain + 10000)) / 2000);

					}
				}
				if (currentCat >= startTimeCat + 2 * allTimeCat){
					startTimeCat = GetTickCount();
				}

				if (currentCatTail >= startTimeCatTail + 2 * allTimeCatTail){
					startTimeCatTail = GetTickCount();
				}

				if (currentCatRainbow >= startTimeCatRainbow + 2 * allTimeCatRainbow){
					startTimeCatRainbow = GetTickCount();
				}

				drawNYAN();

			}

			if (currentTimeFilm > moveStartTime + time_lenght * 8 + 49000){
				glTranslatef(-150, 0, 0);
				drawSputnik();
				glTranslatef(150, 0, 0);
			}
			if (currentTimeFilm < moveStartTime + time_lenght * 8 + 80000
				&& currentTimeFilm > moveStartTime + time_lenght * 8 + 49000){
				glTranslatef(-15, 15, 0);
				InitText();
				writeText();
			}
			if (currentTimeFilm > moveStartTime + 80000){
				glTranslatef(-15, 15, 0);
				//InitText();
				//writeText();
				Textout("Demo produced by Lipko SCRIMERS Ivan.", 0, -3, 0.8, 0.1, 0, 1);
				Textout("This is my gift for RuDemoscene with help of my pupils.", 0, -6, 0.8, 0.1, 0, 1);
				Textout("You can close now =) Buy!", 0, -9, 0.8, 0.1, 0, 1);
				Textout("S novum godom!", 0, -15, 0.8, 0.1, 0, 1);
			}
		}
	}
	if (currentTimeFilm - moveStartTime >  100000){
		exit(0);
	}
}