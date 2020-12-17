//
// Quite SAMPLEPOOL source
//
// qsp_envelope.h - functions for envelopes
// 
//

#define QSP_SMOOTHPREC	10

namespace QSP
{
	///////////////////////////////////////////////////
	// ADSR-ENVELOPE

	double ADSR_ms(double a, double d, double s, double r, double pos)
	{
		a*=44.1;
		d*=44.1;

		if (pos < 0)		return 0.0;
		if (pos < a)		return pos/a;
		if (pos < a+d)		return (1.0-s)*(a+d-pos)/d + s;

		return s*pow(r, (pos-(a+d))*0.0001);
	}

	////////////////////////////////////////////////////
	// ENVELOPES:

	double LineEnv(double* X, double* Y, int size, double pos)
	{
		double dx, dposL, dposR;
		int i;

		for(i = 0; (i < size) && (X[i] < pos); i++);

		if (i == 0) return Y[0];
		if (i == size) return Y[size-1];

		dx = X[i] - X[i-1];
		dposL = pos - X[i-1];
		dposR = X[i] - pos;

		return (dposR*Y[i-1] + dposL*Y[i])/dx;
	}

	double LineEnvSym(double* X, double* Y, int size, double pos)
	{
		if (pos < 0) return -LineEnv(X, Y, size, -pos);
		return LineEnv(X, Y, size, pos);
	}

	double LadderEnv(double* X, double* Y, int size, double pos)
	{
		int i;

		for(i = 0; (i < size) && (X[i] < pos); i++);

		if (i == 0) return Y[0];
		return Y[i-1];
	}

	double SmoothEnvCycle(double* X, double* Y, int size, double pos, double smooth)
	{
		double val = 0, tpos;
		double mult = 1.0/QSP_SMOOTHPREC;

		for (int i=-QSP_SMOOTHPREC; i<QSP_SMOOTHPREC; i++)
		{
			tpos = pos + double(i)*smooth*mult;
			tpos -= floor(tpos);
			val += LineEnv(X, Y, size, tpos) * mult * 0.5;
		}
		
		return val;
	}

	double SmoothEnv(double* X, double* Y, int size, double pos, double smooth)
	{
		double val = 0;
		double mult = 1.0/QSP_SMOOTHPREC;

		for (int i=-QSP_SMOOTHPREC; i<QSP_SMOOTHPREC; i++)
		{
			val += LineEnv(X, Y, size, pos + double(i)*smooth*mult) * mult * 0.5;
		}
		
		return val;
	}

	double CurveEnvCycle(double* X, double* Y, int size, double pos)
	{
		double dx, dposL, dposR, yL, yR;
		int i;
	
		double lineval = LineEnv(X, Y, size, pos);

		for(i = 0; (i < size) && (X[i] < pos); i++);

		if (i == 0) return Y[0];
		if (i == size) return Y[size-1];

		if (size == 2) return Y[0];
		if (i==1)
		{
			dx = X[size-1] - X[size-2];
			dposL = pos - X[i-1] + dx;
			dposR = X[i-1] - pos;
			if (dx == 0) yL = Y[size-1];
			else yL = (dposR*Y[size-2] + dposL*Y[i-1])/dx;

			dx = X[i+1] - X[i];
			dposL = pos - X[i];
			dposR = X[i+1] - pos;
			if (dx == 0) yR = Y[i];
			else yR = (dposR*Y[i] + dposL*Y[i+1])/dx;

			dx = X[i] - X[i-1];
			dposL = pos - X[i-1];
			dposR = X[i] - pos;
			return 0.5*lineval + 0.5*(Spline_0_1(dposR/dx)*yL + Spline_0_1(dposL/dx)*yR);
		}//i==1

		if (i==size-1)
		{
			dx = X[i-1] - X[i-2];
			dposL = pos - X[i-2];
			dposR = X[i-1] - pos;
			if (dx == 0) yL = Y[i-1];
			else yL = (dposR*Y[i-2] + dposL*Y[i-1])/dx;

			dx = X[1] - X[0];
			dposL = pos - X[i];
			dposR = X[i] - pos + dx;
			if (dx == 0) yR = Y[1];
			else yR = (dposR*Y[i] + dposL*Y[0])/dx;

			dx = X[i] - X[i-1];
			dposL = pos - X[i-1];
			dposR = X[i] - pos;
			return 0.5*lineval + 0.5*(Spline_0_1(dposR/dx)*yL + Spline_0_1(dposL/dx)*yR);
		}//i==size-1

		dx = X[i-1] - X[i-2];
		dposL = pos - X[i-2];
		dposR = X[i-1] - pos;
		if (dx == 0) yL = Y[i-1];
		else yL = (dposR*Y[i-2] + dposL*Y[i-1])/dx;

		dx = X[i+1] - X[i];
		dposL = pos - X[i];
		dposR = X[i+1] - pos;
		if (dx == 0) yR = Y[i];
		else yR = (dposR*Y[i] + dposL*Y[i+1])/dx;

		dx = X[i] - X[i-1];
		dposL = pos - X[i-1];
		dposR = X[i] - pos;
		return 0.5*lineval + 0.5*(Spline_0_1(dposR/dx)*yL + Spline_0_1(dposL/dx)*yR);
	}

	double CurveEnv(double* X, double* Y, int size, double pos)
	{
		double dx, dposL, dposR, yL, yR;
		int i;
	
		double lineval = LineEnv(X, Y, size, pos);

		for(i = 0; (i < size) && (X[i] < pos); i++);

		if (i == 0) return Y[0];
		if (i == size) return Y[size-1];

		if (size == 2) return lineval;
		if (i==1)
		{
			yL = Y[0];
			
			dx = X[i+1] - X[i];
			dposL = pos - X[i];
			dposR = X[i+1] - pos;
			if (dx == 0) yR = Y[i];
			else yR = (dposR*Y[i] + dposL*Y[i+1])/dx;

			dx = X[i] - X[i-1];
			dposL = pos - X[i-1];
			dposR = X[i] - pos;
			return 0.5*lineval + 0.5*(Spline_0_1(dposR/dx)*yL + Spline_0_1(dposL/dx)*yR);
		}//i==1

		if (i==size-1)
		{
			dx = X[i-1] - X[i-2];
			dposL = pos - X[i-2];
			dposR = X[i-1] - pos;
			if (dx == 0) yL = Y[i-1];
			else yL = (dposR*Y[i-2] + dposL*Y[i-1])/dx;

			yR = Y[size-1];

			dx = X[i] - X[i-1];
			dposL = pos - X[i-1];
			dposR = X[i] - pos;
			return 0.5*lineval + 0.5*(Spline_0_1(dposR/dx)*yL + Spline_0_1(dposL/dx)*yR);
		}//i==size-1

		dx = X[i-1] - X[i-2];
		dposL = pos - X[i-2];
		dposR = X[i-1] - pos;
		if (dx == 0) yL = Y[i-1];
		else yL = (dposR*Y[i-2] + dposL*Y[i-1])/dx;

		dx = X[i+1] - X[i];
		dposL = pos - X[i];
		dposR = X[i+1] - pos;
		if (dx == 0) yR = Y[i];
		else yR = (dposR*Y[i] + dposL*Y[i+1])/dx;

		dx = X[i] - X[i-1];
		dposL = pos - X[i-1];
		dposR = X[i] - pos;
		return 0.5*lineval + 0.5*(Spline_0_1(dposR/dx)*yL + Spline_0_1(dposL/dx)*yR);
	}
}
