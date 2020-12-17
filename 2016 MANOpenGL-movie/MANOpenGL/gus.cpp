#include "gus.h"

unsigned int startTimeGus;
int sign1 = 1;
float SmezhX = -70;

//init
void initGus(){
	if (sign1){
		sign1 = 0;
		srand(time(NULL));



		glPointSize(10);
//		startTime = GetTickCount();
		startTimeGus = GetTickCount();


	}
}
//Нарисуй куб (использовать 2 кооардинаты)
void drawCoube2(float PositionXleft, float PositionYleft, float PositionXright, float PositionYright){
	glBegin(GL_TRIANGLES);
	glVertex2f(0 + PositionXleft, 0 + PositionYleft);
	glVertex2f(0 + PositionXright, 0 + PositionYleft);
	glVertex2f(0 + PositionXright, 0 + PositionYright);
	glEnd();
	glBegin(GL_TRIANGLES);
	glVertex2f(0 + PositionXleft, 0 + PositionYleft);
	glVertex2f(0 + PositionXright, 0 + PositionYright);
	glVertex2f(0 + PositionXleft, 0 + PositionYright);
	glEnd();
}
//Нарисуй круг
void drawCirce(float PositionX, float PositionY, float Radius, int AmountSegments, GLfloat Width = 2){
	/*glBegin(GL_LINE_STRIP);*/
	glBegin(GL_TRIANGLE_FAN);
	for (int i = 0; i < AmountSegments; i++)
	{
		float andle = 2.0 * 3.1415926 * float(i) / float(AmountSegments);
		float dx = Radius * cosf(andle);
		float dy = Radius * sinf(andle);
		glVertex2f(PositionX + dx, PositionY + dy);
	}
	glEnd();
}
//Нарисуй усы(гусеницы)
void drawusy(float PositionX, float PositionY, float Radius, int AmountSegments, GLfloat Width = 2){
	glBegin(GL_LINE_STRIP);
	for (int i = 0; i < AmountSegments; i++)
	{
		float andle = 0.5 * 3.1415926 * float(i) / float(AmountSegments);
		float dx = Radius * cosf(andle);
		float dy = Radius * sinf(andle);
		glVertex2f(PositionX - dx, PositionY + dy);
	}
	glEnd();
}
//Color RGB (4 переменной водить прозрачность значение в проценах)
void ColorRGB(float Red, float Grey, float Blye, float alpha){
	glColor4f(Red / 255, Grey / 255, Blye / 255, (1 * alpha) / 100);
}
//Нарисуй шахмотную доску (x,y,колличество ячеек,ширина ячеек)
void drawchess(float ax, float ay, float p, float shyrina){
	float rent = shyrina * 2;
	for (int j = 0; j < p; j++){
		for (int i = 0; i < p; i++){
			drawCoube2(ax, ay, ax + shyrina, ay + shyrina);
			ax = ax + rent;
		}
		ay = ay + rent;
		for (int i = 0; i < p; i++){
			drawCoube2(ax, ay, ax - shyrina, ay - shyrina);
			ax = ax - rent;
		}
	}
}

void drawHeadGus(float xh = 0, float yh = 0){
	ColorRGB(255, 255, 255, 100);
	drawusy((12 + xh) + SmezhX, 7 + yh, 5, 5);

	ColorRGB(37, 112, 1, 100);
	drawCirce((5 + xh) + SmezhX, 5 + yh, 5, 15);
	ColorRGB(255, 255, 255, 90);
	drawusy((9 + xh) + SmezhX, 9 + yh, 5, 5);
	drawCirce((7 + xh) + SmezhX, 6 + yh, 2, 15);
	ColorRGB(0, 0, 0, 90);
	drawCirce((8 + xh) + SmezhX, 6 + yh, 1, 15);
}
void draw1Gus(float x1 = 0, float y1 = 0){
	ColorRGB(22, 66, 2, 100);
	drawCirce((-12 + x1) + SmezhX, 3 + y1, 3, 15);
}
void draw2Gus(float x2 = 0, float y2 = 0) {
	ColorRGB(59, 184, 2, 100);
	drawCirce((-9 + x2) + SmezhX, 5 + y2, 4, 15);
}
void draw3Gus(float x3 = 0, float y3 = 0) {
	ColorRGB(22, 66, 2, 100);
	drawCirce((-4 + x3) + SmezhX, 7 + y3, 5, 15);
}
void draw4Gus(float x4 = 0, float y4 = 0) {

	ColorRGB(59, 184, 2, 100);
	drawCirce((-0 + x4) + SmezhX, 7 + y4, 5, 15);
}
void drawGive(float x , float y ){
	ColorRGB(255, 255, 255, 90);
	drawCoube2(0 + x, 0 + y, 20 + x, 20 + y);
	ColorRGB(182, 22, 209, 80);
	drawCirce(8 + x, 24 + y, 4, 10);

	ColorRGB(200, 15, 0, 70);
	drawCirce(13 + x, 24 + y, 5, 15);



	ColorRGB(69, 232, 0, 70);
	drawchess(0 + x, 0 + y, 2, 5);
	ColorRGB(124, 57, 174, 70);
	drawchess(0 + x, 0 + y, 5, 2);

	ColorRGB(206, 180, 26, 70);
	drawchess(0 + x, 0 + y, 10, 1);
	ColorRGB(200, 15, 0, 100);
	drawCoube2(8 + x, -1 + y, 12 + x, 21 + y);

	ColorRGB(182, 22, 209, 100);
	drawCoube2(-1 + x, 8 + y, 21 + x, 12 + y);

}


