//
// Quite SAMPLEPOOL source
//
// qsp_interpolation.h - functions for interpolation
// (at the moment only linear)
//
// 'len' must be > 1

namespace QSP
{
	double ValueCycle(double* wave, int len, double pos)
	{
		int xL, xR;
		
		pos = fmod(pos, double(len)) + double(len);
		pos = fmod(pos, double(len));
	
		xL = int(floor(pos));
		xR = (xL + 1) % len;

		return (1.0 - pos + double(xL))*wave[xL] + (pos - double(xL))*wave[xR];
	}

	double Value(double* wave, int len, double pos)
	{
		int xL, xR;
		
		if (pos < 0) return 0.0;
		if (pos > len-1) return 0.0;
		if (pos == len-1) return wave[len-1];
	
		xL = int(floor(pos));
		xR = xL + 1;

		return (1.0 - pos + double(xL))*wave[xL] + (pos - double(xL))*wave[xR];
	}
}