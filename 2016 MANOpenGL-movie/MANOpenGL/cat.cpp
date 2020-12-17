#include "cat.h"

float yCat, yCatTail, yCatRainbow, startTimeCat, startTimeCatTail, startTimeCatRainbow, allTimeCatTail, allTimeCat, allTimeCatRainbow, xMain, startTimeCatMain;
int button = 1;
int set = 1;
void drawSqr(float x1, float y1, float x2, float y2){

	glBegin(GL_QUADS);

	glVertex2f(x1, y1);
	glVertex2f(x2, y1);
	glVertex2f(x2, y2);
	glVertex2f(x1, y2);

	glEnd();
}

void drawPoint(float x1, float y1){
	glBegin(GL_POINTS);

	glVertex2f(x1, y1);

	glEnd();

}

void drawLine(float x1, float y1, float x2, float y2){

	glBegin(GL_LINES);

	glVertex2f(x1, y1);
	glVertex2f(x2, y2);

	glEnd();
}

void drawQuad(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4){

	glBegin(GL_QUADS);

	glVertex2f(x1, y1);
	glVertex2f(x2, y2);
	glVertex2f(x3, y3);
	glVertex2f(x4, y4);

	glEnd();
}

void drawNYAN(){

	glTranslatef(-100, 20, 0);

	glTranslatef(xMain, 0, 0);

	glBegin(GL_QUADS);

	glColor4f(0.5, 0, 1, .8);

	glVertex2f(-31, -30 + yCatRainbow);
	glVertex2f(-29, -30 + yCatRainbow);

	glColor4f(0.5, 0, 1, .6);

	glVertex2f(-29, -27 + yCatRainbow);
	glVertex2f(-31, -27 + yCatRainbow);

	glVertex2f(-32, -30 + yCatRainbow);
	glVertex2f(-30, -30 + yCatRainbow);

	glColor4f(0.5, 0, 1, .4);

	glVertex2f(-30, -27 + yCatRainbow);
	glVertex2f(-32, -27 + yCatRainbow);

	glVertex2f(-33, -30 + yCatRainbow);
	glVertex2f(-31, -30 + yCatRainbow);

	glColor4f(0.5, 0, 1, .2);

	glVertex2f(-31, -27 + yCatRainbow);
	glVertex2f(-33, -27 + yCatRainbow);

	glVertex2f(-34, -30 + yCatRainbow);
	glVertex2f(-32, -30 + yCatRainbow);
	glVertex2f(-32, -27 + yCatRainbow);
	glVertex2f(-34, -27 + yCatRainbow);

	glColor3f(0.5, 0, 1);

	glVertex2f(-30, -30 + yCatRainbow);
	glVertex2f(-28, -30 + yCatRainbow);
	glVertex2f(-28, -27 + yCatRainbow);			//Violet1
	glVertex2f(-30, -27 + yCatRainbow);

	glVertex2f(-28, -28 - yCatRainbow);
	glVertex2f(-28, -31 - yCatRainbow);
	glVertex2f(-21, -31 - yCatRainbow);			//Violet2
	glVertex2f(-21, -28 - yCatRainbow);

	glVertex2f(-21, -30 + yCatRainbow);
	glVertex2f(-14, -30 + yCatRainbow);			//Violet3
	glVertex2f(-14, -27 + yCatRainbow);
	glVertex2f(-21, -27 + yCatRainbow);

	glVertex2f(-14, -31 - yCatRainbow);
	glVertex2f(-7, -31 - yCatRainbow);			//Violet4
	glVertex2f(-7, -28 - yCatRainbow);
	glVertex2f(-14, -28 - yCatRainbow);



	glColor4f(0, 0, 1, .8);

	glVertex2f(-31, -27 + yCatRainbow);
	glVertex2f(-29, -27 + yCatRainbow);

	glColor4f(0, 0, 1, .6);

	glVertex2f(-29, -24 + yCatRainbow);
	glVertex2f(-31, -24 + yCatRainbow);

	glVertex2f(-32, -27 + yCatRainbow);
	glVertex2f(-30, -27 + yCatRainbow);

	glColor4f(0, 0, 1, .4);

	glVertex2f(-30, -24 + yCatRainbow);
	glVertex2f(-32, -24 + yCatRainbow);

	glVertex2f(-33, -27 + yCatRainbow);
	glVertex2f(-31, -27 + yCatRainbow);

	glColor4f(0, 0, 1, .2);

	glVertex2f(-31, -24 + yCatRainbow);
	glVertex2f(-33, -24 + yCatRainbow);

	glVertex2f(-34, -27 + yCatRainbow);
	glVertex2f(-32, -27 + yCatRainbow);
	glVertex2f(-32, -24 + yCatRainbow);
	glVertex2f(-34, -24 + yCatRainbow);

	glColor3f(0, 0, 1);
	glVertex2f(-30, -27 + yCatRainbow);
	glVertex2f(-28, -27 + yCatRainbow);			//Blue1
	glVertex2f(-28, -24 + yCatRainbow);
	glVertex2f(-30, -24 + yCatRainbow);

	glVertex2f(-21, -28 - yCatRainbow);			//Blue2
	glVertex2f(-21, -25 - yCatRainbow);
	glVertex2f(-28, -25 - yCatRainbow);
	glVertex2f(-28, -28 - yCatRainbow);

	glVertex2f(-21, -27 + yCatRainbow);
	glVertex2f(-14, -27 + yCatRainbow);			//Blue3
	glVertex2f(-14, -24 + yCatRainbow);
	glVertex2f(-21, -24 + yCatRainbow);

	glVertex2f(-14, -28 - yCatRainbow);
	glVertex2f(-7, -28 - yCatRainbow);			//Blue4
	glVertex2f(-7, -25 - yCatRainbow);
	glVertex2f(-14, -25 - yCatRainbow);

	glColor4f(0, 1, 0, .8);

	glVertex2f(-31, -24 + yCatRainbow);
	glVertex2f(-29, -24 + yCatRainbow);

	glColor4f(0, 1, 0, .6);

	glVertex2f(-29, -21 + yCatRainbow);
	glVertex2f(-31, -21 + yCatRainbow);

	glVertex2f(-32, -24 + yCatRainbow);
	glVertex2f(-30, -24 + yCatRainbow);

	glColor4f(0, 1, 0, .4);

	glVertex2f(-30, -21 + yCatRainbow);
	glVertex2f(-32, -21 + yCatRainbow);

	glVertex2f(-33, -24 + yCatRainbow);
	glVertex2f(-31, -24 + yCatRainbow);

	glColor4f(0, 1, 0, .2);

	glVertex2f(-31, -21 + yCatRainbow);
	glVertex2f(-33, -21 + yCatRainbow);

	glVertex2f(-34, -24 + yCatRainbow);
	glVertex2f(-32, -24 + yCatRainbow);
	glVertex2f(-32, -21 + yCatRainbow);
	glVertex2f(-34, -21 + yCatRainbow);

	glColor3f(0, 1, 0);
	glVertex2f(-30, -24 + yCatRainbow);
	glVertex2f(-28, -24 + yCatRainbow);			//Green1
	glVertex2f(-28, -21 + yCatRainbow);
	glVertex2f(-30, -21 + yCatRainbow);

	glVertex2f(-28, -25 - yCatRainbow);
	glVertex2f(-21, -25 - yCatRainbow);			//Green2
	glVertex2f(-21, -22 - yCatRainbow);
	glVertex2f(-28, -22 - yCatRainbow);

	glVertex2f(-21, -24 + yCatRainbow);
	glVertex2f(-14, -24 + yCatRainbow);			//Green3
	glVertex2f(-14, -21 + yCatRainbow);
	glVertex2f(-21, -21 + yCatRainbow);

	glVertex2f(-14, -25 - yCatRainbow);
	glVertex2f(-7, -25 - yCatRainbow);			//Green4
	glVertex2f(-7, -22 - yCatRainbow);
	glVertex2f(-14, -22 - yCatRainbow);

	glColor4f(1, 1, 0, .8);

	glVertex2f(-31, -21 + yCatRainbow);
	glVertex2f(-29, -21 + yCatRainbow);

	glColor4f(1, 1, 0, .6);

	glVertex2f(-29, -18 + yCatRainbow);
	glVertex2f(-31, -18 + yCatRainbow);

	glVertex2f(-32, -21 + yCatRainbow);
	glVertex2f(-30, -21 + yCatRainbow);

	glColor4f(1, 1, 0, .4);

	glVertex2f(-30, -18 + yCatRainbow);
	glVertex2f(-32, -18 + yCatRainbow);

	glVertex2f(-33, -21 + yCatRainbow);
	glVertex2f(-31, -21 + yCatRainbow);

	glColor4f(1, 1, 0, .2);

	glVertex2f(-31, -18 + yCatRainbow);
	glVertex2f(-33, -18 + yCatRainbow);

	glVertex2f(-34, -21 + yCatRainbow);
	glVertex2f(-32, -21 + yCatRainbow);
	glVertex2f(-32, -18 + yCatRainbow);
	glVertex2f(-34, -18 + yCatRainbow);

	glColor3f(1, 1, 0);
	glVertex2f(-30, -21 + yCatRainbow);
	glVertex2f(-28, -21 + yCatRainbow);			//Yellow1
	glVertex2f(-28, -18 + yCatRainbow);
	glVertex2f(-30, -18 + yCatRainbow);

	glVertex2f(-28, -22 - yCatRainbow);
	glVertex2f(-21, -22 - yCatRainbow);			//Yellow2
	glVertex2f(-21, -19 - yCatRainbow);
	glVertex2f(-28, -19 - yCatRainbow);

	glVertex2f(-21, -21 + yCatRainbow);
	glVertex2f(-14, -21 + yCatRainbow);			//Yellow3
	glVertex2f(-14, -18 + yCatRainbow);
	glVertex2f(-21, -18 + yCatRainbow);

	glVertex2f(-14, -22 - yCatRainbow);
	glVertex2f(-7, -22 - yCatRainbow);			//Yellow4
	glVertex2f(-7, -19 - yCatRainbow);
	glVertex2f(-14, -19 - yCatRainbow);

	glColor4f(0.5, 0, 1, .8);

	glVertex2f(-31, -30 + yCatRainbow);
	glVertex2f(-29, -30 + yCatRainbow);

	glColor4f(0.5, 0, 1, .6);

	glVertex2f(-29, -27 + yCatRainbow);
	glVertex2f(-31, -27 + yCatRainbow);

	glVertex2f(-32, -30 + yCatRainbow);
	glVertex2f(-30, -30 + yCatRainbow);

	glColor4f(0.5, 0, 1, .4);

	glVertex2f(-30, -27 + yCatRainbow);
	glVertex2f(-32, -27 + yCatRainbow);

	glVertex2f(-33, -30 + yCatRainbow);
	glVertex2f(-31, -30 + yCatRainbow);

	glColor4f(0.5, 0, 1, .2);

	glVertex2f(-31, -27 + yCatRainbow);
	glVertex2f(-33, -27 + yCatRainbow);

	glVertex2f(-34, -30 + yCatRainbow);
	glVertex2f(-32, -30 + yCatRainbow);
	glVertex2f(-32, -27 + yCatRainbow);
	glVertex2f(-34, -27 + yCatRainbow);


	glColor3f(1, 0.5, 0);

	glVertex2f(-30, -18 + yCatRainbow);
	glVertex2f(-28, -18 + yCatRainbow);			//Orange1
	glVertex2f(-28, -15 + yCatRainbow);
	glVertex2f(-30, -15 + yCatRainbow);

	glVertex2f(-28, -19 - yCatRainbow);
	glVertex2f(-21, -19 - yCatRainbow);			//Orange2
	glVertex2f(-21, -16 - yCatRainbow);
	glVertex2f(-28, -16 - yCatRainbow);

	glVertex2f(-21, -18 + yCatRainbow);
	glVertex2f(-14, -18 + yCatRainbow);			//Orange3
	glVertex2f(-14, -15 + yCatRainbow);
	glVertex2f(-21, -15 + yCatRainbow);

	glVertex2f(-14, -19 - yCatRainbow);
	glVertex2f(-7, -19 - yCatRainbow);			//Orange4
	glVertex2f(-7, -16 - yCatRainbow);
	glVertex2f(-14, -16 - yCatRainbow);

	glColor4f(1, .5, 0, .8);

	glVertex2f(-31, -18 + yCatRainbow);
	glVertex2f(-29, -18 + yCatRainbow);

	glColor4f(1, .5, 0, .6);

	glVertex2f(-29, -15 + yCatRainbow);
	glVertex2f(-31, -15 + yCatRainbow);

	glVertex2f(-32, -18 + yCatRainbow);
	glVertex2f(-30, -18 + yCatRainbow);

	glColor4f(1, .5, 0, .4);

	glVertex2f(-30, -15 + yCatRainbow);
	glVertex2f(-32, -15 + yCatRainbow);

	glVertex2f(-33, -18 + yCatRainbow);
	glVertex2f(-31, -18 + yCatRainbow);

	glColor4f(1, .5, 0, .2);

	glVertex2f(-31, -15 + yCatRainbow);
	glVertex2f(-33, -15 + yCatRainbow);

	glVertex2f(-34, -18 + yCatRainbow);
	glVertex2f(-32, -18 + yCatRainbow);
	glVertex2f(-32, -15 + yCatRainbow);
	glVertex2f(-34, -15 + yCatRainbow);

	glColor3f(1, 0, 0);

	glVertex2f(-30, -15 + yCatRainbow);
	glVertex2f(-28, -15 + yCatRainbow);			//Red1
	glVertex2f(-28, -12 + yCatRainbow);
	glVertex2f(-30, -12 + yCatRainbow);

	glVertex2f(-28, -16 - yCatRainbow);
	glVertex2f(-21, -16 - yCatRainbow);			//Red2
	glVertex2f(-21, -13 - yCatRainbow);
	glVertex2f(-28, -13 - yCatRainbow);

	glVertex2f(-21, -15 + yCatRainbow);
	glVertex2f(-14, -15 + yCatRainbow);			//Red3
	glVertex2f(-14, -12 + yCatRainbow);
	glVertex2f(-21, -12 + yCatRainbow);

	glVertex2f(-14, -16 - yCatRainbow);
	glVertex2f(-7, -16 - yCatRainbow);			//Red4
	glVertex2f(-7, -13 - yCatRainbow);
	glVertex2f(-14, -13 - yCatRainbow);

	glColor4f(1, 0, 0, .8);

	glVertex2f(-31, -15 + yCatRainbow);
	glVertex2f(-29, -15 + yCatRainbow);

	glColor4f(1, 0, 0, .6);

	glVertex2f(-29, -12 + yCatRainbow);
	glVertex2f(-31, -12 + yCatRainbow);

	glVertex2f(-32, -15 + yCatRainbow);
	glVertex2f(-30, -15 + yCatRainbow);

	glColor4f(1, 0, 0, .4);

	glVertex2f(-30, -12 + yCatRainbow);
	glVertex2f(-32, -12 + yCatRainbow);

	glVertex2f(-33, -15 + yCatRainbow);
	glVertex2f(-31, -15 + yCatRainbow);

	glColor4f(1, 0, 0, .2);

	glVertex2f(-31, -12 + yCatRainbow);
	glVertex2f(-33, -12 + yCatRainbow);

	glVertex2f(-34, -15 + yCatRainbow);
	glVertex2f(-32, -15 + yCatRainbow);
	glVertex2f(-32, -12 + yCatRainbow);
	glVertex2f(-34, -12 + yCatRainbow);

	glEnd();

	glLineWidth(10);
	glBegin(GL_LINES);

	glColor3f(0, 0, 0);
	glVertex2f(-7, -32);
	glVertex2f(-7, -12);

	glVertex2f(-7, -12);
	glVertex2f(20, -12);

	glVertex2f(-7, -32);
	glVertex2f(20, -32);

	glVertex2f(20, -12);
	glVertex2f(20, -32);

	glEnd();

	glBegin(GL_QUADS);

	glColor3f(1, 1, .5);
	glVertex2f(-6.5, -31.5);
	glVertex2f(19.5, -31.5);		//Buscuit
	glVertex2f(19.5, -12.5);
	glVertex2f(-6.5, -12.5);

	glColor3f(1, .7, 1);
	glVertex2f(-5, -30);
	glVertex2f(18, -30);			//Jam
	glVertex2f(18, -14);
	glVertex2f(-5, -14);

	glEnd();

	glColor3f(.6, 0, .8);
	glPointSize(8);

	drawPoint(3, -18);
	drawPoint(6, -21);
	drawPoint(-3, -25);		//Blueberry
	drawPoint(7, -27);
	drawPoint(0, -29);
	drawPoint(12, -17);
	drawPoint(-4, -15.5);

	glPushMatrix();
	glTranslatef(0, yCat, 0);

	glColor3f(0, 0, 0);

	drawLine(12.5, -31, 12.5, -23);
	drawLine(13, -31.5, 28, -31.5);
	drawLine(13.5, -23, 13.5, -18);
	drawLine(14, -17.7, 16, -17.7);		//HeadOutline
	drawLine(18, -21, 23, -21);
	drawLine(28.5, -31.5, 28.5, -23);
	drawLine(27.5, -23, 27.5, -18);
	drawLine(27, -17.7, 25, -17.7);
	drawPoint(24.5, -19);
	drawPoint(23.5, -20);
	drawPoint(16.5, -19);
	drawPoint(17.5, -20);


	glColor3f(.4, .4, .4);

	drawQuad(13.2, -30.8, 27.7, -30.8, 27.7, -23, 13.2, -23);
	drawQuad(14, -23, 26.8, -23, 26.8, -21.5, 14, -21.5);				//Face
	drawQuad(14.1, -21.5, 15.7, -21.5, 15.7, -18.4, 14.1, -18.4);
	drawQuad(25.2, -21.5, 26.8, -21.5, 26.8, -18.4, 25.2, -18.4);
	drawQuad(15.7, -21.5, 17, -21.5, 17, -19.7, 15.7, -19.7);
	drawQuad(24.2, -21.5, 25.2, -21.5, 25.2, -19.7, 24.2, -19.7);
	drawQuad(15.7, -21.5, 18, -21.5, 18, -20.8, 15.7, -20.8);
	drawQuad(23, -21.5, 25, -21.5, 25, -20.8, 23, -20.8);


	glColor3f(1, 1, 1);

	drawSqr(17, -26, 19, -24);
	drawSqr(22, -26, 24, -24);

	glColor3f(0, 0, 0);											//Eyes

	drawQuad(18, -26, 19, -26, 19, -25, 18, -25);
	drawQuad(23, -26, 24, -26, 24, -25, 23, -25);


	drawLine(17, -29, 23, -29);
	drawLine(17.6, -29, 17.6, -27);									//Mouth
	drawLine(20, -29, 20, -27.5);
	drawLine(22.3, -29, 22.3, -27);

	glColor3f(1, .7, .7);

	drawQuad(14, -28, 16, -28, 16, -26, 14, -26);
	drawQuad(24.5, -28, 26.5, -28, 26.5, -26, 24.5, -26);

	glPopMatrix();

	glColor3f(0, 0, 0);

	drawSqr(12, -36, 16, -32);
	drawSqr(-2, -36, 2, -32);
	drawSqr(17, -36, 21, -32);
	drawSqr(3, -36, 7, -32);

	glColor3f(.4, .4, .4);										//Feets

	drawSqr(13, -35.3, 15.3, -33);
	drawSqr(-1, -35.3, 1.3, -33);
	drawSqr(18, -35.3, 20.3, -33);
	drawSqr(4, -35.3, 6.3, -33);

	//Tail

	glColor3f(0, 0, 0);
	drawSqr(-13 + 1, -24.9, -7.6 + 1, -21.3);
	glColor3f(.4, .4, .4);
	drawSqr(-12 + 1, -24, -7.6, -22);

	glPushMatrix();
	glTranslatef(0, yCatTail, 0);

	//Animated Tail

	glColor3f(0, 0, 0);
	drawSqr(-17 + 1, -25.5, -12 + 1, -22.5);
	glColor3f(.4, .4, .4);
	drawSqr(-16 + 1, -24.8, -12 + 1, -23.3);

	glPopMatrix();

	glTranslatef(-xMain, 0, 0);
	glTranslatef(100, -20, 0);

}


void initCat(){

	if (button == 1){
		button = 2;

		startTimeCat = GetTickCount();
		startTimeCatTail = GetTickCount();
		startTimeCatRainbow = GetTickCount();
		startTimeCatMain = GetTickCount();

		allTimeCat = 500.0;
		allTimeCatTail = 300.0;
		allTimeCatRainbow = 200.0;
		glDisable(GL_POINT_SMOOTH);
	};
}
