#include "superSDK.h"

int sign = 1;

Salut salut[salutCount];
int startTime;

void init() {
	if (sign) {
		sign = 0;
		srand(time(NULL));

		for (int i=0; i<salutCount; i++) {
			salut[i].startX = 7 * (float) rand()/RAND_MAX;
			salut[i].startY = 5 * (float) rand()/RAND_MAX;
			salut[i].posX = 0;
			salut[i].posY = 0;
			salut[i].endX = 7/2;
			salut[i].endY = 10 + 10 * (float) rand()/RAND_MAX;
			salut[i].timeX = 5000;
			salut[i].timeY = 5000;

			
			// ��� �������. ���������� �1
			salut[i].startColor[0] = 0.8 + 0.4 * (float) rand()/RAND_MAX;
			salut[i].startColor[1] = 0.1 + 0.2 * (float) rand()/RAND_MAX;
			salut[i].startColor[2] = 0.1 + 0.1 * (float) rand()/RAND_MAX;
			salut[i].startColor[3] = 1.1 + 0.8 * (float) rand()/RAND_MAX;
			salut[i].color[0] = 0;
			salut[i].color[1] = 0;
			salut[i].color[2] = 0;
			salut[i].color[3] = 1;
			salut[i].endColor[0] = 0.8 + 0.3 * (float) rand()/RAND_MAX;
			salut[i].endColor[1] = 0.7 + 0.4 * (float) rand()/RAND_MAX;
			salut[i].endColor[2] = 0.1 + 0.1* (float) rand()/RAND_MAX;
			salut[i].endColor[3] = 0.0;// - 0.5* (float) rand()/RAND_MAX;
			salut[i].colorTime = 5000;
			// ��� �������. ���������� �1. �����
			
		}
		glPointSize(10);
		glEnable(GL_POINT_SMOOTH);  // ����� ��� ���� ����� ����� ���� ��������
		startTime = GetTickCount();
		
		// ��� ���������� ��������
		for (int i=0; i<salutCount; i++) {
			salut[i].timeStart = startTime + (int) (15000 * (float) rand()/RAND_MAX);
		}
		// ��� ���������� ��������. �����
			
		// �������� ������������� ��������
		startTime = GetTickCount()-20000;
		for (int i=0; i<salutCount; i++) {
			salut[i].timeStart = startTime + (int) (15000 * (float) rand()/RAND_MAX);
		}

		DWORD currentTime = GetTickCount();
		DWORD j = currentTime - 20000;	// ���� ������������ ������� �� 20 ������ �� �������� ������� �������.
		for (; j<currentTime; j++) {	// � �� ��� ���
			for (int i=0; i<salutCount; i++) {
				salut[i].posX = salut[i].startX + (salut[i].endX - salut[i].startX) * ( (float) (j - salut[i].timeStart)/salut[i].timeX) ;
				salut[i].posY = salut[i].startY + (salut[i].endY - salut[i].startY) * ( (float) (j - salut[i].timeStart)/salut[i].timeY) ;
				
				salut[i].color[0] = salut[i].startColor[0] + (salut[i].endColor[0] - salut[i].startColor[0]) * ( (float) (j - salut[i].timeStart)/salut[i].colorTime) ;
				salut[i].color[1] = salut[i].startColor[1] + (salut[i].endColor[1] - salut[i].startColor[1]) * ( (float) (j - salut[i].timeStart)/salut[i].colorTime) ;
				salut[i].color[2] = salut[i].startColor[2] + (salut[i].endColor[2] - salut[i].startColor[2]) * ( (float) (j - salut[i].timeStart)/salut[i].colorTime) ;
				salut[i].color[3] = salut[i].startColor[3] + (salut[i].endColor[3] - salut[i].startColor[3]) * ( (float) (j - salut[i].timeStart)/salut[i].colorTime) ;
				
				if ( salut[i].color[3] < 0 ) {
					salut[i].timeStart = j;
				}
			}
		}
			// ���� ������ ����� ������� �����, �� ��� ��������������� ��� �����, ��� ����� ���������� "������� �����" � ����� ���������, ������� ���� �������������, ����� ������������ ������. 
			//�.�. ������ ����� ������ GetTickCount() � ���� ������� � GetTickCount() � ��������� ������� ������, ������� ���� ��������� � ����� �������� for (; j<currentTime + 5000; j++) { ... }
		// �������� ������������� ��������. �����
	}
}

void drawTree(float dx){
	glBegin(GL_TRIANGLES);

	glColor3f(.8,.5,.3);
	glVertex2f(2+dx,2);
	glVertex2f(6+dx,2);
	glVertex2f(2+dx,6);

	glVertex2f(6+dx,2);
	glVertex2f(6+dx,5);
	glVertex2f(2+dx,6);

	glColor3f(0,.5,0);
	glVertex2f(-2+dx,5);
	glVertex2f(10+dx,5);
	glVertex2f(4+dx,10);

	glColor3f(0,.8,0);
	glVertex2f(0+dx,8);
	glVertex2f(8+dx,8);
	glVertex2f(4+dx,14);

	glColor3f(0,1,0);
	glVertex2f(2+dx,12);
	glVertex2f(6+dx,12);
	glVertex2f(4+dx,15);
	glEnd();
}

