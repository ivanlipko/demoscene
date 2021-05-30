#include "draw.h"
#include "time.h"

void drawScene() {

	init();

	drawTree(12);
	drawTree(24);
	drawTree(36);
	//drawTree(0);
	drawTree(-12);
	drawTree(-24);
	drawTree(-36);


	for (int i=0; i<salutCount; i++) {
		
		//�������
		//salut[i].posX = salut[i].startX + (salut[i].endX - salut[i].startX) * ( (float) (GetTickCount() - startTime)/salut[i].timeX) ;
		//salut[i].posY = salut[i].startY + (salut[i].endY - salut[i].startY) * ( (float) (GetTickCount() - startTime)/salut[i].timeY) ;
		
		/*
		// ��� �������. ���������� �1
		salut[i].color[0] = salut[i].startColor[0] + (salut[i].endColor[0] - salut[i].startColor[0]) * ( (float) (GetTickCount() - startTime)/salut[i].colorTime) ;
		salut[i].color[1] = salut[i].startColor[1] + (salut[i].endColor[1] - salut[i].startColor[1]) * ( (float) (GetTickCount() - startTime)/salut[i].colorTime) ;
		salut[i].color[2] = salut[i].startColor[2] + (salut[i].endColor[2] - salut[i].startColor[2]) * ( (float) (GetTickCount() - startTime)/salut[i].colorTime) ;
		salut[i].color[3] = salut[i].startColor[3] + (salut[i].endColor[3] - salut[i].startColor[3]) * ( (float) (GetTickCount() - startTime)/salut[i].colorTime) ;
		// ��� �������. ���������� �1. �����

		// ������ �������� ��� ��� ����������������, �.�. ���� ��� ���� ����
		*/

		
		// ��� ���������� ��������
		salut[i].posX = salut[i].startX + (salut[i].endX - salut[i].startX) * ( (float) (GetTickCount() - salut[i].timeStart)/salut[i].timeX) ;
		salut[i].posY = salut[i].startY + (salut[i].endY - salut[i].startY) * ( (float) (GetTickCount() - salut[i].timeStart)/salut[i].timeY) ;
		
		salut[i].color[0] = salut[i].startColor[0] + (salut[i].endColor[0] - salut[i].startColor[0]) * ( (float) (GetTickCount() - salut[i].timeStart)/salut[i].colorTime) ;
		salut[i].color[1] = salut[i].startColor[1] + (salut[i].endColor[1] - salut[i].startColor[1]) * ( (float) (GetTickCount() - salut[i].timeStart)/salut[i].colorTime) ;
		salut[i].color[2] = salut[i].startColor[2] + (salut[i].endColor[2] - salut[i].startColor[2]) * ( (float) (GetTickCount() - salut[i].timeStart)/salut[i].colorTime) ;
		salut[i].color[3] = salut[i].startColor[3] + (salut[i].endColor[3] - salut[i].startColor[3]) * ( (float) (GetTickCount() - salut[i].timeStart)/salut[i].colorTime) ;
		
		if ( salut[i].color[3] < 0 ) {
			salut[i].timeStart = GetTickCount();
		}
		// ��� ���������� ��������. ����� 
		
	}

	glBegin(GL_POINTS);
	for (int i=0; i<salutCount; i++){
		// ��� �������. ���������� �1
		glColor4fv(salut[i].color);
		// ��� �������. ���������� �1. �����

		// �������
		//glVertex2f(salut[i].posX, salut[i].posY);

		
		// ��� ���������� ��������
		if ( salut[i].posY > -1) {
			glVertex2f(salut[i].posX, salut[i].posY);
		} else {
		}
		// ��� ���������� ��������. �����
		
	}
	glEnd();

}