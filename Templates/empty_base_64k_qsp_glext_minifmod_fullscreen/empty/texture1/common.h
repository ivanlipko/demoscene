#ifndef COMMON_H
#define COMMON_H

#include <cstdio>
#include <cstdlib>
#include <cstdarg>
#include <cstring>
#include <cassert>
#include <cmath>
#include <Windows.h>

#if defined(_MSC_VER)
typedef __int8           int8_t;
typedef unsigned __int8  uint8_t;
typedef __int16          int16_t;
typedef unsigned __int16 uint16_t;
typedef __int32          int32_t;
typedef unsigned __int32 uint32_t;


// кажется MSVC не знает про snprintf, но там есть _snprintf
#define snprintf _snprintf

#elif defined(__MINGW32__)
#include <stdint.h>

#else
#error You must compile this code with MSVC or MinGW!
#endif

//#include "Logger.h"
#define ASSERT(x)          assert(x)

bool LoadFile(const char *fileName, bool binary, uint8_t **buffer, uint32_t *size);

#endif /* COMMON_H */
