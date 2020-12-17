//
// Quite SAMPLEPOOL source
//
// qsp_osc.h - functions for using phases and positions
//
// phase	is in range 0..1
// pos		is in range 0..+inf (in samples: i.e. 44100 * length_in_seconds)


#define QSP_PHASES		20
#define QSP_SAMPLERATE	44100

namespace QSP
{
	double ophase[QSP_PHASES];

	inline void NullPhases()
	{
		for (int i=0; i < QSP_PHASES; i++)
			ophase[i] = 0;
	}

	double MovePhase(int ID, double Hz)
	{
		double result = ophase[ID];
		ophase[ID] += Hz/double(QSP_SAMPLERATE);
		ophase[ID] -= floor(ophase[ID]);
		return result;
	}

	double MovePos(int ID, double speed)
	{
		double result = ophase[ID];
		ophase[ID] += speed;
		return result;
	}
}