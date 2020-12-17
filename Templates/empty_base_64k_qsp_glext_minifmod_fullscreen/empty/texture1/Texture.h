#ifndef TEXTURE_H
#define TEXTURE_H

#include "common.h"
#include "gl/gl.h"

#define GL_BGR                            0x80E0
#define GL_BGRA                           0x80E1
#define GL_CLAMP_TO_EDGE                  0x812F

// создает текстуру из TGA-файла с изображением
GLuint TextureCreateFromTGA(const char *fileName);

// удаляет текстуру
void TextureDestroy(GLuint texture);

#endif /* TEXTURE_H */
