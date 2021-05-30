#ifndef _DRAW_H

#define _DRAW_H


#include <windows.h> // чтобы OpenGL не матерился на отсутствие констант

// Enable usage of OpenGL
#include "gl/gl.h"
#include "glut/glut.h"
#include "egl/glext.h"

#include "superSDK.h"

void drawScene();

#endif