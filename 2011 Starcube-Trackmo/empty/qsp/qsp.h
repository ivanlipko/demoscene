// 
//// Quite SAMPLEPOOL header
// 
// Following functions and constants must be defined:
// sin(), cos(), tan(), abs()
// pow(double, double), pow(double, int)
// log(), exp(), floor()
// srand(), rand(), RAND_MAX, PI
// You can use this code to do it:

 #include <math.h>
 #include <stdlib.h>

 #ifndef PI
 #define PI				3.14159265358979
 #endif
//
//
//// You can disable some actions to make your code smaller:
//
// #define QSP_DISABLE_FFT
// #define QSP_DISABLE_EQ
// #define QSP_DISABLE_GRAIN
// #define QSP_DISABLE_CURVE
// #define QSP_DISABLE_TRACKER
//
//
//// Memory allocating mode:
//
// #define QSP_CREATE_ARRAYS_INSIDE
//

#ifndef QSP_INCLUDED
#define QSP_INCLUDED

// basic QSP functions:
#include "qsp_basic.h"
#include "qsp_interpolation.h"
#include "qsp_phase.h"
#include "qsp_osc.h"
#include "qsp_buffer.h"
#include "qsp_filter.h"
#include "qsp_fft.h"
#include "qsp_envelope.h"
#include "qsp_reverb.h"

// QSP-engine:
#include "qsp_engine.h"

#endif