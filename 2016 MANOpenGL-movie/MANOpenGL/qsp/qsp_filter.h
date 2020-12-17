//
// Quite SAMPLEPOOL source
//
// qsp_filter.h - functions for realtime filters
// needs tan() function;

#define QSP_FILTERS		30

namespace QSP
{
	double f_ip[QSP_FILTERS];	// input previous value
	double f_ipp[QSP_FILTERS];	// input preprevious value
	double f_op[QSP_FILTERS];	// output previous value
	double f_opp[QSP_FILTERS];	// output preprevious value

	inline void NullFilters()
	{
		for (int ID = 0; ID < QSP_FILTERS; ID++)
		{
			f_ipp[ID] = 0;
			f_ip[ID] = 0;
			f_opp[ID] = 0;
			f_op[ID] = 0;
		}
	}

	double LPFilter(int ID, double in, double freq, double reso)
	// freq 0..1 = 0Hz..22050Hz <- half-samplerate
	// reso 0..1, 0 = no resonance
	{
		double f, r, c;
		double a1, a2, a3, b1, b2;
		double va;

		f = 0.5 * freq;
		if (f>0.5) f = 0.5;
		if (f<0) f = 0;
		
		r = (1.0 - reso) * 1.4142135623;

		c = 1.0 / tan(PI * f);

		a1 = 1.0 / ( 1.0 + r * c + c * c);
		a2 = 2* a1;
		a3 = a1;
		b1 = 2.0 * ( 1.0 - c*c) * a1;
		b2 = ( 1.0 - r * c + c * c) * a1;

		va = a1 * in + a2 * f_ip[ID] + a3 * f_ipp[ID] - b1*f_op[ID] - b2*f_opp[ID];

		f_ipp[ID] = f_ip[ID];
		f_ip[ID] = in;

		f_opp[ID] = f_op[ID];
		f_op[ID] = va;

		return va;	
	}

	double HPFilter(int ID, double in, double freq, double reso)
	// freq 0..1 = 0Hz..22050Hz
	// reso 0..1, 0 = no resonance
	{
		double f, r, c;
		double a1, a2, a3, b1, b2;
		double va;

		f = 0.5 * freq;
		if (f>0.5) f = 0.5;
		if (f<0) f = 0;
		
		r = (1.0 - reso) * 1.4142135623;

		c = tan(PI * f);

		a1 = 1.0 / ( 1.0 + r * c + c * c);
		a2 = -2*a1;
		a3 = a1;
		b1 = 2.0 * ( c*c - 1.0) * a1;
		b2 = ( 1.0 - r * c + c * c) * a1;

		va = a1 * in + a2 * f_ip[ID] + a3 * f_ipp[ID] - b1*f_op[ID] - b2*f_opp[ID];

		f_ipp[ID] = f_ip[ID];
		f_ip[ID] = in;

		f_opp[ID] = f_op[ID];
		f_op[ID] = va;

		return va;
	}
}