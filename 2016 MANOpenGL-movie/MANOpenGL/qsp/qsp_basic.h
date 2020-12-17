//
// Quite SAMPLEPOOL source
//
// qsp_basic.h - functions for translating between:
// logariphmic scale <-> linear scale,
// linear scale <-> exponential scale,
// notes <-> frequencies,
// notes <-> playing speed;
// spline, random functions;
// clip function;	
//
// needs pow(), log(), exp(), rand() functions;

namespace QSP
{
	//
	// FREQUENCY AND NOTE NUMBERS:
	// 
	double FrequencyOfNote(double di)
	{
		return 440.0*pow(2.0, (di-57.0)/12.0);
	}

	//
	// PLAYING SPEED AND NOTE NUMBERS:
	// 
	double SpeedOfNote(double di)
	{
		return pow(2, (di-48.0)/12.0);
	}

	//
	// SPLINE FUNCTIONS:
	//
	double Spline_0_1(double x)
	{
		if (x>1) return 1.0;
		if (x<0) return 0.0;
		return -2.0*x*x*x + 3.0*x*x;
	}

	//
	// RANDOM VALUE FROM RANGE
	//
	double random(double min, double max)
	{
		return min + (max-min)*double(rand())/double(RAND_MAX);
	}

	// LINEAR -> LOGARIFMIC
	// LOGARIFMIC -> LINEAR 
	// 0..1 -> (0..1)=(-110dB .. 0dB)
	// >1 -> =1
	double LinToLog(double x)
	{
		if (x <= 0) return 0.0;
		if (x > 1.0) x = 1.0;
		double y = log(x);
		y += 9.0;
		if (y<0) y=0;
		return y/9.0;
	}

	double LogToLin(double l)
	{
		if (l==0) return 0;
		return exp(9.0*(l-1.0));
	}

	double SLinToLog(double x)
	{
		if (x<0) return -LinToLog(-x);
		return LinToLog(x);
	}

	double SLogToLin(double l)
	{	
		if (l<0) return -LogToLin(-l);
		return LogToLin(l);
	}

	double LinToLogF(double x)
	{
		if (x <= 0) return 0.0;
		if (x > 1.0) x = 1.0;
		double y = log(x);
		y += 6.0;
		if (y<0) y=0;
		return y/6.0;
	}

	double LogToLinF(double l)
	{
		if (l<=0) return 0.0;
		return exp(6.0*(l-1.0));
	}

	double SLinToLogF(double x)
	{	
		if (x<0) return -LinToLogF(-x);
		return LinToLogF(x);
	}

	double SLogToLinF(double l)
	{
		if (l<0) return -LogToLinF(-l);
		return LogToLinF(l);
	}

	///////////////////////////////
	// ClIP FUNCTION

	double Clip(double in)
	{
		if (in > 1) return 1;
		if (in < -1) return -1;
		return in;
	}
}