#include "dom.h"

int sign = 1;

Salut salut[250];

time_t start_time;
bool Init_Salut = true, isInitDinamicStarRandom = true, isInitStaticStarRandom = true, trigger = true;
XandY StaticStarArray[500];
XandY DinamicStarArray[500];
XandY Sputnik;

void initParticle(){
	if (sign){
		sign = 0;
		srand(time(NULL));
		for (int i = 0; i < 250; i++){
			salut[i].startX = 3 * (float)rand() / RAND_MAX;
			salut[i].startY = 2 * (float)rand() / RAND_MAX;
			salut[i].posX = 0;
			salut[i].posY = 0;
			salut[i].endX = (25 * (float)rand() / RAND_MAX) - 12.5;
			salut[i].endY = (20 * (float)rand() / RAND_MAX);
			salut[i].timeX = 4000;
			salut[i].timeY = 3600;
			salut[i].colorR = 255 * rand() / RAND_MAX;
			salut[i].colorG = 255 * rand() / RAND_MAX;
			salut[i].colorB = 255 * rand() / RAND_MAX;

		}
		glPointSize(10);
	}



}
void InitDinamicStarRandom(){
	if (isInitDinamicStarRandom == false){
		return;
	}
	srand(time(NULL));
	isInitDinamicStarRandom = false;
	for (int i = 0; i < 500; i++){
		DinamicStarArray[i].x = (120 * (float)rand() / RAND_MAX) - 60;
		DinamicStarArray[i].y = (500 * (float)rand() / RAND_MAX) + 60;
	}


}
void InitStaticStarRandom(){
	if (isInitStaticStarRandom == false){
		return;
	}
	srand(time(NULL));
	isInitStaticStarRandom = false;
	for (int i = 0; i < 500; i++){
		StaticStarArray[i].x = (120 * (float)rand() / RAND_MAX) - 60;
		StaticStarArray[i].y = (120 * (float)rand() / RAND_MAX) - 60;
	}
}
void InitTimeDom(){
	if (trigger == false){
		return;
	}
	trigger = false;
	start_time = GetTickCount();
}

void RGBColor3f(float red, float green, float blue, float alpha){

	glColor4f(red / 255, green / 255, blue / 255, alpha / 255);
}

void DLine(float PositionX1, float PositionY1, float PositionX2, float PositionY2, GLfloat Width) //ђисует линию
{
	glLineWidth(Width);
	glBegin(GL_LINES);
	glVertex2f(PositionX1, PositionY1);
	glVertex2f(PositionX2, PositionY2);
	glEnd();
}
void DTriangleFree(float PosX1, float PosY1, float PosX2, float PosY2, float PosX3, float PosY3)   //ђисует триугольник по заданным координатам
{
	glBegin(GL_TRIANGLES);
	glVertex2f(PosX1, PosY1);
	glVertex2f(PosX2, PosY2);
	glVertex2f(PosX3, PosY3);
	glEnd();

}
float AnimatePosition(float start_point, float end_point, float time_lenght){
	InitTimeDom();

	float time_result = GetTickCount() - start_time;
	float Pos = (start_point + (end_point - start_point) * (time_result / time_lenght));
	return (Pos);

}
void DCubeDiagonal(float PosX1, float PosY1, float PosX2, float PosY2)       //Рисует прямоугольник по диагонали
{
	glBegin(GL_QUADS);
	glVertex2f(PosX1, PosY1);
	glVertex2f(PosX2, PosY1);
	glVertex2f(PosX2, PosY2);
	glVertex2f(PosX1, PosY2);
	glEnd();
}
void DCircle(float PositionX, float PositionY, float Radius, int AmountSegments, GLfloat Width = 2)    //Рисует окружность
{
	glLineWidth(Width);
	glBegin(GL_TRIANGLE_FAN);
	for (int i = 0; i < AmountSegments; i++)
	{
		float angle = 2.0 * 3.1415926 * float(i) / float(AmountSegments);
		float dx = Radius * cos(angle);
		float dy = Radius * sin(angle);
		glVertex2f(PositionX + dx, PositionY + dy);
	}
	glEnd();
}

void drawShariki(){
	for (int i = 0; i < 250; i++){
		salut[i].posX = salut[i].startX + (salut[i].endX - salut[i].startX) * ((float)(GetTickCount() - start_time) / salut[i].timeX);
		salut[i].posY = salut[i].startY + (salut[i].endY - salut[i].startY) * ((float)(GetTickCount() - start_time) / salut[i].timeY);

	}
	glPointSize(19);
	glBegin(GL_POINTS);
	for (int i = 0; i < 250; i++){
		RGBColor3f(salut[i].colorR, salut[i].colorG, salut[i].colorB, AnimatePosition(240, 0, 15000));
		glVertex2f(salut[i].posX - 1.5, salut[i].posY + 20);

	}

	glEnd();

	
}
void drawDom(){
	RGBColor3f(76, 240, 255);
	DCubeDiagonal(-60, -90, 60, AnimatePosition(50, 0, 15000));

	glColor3f(0.3, 0.3, 0.3);
	DCubeDiagonal(60, -25, -60, -60);

	RGBColor3f(226, 178, 78);
	DCubeDiagonal(-18, -30, 27, 0);
	RGBColor3f(45, 33, 8);
	DCubeDiagonal(-21, -6, 30, 12);

	RGBColor3f(183, 145, 64);
	DCubeDiagonal(-15, -30, 15, -25);
	RGBColor3f(255, 214, 132);
	DCubeDiagonal(-15, -25, 15, 0);
	RGBColor3f(73, 62, 38);

	DCubeDiagonal(-3, 9, 3, 20);
	RGBColor3f(255, 214, 132);
	DTriangleFree(-15, 0, 15, 0, 0, 12);
	RGBColor3f(255, 255, 255);
	DLine(-17, -1, 0, 12, 10);
	DLine(17, -1, 0, 12, 10);
	RGBColor3f(155, 175, 255);
	DCubeDiagonal(-3.5, -8, 3.5, 4);

}
void drawSputnik(){
	Sputnik.x = AnimatePosition(-150, -90, 7000);
	Sputnik.y = sinf(Sputnik.x) - 20;

	RGBColor3f(202, 196, 255);
	DCircle(0 + Sputnik.x, 0 + Sputnik.y, 5, 360);

	RGBColor3f(94, 92, 107);
	DLine(-10 + Sputnik.x, 0 + Sputnik.y, -4 + Sputnik.x, 0 + Sputnik.y);
	DLine(-8 + Sputnik.x, 6 + Sputnik.y, -3 + Sputnik.x, 2 + Sputnik.y);
	DLine(-8 + Sputnik.x, -6 + Sputnik.y, -3 + Sputnik.x, -2 + Sputnik.y);

	RGBColor3f(40, 39, 45);
	DLine(-7 + Sputnik.x, 2 + Sputnik.y, -4.7 + Sputnik.x, 1.7 + Sputnik.y);
	DLine(-7 + Sputnik.x, -2 + Sputnik.y, -4.7 + Sputnik.x, -1.7 + Sputnik.y);
}