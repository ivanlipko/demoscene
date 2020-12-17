//
// Header file to libExt
//
// Author: Alex V. Boreskoff <steps3d@gmail.com>, <steps3d@narod.ru>
//

#ifndef __LIB_EXT__
#define __LIB_EXT__

#include    <windows.h>
#pragma warning (disable:4996)


#include    <GL/gl.h>
#include    <GL/glu.h>
#include    "glext.h"
//#include    "wglext.h"

void    initExtensions       ();
                                    // VBO functions
extern  PFNGLBINDBUFFERARBPROC                  glBindBufferARB;
extern  PFNGLDELETEBUFFERSARBPROC               glDeleteBuffersARB;
extern  PFNGLGENBUFFERSARBPROC                  glGenBuffersARB;
extern  PFNGLISBUFFERARBPROC                    glIsBufferARB;
extern  PFNGLBUFFERDATAARBPROC                  glBufferDataARB;
extern  PFNGLBUFFERSUBDATAARBPROC               glBufferSubDataARB;
extern  PFNGLGETBUFFERSUBDATAARBPROC            glGetBufferSubDataARB;
extern  PFNGLMAPBUFFERARBPROC                   glMapBufferARB;
extern  PFNGLUNMAPBUFFERARBPROC                 glUnmapBufferARB;
extern  PFNGLGETBUFFERPARAMETERIVARBPROC        glGetBufferParameterivARB;
extern  PFNGLGETBUFFERPOINTERVARBPROC           glGetBufferPointervARB;

#endif
