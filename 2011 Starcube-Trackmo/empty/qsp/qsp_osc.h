//
// Quite SAMPLEPOOL source
//
// qsp_osc.h - functions for oscillators
// needs sin() function
//
// Phase = 0..1
// Do not put values out of range 0..1 !
// Use Phase -= floor(Phase) before call function or use qsp_phase.h functions.

namespace QSP
{
	double OSine(double Phase)
	{
		return sin(Phase*2.0*PI);
	}

	double OTriangle(double Phase)
	{
		if (Phase < 0.25) return 4.0*Phase;
		if (Phase < 0.75) return 2.0 - 4.0*Phase;
		return 4.0*Phase - 4.0;
	}

	double OSaw(double Phase)
	{
		return 1.0 - 2.0*Phase;
	}

	double OPulse(double Phase)
	{
		if (Phase < 0.5) return 1.0;
		return -1.0;
	}
}