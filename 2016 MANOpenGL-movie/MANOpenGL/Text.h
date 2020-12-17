#ifndef _TEXT_H

#define _TEXT_H

#include <windows.h>

#include "gl/gl.h"
#include "glut/glut.h"
#include "egl/glext.h"

#include <time.h>
#include <math.h>

void InitText();
void Textout(char* str, int x, int y, GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha);
void writeText();

#endif