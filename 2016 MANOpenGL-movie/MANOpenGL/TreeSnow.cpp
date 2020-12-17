#include "TreeSnow.h"
#include "time.h"

int signTS = 1;

Snow snow[snowCount];
Tree tree[8];

time_t startTime, startTimeSnow;

void initTreeSnow() {
	if (signTS) {
		signTS = 0;
		srand(time(NULL));

		for (int i = 0; i < snowCount; i++) {
			snow[i].startX = 110 * (float)rand() / RAND_MAX - 55;
			snow[i].startY = 25 + 30 * (float)rand() / RAND_MAX;
			snow[i].endX = snow[i].startX + 6 * (float)rand() / RAND_MAX - 3;
			snow[i].endY = 27 * (float)rand() / RAND_MAX;
			snow[i].posX = 10;
			snow[i].posY = 10;
			snow[i].timeX = 5000;
			snow[i].timeY = 5000;

			

			snow[i].startColor[0] = 0.9 + 0.1 * (float) rand()/RAND_MAX;
			snow[i].startColor[1] = 0.9 + 0.2 * (float) rand()/RAND_MAX;
			snow[i].startColor[2] = 0.9 + 0.4 * (float) rand()/RAND_MAX;
			snow[i].startColor[3] = 1.1 + 0.8 * (float) rand()/RAND_MAX;
			snow[i].color[0] = 0;
			snow[i].color[1] = 0;
			snow[i].color[2] = 0;
			snow[i].color[3] = 1;
			snow[i].endColor[0] = 0.9 + 0.1 * (float) rand()/RAND_MAX;
			snow[i].endColor[1] = 0.9 + 0.1 * (float) rand()/RAND_MAX;
			snow[i].endColor[2] = 0.9 + 0.3* (float) rand()/RAND_MAX;
			snow[i].endColor[3] = 0.0;
			snow[i].colorTime = 5000;
		}

		for (int i = 0; i < 8; i++){
			tree[i].part[0].startColor[0] = 0.0;
			tree[i].part[0].startColor[1] = 0.6;
			tree[i].part[0].startColor[2] = 0.0;
			tree[i].part[0].startColor[3] = 1.1;
			tree[i].part[1].startColor[0] = 0.0;
			tree[i].part[1].startColor[1] = 0.8;
			tree[i].part[1].startColor[2] = 0.0;
			tree[i].part[1].startColor[3] = 1.1;
			tree[i].part[2].startColor[0] = 0.0;
			tree[i].part[2].startColor[1] = 1.0;
			tree[i].part[2].startColor[2] = 0.0;
			tree[i].part[2].startColor[3] = 1.1;

			tree[i].endColor[0] = 1.0;
			tree[i].endColor[1] = 1.0;
			tree[i].endColor[2] = 1.0;
			tree[i].endColor[3] = 1.1;
			tree[i].part[2].colorTime = 6000;
			tree[i].part[1].colorTime = 4000;
			tree[i].part[0].colorTime = 2000;
		}

		tree[0].pos = -60;
		tree[1].pos = -45;
		tree[2].pos = -30;
		tree[3].pos = -15;
		tree[4].pos = 15;
		tree[5].pos = 30;
		tree[6].pos = 45;
		tree[7].pos = 60;

		glPointSize(7);
		glEnable(GL_POINT_SMOOTH);  
		startTime = GetTickCount();

		for (int i = 0; i < 8; i++) {
			tree[i].part[2].timeStart = startTime + 2000;
			tree[i].part[1].timeStart = startTime + 3000;
			tree[i].part[0].timeStart = startTime + 4000;
		}

		/*startTime = GetTickCount() - 20000;*/
		for (int i=0; i<snowCount; i++) {
			snow[i].timeStart = startTime + (int) (15000 * (float) rand()/RAND_MAX);
		}

		/*DWORD currentTime = GetTickCount();
		DWORD j = currentTime - 20000;	*/
		/*for (; j<GetTickCount(); j++) {*/
		for (int i=0; i<snowCount; i++) {
			/*snow[i].posX = snow[i].startX + (snow[i].endX - snow[i].startX) * ( (float) (j - snow[i].timeStart)/snow[i].timeX) ;
			snow[i].posY = snow[i].startY + (snow[i].endY - snow[i].startY) * ( (float) (j - snow[i].timeStart)/snow[i].timeY) ;
			
			snow[i].color[0] = snow[i].startColor[0] + (snow[i].endColor[0] - snow[i].startColor[0]) * ( (float) (j - snow[i].timeStart)/snow[i].colorTime) ;
			snow[i].color[1] = snow[i].startColor[1] + (snow[i].endColor[1] - snow[i].startColor[1]) * ( (float) (j - snow[i].timeStart)/snow[i].colorTime) ;
			snow[i].color[2] = snow[i].startColor[2] + (snow[i].endColor[2] - snow[i].startColor[2]) * ( (float) (j - snow[i].timeStart)/snow[i].colorTime) ;
			snow[i].color[3] = snow[i].startColor[3] + (snow[i].endColor[3] - snow[i].startColor[3]) * ( (float) (j - snow[i].timeStart)/snow[i].colorTime) ;*/
			
			if ( snow[i].color[3] < 0 ) {
				snow[i].timeStart = startTime + 30 * (float)rand() / RAND_MAX;
			}
		}
		//}
		

	}
}

void drawStaticElki(float pos){
	glBegin(GL_TRIANGLES);
	
	glColor3f(.8, .5, .3);
	glVertex2f(3 + pos, -3);
	glVertex2f(9 + pos, -3);
	glVertex2f(3 + pos, 3);

	glVertex2f(9 + pos, -3);
	glVertex2f(9 + pos, 1.5);
	glVertex2f(3 + pos, 3);

	glColor3f(0, 0.6, 0);
	glVertex2f(-3 + pos, 1.5);
	glVertex2f(15 + pos, 1.5);
	glVertex2f(6 + pos, 9);

	glColor3f(0, 0.8, 0);
	glVertex2f(pos, 6);
	glVertex2f(12 + pos, 6);
	glVertex2f(6 + pos, 15);

	glColor3f(0, 1, 0);
	glVertex2f(3 + pos, 12);
	glVertex2f(9 + pos, 12);
	glVertex2f(6 + pos, 16.5);

	glEnd();
}

void drawGround(){
	glBegin(GL_QUADS);

	glColor3f(0.3, 0.3, 0.3);
	glVertex2f(-60, -60);
	glVertex2f(60, -60);
	glVertex2f(60, -2);
	glVertex2f(-60, -2);

	glEnd();
}

