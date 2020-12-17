//
// Quite SAMPLEPOOL source
//
// qsp_reverb.h - functions for reverb and chorus:
// low-frequency noise, allpass delays
// needs rand() function

#define QSP_LFNS	20

namespace QSP
{
	/////////////////////////////////////////////////////////////////
	// Low Frequency Noise

	int LFNoiseBuffer[QSP_LFNS];

	inline void NullLFNoise()
	{
		for (int i=0; i<QSP_LFNS; i++)
			LFNoiseBuffer[i] = 0;
	}

	double LFNoise(int ID, int range)
	{
		if (double(rand())/double(RAND_MAX) > 0.5) LFNoiseBuffer[ID]++;
		else LFNoiseBuffer[ID]--;

		if (LFNoiseBuffer[ID] > range) LFNoiseBuffer[ID] = range;
		if (LFNoiseBuffer[ID] < 0) LFNoiseBuffer[ID] = 0;

		return double(LFNoiseBuffer[ID])/double(range);
	}

	double LFNoiseCycle(int ID, int range)
	{
		if (double(rand())/double(RAND_MAX) > 0.5) LFNoiseBuffer[ID]++;
		else LFNoiseBuffer[ID]--;

		LFNoiseBuffer[ID] += range;
		LFNoiseBuffer[ID] %= range;

		return double(LFNoiseBuffer[ID])/double(range);
	}

	/////////////////////////////////////////////////////
	//         ALLPASSFILTERS
	//
	double AllPassFilter(int b, double in, double delay, double diff)
	{
		double out	= diff*BufferValue(b, delay);
		WriteToBuffer(b, -out+in);

		if (diff == 0) return 0.0;
		return (1.0/diff - 1.0)*out;
	}
	
	double AllPassFilterTMod(int ID, int b, double in, double delay, double dt60, double Hz, double part)
	{
		double lfn = LFNoiseCycle(ID, 100);
		lfn = LPFilter(ID, lfn, Hz/(delay*22050.0), 0);
		return AllPassFilter(b, in, delay*(1.0 + part*OSine(lfn)), exp(-6.0*delay*(1.0 + part*OSine(lfn))/dt60));
	}
}