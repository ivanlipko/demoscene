//
// Quite SAMPLEPOOL source
//
// qsp_engine.h - sample generation engine
// 
// needs pow(double, int), abs()

// Action types:
// GENERATORS:
#define QSPT_Perc		0

#define QSPT_Sine		129  // 1 + 128 "fixed note"
#define QSPT_Triangle	130  // 2 + 128 "fixed note"
#define QSPT_Saw		131  // 3 + 128 "fixed note"
#define QSPT_Pulse		132  // 4 + 128 "fixed note"
#define QSPT_Noise		5

#define QSPT_FFT		134  // 6 + 128 "fixed note"
#define QSPT_Tracker	7 
#define QSPT_Copy		8 
#define QSPT_Mixer		9 

#define QSPT_EnvLadder	138  // 10 + 128 "fixed note"
#define QSPT_EnvLine	139  // 11 + 128 "fixed note"
#define QSPT_EnvCurve	140  // 12 + 128 "fixed note"
#define QSPT_EnvSmooth	141  // 13 + 128 "fixed note"


// MODIFIERS:
#define QSPT_Physio		78 	// 14 + 64 "in -> out"
#define QSPT_EQ			15 
#define QSPT_Comp		80 	// 16 + 64 "in -> out"
#define QSPT_Distortion	81 	// 17 + 64 "in -> out"
#define QSPT_Chorus		82  // 18 + 64 "in -> out"
#define QSPT_Flanger	83  // 19 + 64 "in -> out"
#define QSPT_Reverb		84  // 20 + 64 "in -> out"
#define QSPT_Mod		21 
#define QSPT_Grain		22 
#define QSPT_Amp		87 	// 23 + 64 "in -> out"
#define QSPT_Pitch		24
#define QSPT_Filter		89 	// 25 + 64 "in -> out"

#define QSPT_Invert		90 	// 26 + 64 "in -> out"
#define QSPT_Reverse	27
#define QSPT_Normalize	92 	// 28 + 64 "in -> out"
#define QSPT_Cut		29

#define QSPT_Pluck		94 	// 30 + 64 "in -> out"
#define QSPT_Close		31

namespace QSP
{
	////////////////////////////////////////////////////////
	// NUMBER OF FLOATING-POINT ARGUMENTS OF ACTION:
	char REALNUM[] = {
					14,	//QSPT_Perc			0 (len

					4,	//QSPT_Sine			1 (len
					4,	//QSPT_Triangle		2 (len
					4,	//QSPT_Saw			3 (len
					4,	//QSPT_Pulse		4 (len
					4,	//QSPT_Noise		5 (len

					7,	//QSPT_FFT			6 (len	
					0,	//QSPT_Tracker		7
					0,	//QSPT_Copy			8
					8,	//QSPT_Mixer		9

					3,	//QSPT_EnvLadder	10 (len
					3,	//QSPT_EnvLine		11 (len
					3,	//QSPT_EnvCurve		12 (len
					3,	//QSPT_EnvSmooth	13 (len

					2,	//QSPT_Physio		14
					10,	//QSPT_EQ			15
					5,	//QSPT_Comp			16
					3,	//QSPT_Distortion	17
					6,	//QSPT_Chorus		18
					5,	//QSPT_Flanger		19
					9,	//QSPT_Reverb		20
					10,	//QSPT_Mod			21
					15,	//QSPT_Grain		22 (len
					1,	//QSPT_Amp			23
					1,	//QSPT_Pitch		24
					0,	//QSPT_Filter		25
					0,	//QSPT_Invert		26
					0,	//QSPT_Reverse		27
					0,	//QSPT_Normalize	28
					0,	//QSPT_Cut			29
					6,	//QSPT_Pluck		30
					0	//QSPT_Close		31
	};//REALNUM DEFINITION

	////////////////////////////////////////////////////////
	// NUMBER OF SMALL INTEGER (0..256) ARGUMENTS OF ACTION:
	char CHARNUM[] = {
					4,	//QSPT_Perc			0 (tone, noise, tonefilt

					1,	//QSPT_Sine			1 (note
					1,	//QSPT_Triangle		2 (note
					1,	//QSPT_Saw			3 (note
					1,	//QSPT_Pulse		4 (note
					1,	//QSPT_Noise		5 (note

					3,	//QSPT_FFT			6 (note, envlen,	
					3,	//QSPT_Tracker		7 (channels, rows, spd)
					1,	//QSPT_Copy			8 (source)
					8,	//QSPT_Mixer		9 (channel samplenumbers)

					2,	//QSPT_EnvLadder	10 (note, envlen
					2,	//QSPT_EnvLine		11 (note, envlen
					2,	//QSPT_EnvCurve		12 (note, envlen
					2,	//QSPT_EnvSmooth	13 (note, envlen

					4,	//QSPT_Physio		14 (..., env1len, env2len, env3len)
					0,	//QSPT_EQ			15
					2,	//QSPT_Comp			16 (..., envlen
					2,	//QSPT_Distortion	17 (..., envlen
					1,	//QSPT_Chorus		18
					0,	//QSPT_Flanger		19
					0,	//QSPT_Reverb		20
					1,	//QSPT_Mod			21 (modulator id)
					0,	//QSPT_Grain		22
					2,	//QSPT_Amp			23 (..., envlen
					2,	//QSPT_Pitch		24 (..., envlen
					3,	//QSPT_Filter		25 (type, env1len, env2len)
					0,	//QSPT_Invert		26
					0,	//QSPT_Reverse		27
					0,	//QSPT_Normalize	28
					0,	//QSPT_Cut			29
					1,	//QSPT_Pluck		30
					0	//QSPT_Close		31
	};//CHARNUM DEFINITION

	//////////////////////////////////////////////////////////////
	/// SAMPLEGENERATION FUNCTION
	///
	void GenerateSamples(
					int poollen,				// <- number of actions
					int samplenum,				// <- number of samples

					float*			realdata,		// <- data for actions
					int*			intdata,		// <- 
					unsigned char*	chardata,		// <- 

					unsigned char*	actions,		// <- actionlist
					unsigned char*	dest,			// <- destination for actions
					
												// RESULTS:
					double**	&output,		// <- array of samples [samplenum+1], output[0]==NULL,
												// can be created inside function with 'new' operator.
												// define QSP_CREATE_ARRAYS_INSIDE macro
					int*		&outlen			// <- array of sample length [samplenum+1]
												// can be created inside function with 'new' operator.
												// define QSP_CREATE_ARRAYS_INSIDE macro
					)
	//////////////////////////////////////////////////////////////
	{
		int i, j;

		double	dArg[30];
		int		iArg[30];
		int		cArg[30];

		//variables for reverb:
		double rev[5];

		#ifndef QSP_DISABLE_TRACKER
		char	pattern[8000];
		//variables for tracker:
		int		ChIsOn[16];
		int		ChSmp[16];
		double	ChNote[16];
		//double	ChNoteNext[16];
		double	ChAmp[16];
		double	ChAmpNext[16];
		int		nowrow = -1;
		double	onerow;
		char	tnote, tamp, tsmp;
		#endif

		double X1[256];
		double Y1[256];
		double X2[256];
		double Y2[256];
		double X3[256];
		double Y3[256];

		int realoffset		=	0;
		int intoffset		=	0;
		int charoffset		=	0;

		int LEN;
		double qIN, qOUT;
		double OUT2, AMP, AMP2, PHASE, PHASE1, FM;

		#ifndef QSP_DISABLE_FFT
		//variables for FFT:
		double a[128];
		double b[129];
		#endif

		#ifndef QSP_DISABLE_GRAIN
		//variables for GRAIN:
		// internal:
		bool	grain[6];
		double  gr_amp[6];
		double  gr_attack[6];
		double	gr_release[6];
		double	gr_offset[6];
		double	gr_pitch[6];
		double	gr_lifetime[6];
		double	gr_slide[6];
		int		nextcount;
		#endif

		#ifndef QSP_DISABLE_EQ
		//variables for EQ:
		double temp[257];
		//frequences of low band limits
		double f1[9] = {	
							20.0, 
							100.0, 
							200.0, 
							400.0, 
							900.0,
							1900.0,
							3900.0,
							7000.0,
							15000.0
		};
		//frequences of high band limits
		double f2[9] = {	
							80.0, 
							150.0, 
							300.0, 
							600.0, 
							1100.0,
							2100.0,
							4100.0,
							9000.0,
							17000.0
		};
		
		for(i=0; i<9; i++)
		{
			f2[i] *= PI/22050.0;
			f1[i] *= PI/22050.0;
		}

		#endif

		InitBuffers();

		#ifdef QSP_CREATE_ARRAYS_INSIDE
		// create pointers to samples:
		outlen = new int [samplenum+1];
		output = new double* [samplenum+1];
		for (i = 0; i <= samplenum; i++)
		{
			output[i] = 0;
			outlen[i] = 0;
		}
		#endif

		///////////////////////////////////////////////////
		///////////////////////////////////////////////////
		// BIG BIG BIG CYCLE VIA ACTIONS
		// WE GENERATE HERE SAMPLES ACTION BY ACTION!
		for (int iAction = 0; iAction < poollen; iAction++)
		{
			////////////////////////////////////////////////
			////////////////////////////////////////////////
			//Filling floating-point arguments:
			for(i = 0; i < REALNUM[actions[iAction]%64]; i++)
				dArg[i] = realdata[i + realoffset];
			realoffset += REALNUM[actions[iAction]%64];

			////////////////////////////////////////////////
			////////////////////////////////////////////////
			//Filling small integer arguments:
			for(i = 0; i < CHARNUM[actions[iAction]%64]; i++)
				cArg[i] = chardata[i + charoffset];
			charoffset += CHARNUM[actions[iAction]%64];

			////////////////////////////////////////////////
			////////////////////////////////////////////////
			// loading patterndata, big integer and envelopes:
			switch(actions[iAction])
			{

			#ifndef QSP_DISABLE_TRACKER
			//LOADING PATTERNDATA:
			case QSPT_Tracker:
				for (i=0; i<8000; i++)
					pattern[i] = 0;
				for (i=0; i < cArg[0]*cArg[1]*5; i++)
					pattern[i] = chardata[i + charoffset];
				charoffset += cArg[0]*cArg[1]*5;
				iArg[0] = intdata[intoffset];
				intoffset++;
				// AND PREPARING FOR TRACKER:
				onerow = 44100.0*60.0*double(cArg[2])/(double(iArg[0])*4.0*6.0);
				nowrow = -1;
				for (i=0; i<16; i++)
					ChIsOn[i] = 0;
				break;
			#endif

			//LOADING THIRD ENVELOPE
			case QSPT_Physio:		
				for(i = 0; i < cArg[3]; i++)
				{
					X3[i] = realdata[i*2 + realoffset];
					Y3[i] = realdata[i*2 + 1 + realoffset];
				}
				realoffset += 2*cArg[3];			
			
			//LOADING SECOND ENVELOPE
			case QSPT_Filter:
				for(i = 0; i < cArg[2]; i++)
				{
					X2[i] = realdata[i*2 + realoffset];
					Y2[i] = realdata[i*2 + 1 + realoffset];
				}
				realoffset += 2*cArg[2];
			
			//LOADING FIRST ENVELOPE:
			case QSPT_FFT:
			case QSPT_EnvLadder:
			case QSPT_EnvLine:
			case QSPT_EnvCurve:
			case QSPT_EnvSmooth:
			case QSPT_Comp:
			case QSPT_Distortion:
			case QSPT_Amp:
			case QSPT_Pitch:
				for(i = 0; i < cArg[1]; i++)
				{
					X1[i] = realdata[i*2 + realoffset];
					Y1[i] = realdata[i*2 + 1 + realoffset];
				}
				realoffset += 2*cArg[1];
				break;
			
			//CUTTING EDGES?
			case QSPT_Cut:
				iArg[0] = intdata[intoffset];		//start
				iArg[1] = intdata[1 + intoffset];	//end
				intoffset++;
				intoffset++;
				break;
			}
			
			/////////////////////////////////////////////////
			/////////////////////////////////////////////////
			/// Refresh all: clear buffers, phases, etc.
			NullBuffers();
			NullFilters();
			NullLFNoise();
			NullPhases();
			NullFilters();
			srand(0);
			OUT2 = 0;
			PHASE = 0;
			PHASE1 = 0;
			AMP = 0;
			AMP2 = 0;

			/////////////////////////////////////////////////
			/////////////////////////////////////////////////
			/// Preparing something if we need:
			#ifndef QSP_DISABLE_FFT
			if (actions[iAction] == QSPT_FFT)
			{// dArg[1..6]: amp, phase, random, combA, combF, combP
			 // cArg[2]: decaytype
				a[0] = 0;
				a[1] = 0;
				
				for(i=0; i<63; i++)
				{
					PHASE += dArg[2]*PI;
					PHASE1 = (1.0-dArg[3])*PHASE + dArg[3]*random(0,1)*2.0*PI;
					AMP2 = 1.0/double(i+1);

					AMP = LineEnv(X1, Y1, cArg[1], double(i*5 + 2)/320.0);
					AMP *= abs(0.5*dArg[4]*OSine(dArg[6] + 32.0*dArg[5]*double(i*5 + 2)/320.0) + (1.0-0.5*dArg[4]));

					switch(cArg[2])
					{
					case 0:
						AMP *= 0.15;
						break;
					case 1:
						AMP *= AMP2*0.5;
						break;
					case 2:
						AMP *= AMP2*AMP2;
						break;
					case 3:
						AMP *= 1.0/log(double(100.0*i+10));
						break;		
					}

					a[2 + 2*i] = dArg[1]*AMP*sin(PHASE1);
					a[3 + 2*i] = dArg[1]*AMP*cos(PHASE1);

					DFT(a,b,128);
					b[128] = b[0];
				}
			}
			#endif

			#ifndef QSP_DISABLE_EQ
			if (actions[iAction] == QSPT_EQ)
			{

				dArg[9] = pow(100.0, (1.0/200.0)*(dArg[9]-200))-0.01;

				for (i=0; i<257; i++)
				{
					temp[i] = 0;
				}

				temp[128] = dArg[9];
				for (j=8; j>=0; j--)
				{
					dArg[j] = pow(100.0, (1.0/200.0)*(dArg[j]-200))-0.01;
					AMP = (dArg[j] - dArg[j+1])/PI;
	
					temp[128] += AMP*0.5*(f2[j]+f1[j]);
					for (i=1; i<129; i++)
					{
						AMP2 = PI/(f2[j]-f1[j]);
						AMP2 = 1.0/(2.0*i) + 0.25*(1.0/(AMP2-i) - 1.0/(AMP2+i));
						AMP2 *= sin(f2[j]*i) + sin(f1[j]*i);
						temp[128-i] += AMP*AMP2;
						temp[128+i] += AMP*AMP2;
					}
				}
			}
			#endif

			#ifndef QSP_DISABLE_GRAIN
			if (actions[iAction] == QSPT_Grain)
			{
				grain[0] = false;
				grain[1] = false;
				grain[2] = false;
				grain[3] = false;
				grain[4] = false;
				grain[5] = false;
				nextcount = 0;
			}
			#endif



			/////////////////////////////////////////////////
			/////////////////////////////////////////////////
			/// Define length of result:
			switch(unsigned char(actions[iAction]))
			{
			case QSPT_Perc:		
			case QSPT_Sine:		
			case QSPT_Triangle:
			case QSPT_Saw:	
			case QSPT_Pulse:		
			case QSPT_Noise:	
			case QSPT_FFT:
			case QSPT_EnvLadder:
			case QSPT_EnvLine:
			case QSPT_EnvCurve:
			case QSPT_EnvSmooth:
			case QSPT_Grain:
				LEN = int(44100.0*dArg[0]);
				break;
			case QSPT_Copy:
				LEN = outlen[cArg[0]];
				break;
			case QSPT_Mixer:
				LEN = 0;
				for (i=0; i<8; i++)
					if ((cArg[i])&&(outlen[cArg[i]] > LEN)) LEN = outlen[cArg[i]];
				break;
			case QSPT_Cut:
				LEN = iArg[1] - iArg[0] + 1;
				break;
			case QSPT_Tracker:
				LEN = int(onerow*cArg[1]);
				break;
			default:
				LEN = outlen[dest[iAction]];
			}

			/////////////////////////////////////////////
			/////////////////////////////////////////////
			/// if we are normalizing wave:
			if (actions[iAction] == QSPT_Normalize)
			{
				for (i=0; i<LEN; i++)
					if (abs(output[dest[iAction]][i]) > AMP ) AMP = abs(output[dest[iAction]][i]);
				if (AMP > 0) AMP = 1.0/AMP;
			}

			/////////////////////////////////////////////
			/////////////////////////////////////////////
			/// Closing sample
			if (actions[iAction] == QSPT_Close)
			{
				if (outlen[dest[iAction]]) delete [] output[dest[iAction]]; 
				outlen[dest[iAction]] = 0;
				continue;
			}

			/////////////////////////////////////////////
			/////////////////////////////////////////////
			/// resizing temporarly wave - output[0] 
			if (outlen[0] > 0) delete [] output[0]; 
			output[0] = new double [LEN];
			outlen[0] = LEN;

			/////////////////////////////////////////////
			/////////////////////////////////////////////
			/// HEART OF ENGINE - GENERATION CYCLE:
			/// write temporarly to output[0] 
			for (i=0; i<LEN; i++)
			{
				///if action have "in -> out" model
				if (actions[iAction] & 64)
					qIN = output[dest[iAction]][i];

				//ACT!
				switch(int(actions[iAction]))
				{
				case QSPT_Perc:
				// dArg[1..4]: tpitch, tdecay, trelease, tsustain
				// dArg[5..6]: nattack, nrelease
				// dArg[7..11]: nlp, nhp, nlenv, nhenv, nreso
				// dArg[12..13]: noiseamp, toneamp
				// cArg[0..3]: tone, noise, tonefilt, softfilt
							
					AMP = ADSR_ms(dArg[5]*1000.0, 0, 1, dArg[6]*dArg[6], i);
					AMP2 = ADSR_ms(0, dArg[2]*1000.0, dArg[4], dArg[3], i);

					OUT2 = double(cArg[0])*dArg[13]*OSine(ophase[0])*AMP2;
					qOUT = double(cArg[1])*AMP*dArg[12]*random(-1.0, 1.0);
					qOUT += double(cArg[2])*OUT2;

					qOUT = HPFilter(0, qOUT, LogToLinF(dArg[8]) * (1.0 + dArg[10]*AMP), dArg[11]);
					qOUT = LPFilter(1, qOUT, LogToLinF(dArg[7]) * (1.0 + dArg[9]*AMP), dArg[11]);
					
					if (cArg[3] == 0)
					{
						qOUT = HPFilter(2, qOUT, LogToLinF(dArg[8]) * (1.0 + dArg[10]*AMP), dArg[11]);
						qOUT = LPFilter(3, qOUT, LogToLinF(dArg[7]) * (1.0 + dArg[9]*AMP), dArg[11]);					
					}
					qOUT = Clip(qOUT);
					MovePhase(0, dArg[1]*AMP2);
					qOUT += double(1-cArg[2])*OUT2;
					break;

				case QSPT_Sine:
				case QSPT_Triangle:
				case QSPT_Saw:
				case QSPT_Pulse:
				case QSPT_Noise:
				// dArg[1..3]: xD, yD, Amp:
				// cArg[0]: note;
					if (dArg[1] > 0.5)
						PHASE = (1.0 - dArg[1])*2.0*ophase[0] + (dArg[1]-0.5)*2.0*pow(ophase[0], 6);
					else
						PHASE = dArg[1]*2.0*ophase[0] + (0.5-dArg[1])*2.0*(1.0 - pow(ophase[0]-1.0, 6));

					switch(actions[iAction])
					{
					case QSPT_Sine:
						qOUT = OSine(PHASE);
						break;
					case QSPT_Triangle:
						qOUT = OSine(PHASE);
						break;
					case QSPT_Saw:
						qOUT = OSine(PHASE);
						break;
					case QSPT_Pulse:
						qOUT = OSine(PHASE);
						break;
					case QSPT_Noise:
						qOUT = random(-1.0, 1.0);
						break;
					}

					if (dArg[2] < 0.5) qOUT = dArg[2]*2.0*qOUT + (0.5 - dArg[2])*2.0*pow(qOUT, 5);
					else 
					{
						OUT2 = abs(qOUT);
						OUT2 = (1.0 - dArg[2])*2.0*OUT2 + (dArg[2] - 0.5)*2.0*(1.0 - pow(OUT2-1.0, 6));
						if (qOUT < 0) qOUT = -OUT2;
						else qOUT = OUT2;
					}

					qOUT *= dArg[3];
					break;

				#ifndef QSP_DISABLE_FFT
				case QSPT_FFT:
				// dArg[1..6]: amp, phase, random, combA, combF, combP
					qOUT = ValueCycle(b, 128, 128.0*ophase[0]);
					break;
				#endif

				#ifndef QSP_DISABLE_TRACKER
				case QSPT_Tracker:
				//cArg[0..2]: channels, rows, spd
				//iArg[0]: bpm
					qOUT = 0;
					// STEP OVER ROW:
					if ( nowrow != floor(double(i)/onerow) )
					{
						nowrow = int(floor(double(i)/onerow));
						for (j=0; j < cArg[0]; j++)
						{
							tnote = pattern[5*nowrow*cArg[0] + 5*j];
							tamp  = pattern[5*nowrow*cArg[0] + 5*j + 2];
							tsmp  = pattern[5*nowrow*cArg[0] + 5*j + 1];

							// define start params;
							if (tnote != 0)
							{
								ChIsOn[j] = 1;
								ChNote[j] = tnote;
								ophase[j] = 0;
								ChSmp[j] = tsmp;
								if (!tsmp) ChIsOn[j] = 0;
								if (tamp == 0) ChAmp[j] = 1;
								else ChAmp[j] = double(tamp-1)/99.0;
							}
							else if (tamp != 0) ChAmp[j] = double(tamp-1)/99.0;
							
							// define next params:
							tnote = pattern[cArg[0]*5 + nowrow*cArg[0]*5 + 5*j];
							tamp  = pattern[cArg[0]*5 + nowrow*cArg[0]*5 + 5*j + 2];
							tsmp  = pattern[cArg[0]*5 + nowrow*cArg[0]*5 + 5*j + 1];
				
							if (tnote != 0)	ChAmpNext[j] = 0;
							else if (tamp != 0) ChAmpNext[j] = double(tamp-1)/99.0;
							else ChAmpNext[j] = ChAmp[j];
						}
					}// step over row

					// MIXING:
					PHASE = double(i)/onerow - double(nowrow);
					for (j=0; j < cArg[0]; j++)
					{
						if (ChIsOn[j])
						{
							OUT2 = Value(output[ChSmp[j]], outlen[ChSmp[j]], ophase[j]);
							MovePos(j, pow(2, double(ChNote[j]-48)/12.0));
							qOUT += OUT2*((1.0 - PHASE)*ChAmp[j] + PHASE*ChAmpNext[j]);
						}			
					}
					break;
				#endif

				case QSPT_Copy:
					qOUT = output[cArg[0]][i];
					break;

				case QSPT_Mixer:
					qOUT = 0;
					for (j = 0; j < 8; j++)
						if (cArg[j]) qOUT += dArg[j]*output[cArg[j]][i];
					break;

				case QSPT_EnvLadder:
					qOUT = dArg[1]*LineEnv(X1, Y1, cArg[1], ophase[0]);
					break;
				case QSPT_EnvLine:
					qOUT = dArg[1]*LadderEnv(X1, Y1, cArg[1], ophase[0]);
					break;

				#ifndef QSP_DISABLE_CURVE
				case QSPT_EnvCurve:
					qOUT = dArg[1]*CurveEnvCycle(X1, Y1, cArg[1], ophase[0]);
					break;
				#endif

				case QSPT_EnvSmooth:
					//darg[1] - amp
					//dArg[2] - smooth 
					qOUT = dArg[1]*SmoothEnvCycle(X1, Y1, cArg[1], ophase[0], dArg[2]);
					break;
				
				case QSPT_Physio:
				// dArg[0..1]: fricamp, springamp
					//distortion:
					if (log(abs(qIN)) > -6.0) qIN = SLogToLinF(LineEnvSym(X1, Y1, cArg[1], SLinToLogF(qIN)));
					//spring:
					PHASE1 += -0.09*LogToLin(dArg[1])*SLogToLin(LineEnvSym(X3, Y3, cArg[3], SLinToLog(PHASE)));
					//friction:
					AMP = 1.0 - LogToLin(dArg[0])*abs(SLogToLinF(LineEnvSym(X2, Y2, cArg[2], SLinToLogF(100*(PHASE1 + (qIN - OUT2))))));
					PHASE = PHASE + AMP*(PHASE1 + (qIN - OUT2));
					PHASE1 *= AMP*0.999;
					OUT2 = qIN;
					qOUT = PHASE;
					break;

				#ifndef QSP_DISABLE_EQ
				case QSPT_EQ:
				// dArg[0..9]: band[0] ... band[9]
					qOUT = 0;
					for (j=-128; j<129; j++)
						qOUT += Value(output[dest[iAction]], outlen[dest[iAction]], i+j)*temp[j+128];
					qOUT = Clip(qOUT);
					break;
				#endif

				case QSPT_Comp:
				//dArg[0..4]: attack, release, lp, hp, amp
					qOUT = LPFilter(0, qIN, LogToLinF(dArg[2]), 0);
					qOUT = HPFilter(1, qOUT, LogToLinF(dArg[3]), 0);
					OUT2 = qIN - qOUT;
		
					if (abs(qOUT) > AMP) AMP = abs(qOUT);

					AMP2 = LogToLin(1.0-dArg[1]);
					AMP	= (1.0-AMP2)*AMP + AMP2*dArg[0]*(abs(qOUT));
							
					if (AMP != 0) qOUT *= LogToLinF(LineEnv(X1, Y1, cArg[1], LinToLogF(AMP)))/AMP;
					
					qOUT = (qOUT+OUT2)*dArg[4];
					break;

				case QSPT_Distortion:
				//dArg[0..2]: lp, hp, amp
					qOUT = LPFilter(0, qIN, LogToLinF(dArg[0]), 0);
					qOUT = HPFilter(1, qOUT, LogToLinF(dArg[1]), 0);
					OUT2 = qIN - qOUT;
		
					if (log(abs(qOUT)) > -6.0) qOUT = SLogToLinF(LineEnvSym(X1, Y1, cArg[1], SLinToLogF(qOUT)));

					qOUT = (qOUT+OUT2)*dArg[2];
					break;

				case QSPT_Chorus:
				//dArg[0..5]: delay, spread, tremo, lfn, feed, drywet
				//cArg[0]: voices
					OUT2 = 0.0;
					for (j=0; j<cArg[0]; j++)
					{
						AMP = OSine(LFNoiseCycle(j, int(dArg[3]*100.0)));
						AMP = LPFilter(j, AMP, 0.0001, 0);
						OUT2 += (1.5*dArg[2]*LFNoise(6+j, int(dArg[3]*5.0)) + 1.0 - dArg[2])*BufferValue(1, 1 + 44.1*dArg[1]*(j+1.0) + 44.1*dArg[0]*AMP);
					}
					OUT2 *= 1.0/double(cArg[0]);
					WriteToBuffer(1, qIN + dArg[4]*OUT2);
					qOUT = OUT2*dArg[5] + (1.0 - dArg[5])*qIN;
					qOUT = HPFilter(6, qOUT, 0.001, 0);
					break;

				case QSPT_Flanger:
				//dArg[0..4]: speed, mindelay, maxdelay, feed, drywet
					PHASE = (dArg[1] + dArg[2])*0.5*44.1 + (dArg[2]-dArg[1])*0.5*44.1*OSine(ophase[0]);
					OUT2 = BufferValue(1, PHASE);

					MovePhase(0, dArg[0]);

					WriteToBuffer(1, qIN + dArg[3]*OUT2);
					qOUT = OUT2*dArg[4]*0.5 + (1.0 - dArg[4]*0.5)*qIN;
					qOUT = HPFilter(0, qOUT, 0.001, 0);
					break;

				case QSPT_Reverb:
				//dArg[0..3]:	x, y, z <- delays , diff
				//dArg[4..7]:	delay, lp, hp, repeat
				//dArg[8]:		drywet
					////// Modulation delay:
					AMP = LFNoise(3, 100);
					AMP = LPFilter(3, AMP, 0.0001, 0);
					OUT2 = qIN + exp(-6.0*(dArg[4])/(dArg[7]+0.5*dArg[3]))*BufferValue(7, 44.1*dArg[4]*(1.0 + 0.02*AMP));
			
					////// Filtering:
					OUT2 = HPFilter(0, OUT2, pow(dArg[6], 5), 0); 
					OUT2 = LPFilter(1, OUT2, pow(dArg[5], 5), 0);

					////// Elminating 0 Hz:
					OUT2 = HPFilter(2, OUT2, 0.0001, 0);

					////// Diffusing:
					OUT2 += AllPassFilterTMod(10, 1, OUT2, 37.1*dArg[0], 44.1*dArg[3], 50, 0.2);
					OUT2 += AllPassFilterTMod(11, 2, OUT2, 37.1*dArg[1], 44.1*dArg[3], 50, 0.2);
					OUT2 += AllPassFilterTMod(12, 3, OUT2, 37.1*dArg[2], 44.1*dArg[3], 50, 0.2);
					OUT2 += AllPassFilterTMod(13, 4, OUT2, 44.1*dArg[0], 44.1*dArg[3], 50, 0.2);
					OUT2 += AllPassFilterTMod(14, 5, OUT2, 44.1*dArg[1], 44.1*dArg[3], 50, 0.2);
					OUT2 += AllPassFilterTMod(15, 6, OUT2, 44.1*dArg[2], 44.1*dArg[3], 50, 0.2);

					////// Buffering:
					WriteToBuffer(7, OUT2);

					////// Output:
					qOUT = qIN*(1.0-dArg[8]) + OUT2*dArg[8];
					break;

				case QSPT_Mod:
				//dArg[0..1]: fm, fm_env
				//dArg[2..3]: am, am_env
				//dArg[4..7]: a, d, s, r
				//dArg[8..9]: amp_env, amp
				//cArg[0]: modulator
					AMP = ADSR_ms(dArg[4], dArg[5], dArg[6], dArg[7], i);

					qIN = Value(output[cArg[0]], outlen[cArg[0]], i);
					
					FM = 20*qIN*dArg[0];

					if (dArg[1] < 0) FM *= (1.0 + dArg[1]) - dArg[1]*(1.0-AMP);
					else FM *= (1.0 - dArg[1]) + dArg[1]*AMP;
				
					MovePos(0, 1 + FM);
					OUT2 = Value(output[dest[iAction]], outlen[dest[iAction]], ophase[0]);

					AMP2 = dArg[2]*(AMP*dArg[3] + (1.0-dArg[3]));

					OUT2	= (1.0-AMP2)*OUT2 + AMP2*OUT2*qIN;
					OUT2	*= dArg[8]*AMP + (1.0-dArg[8]);
					qOUT	= OUT2*dArg[9];
					break;
				
				#ifndef QSP_DISABLE_GRAIN
				case QSPT_Grain:
				//dArg[1..2]: minattack, maxattack
				//dArg[3..4]: minrelease, maxrelease
				//dArg[5..6]: minpitch, maxpitch
				//dArg[7..8]: minslide, maxslide
				//dArg[9..10]: mindistance, maxdistance
				//dArg[11..12]: minamp, maxamp
				//dArg[13]: order
				//dArg[14]: amp
					// oooh! its time to new grain!
					if (nextcount == 0)
					{
						// find empty channel:
						for (j=0; (j<6)&&(grain[j]); j++);
						// generating grain:
						if (j<6)
						{
							grain[j] = true;
							gr_amp[j] = random(dArg[11], dArg[12]);
							gr_attack[j] = random(dArg[1], dArg[2]) + 0.01;
							gr_release[j] = random(dArg[3], dArg[4]) + 0.01;
							gr_pitch[j] = pow(2.0, random(dArg[5], dArg[6]));
							gr_slide[j] = pow(2.0, random(dArg[7], dArg[8]));
							gr_lifetime[j] = 44.1*(gr_attack[j]+gr_release[j]);
							gr_offset[j] = (1.0-dArg[13])*random(0.0, double(outlen[dest[iAction]]) - gr_lifetime[j]*(gr_pitch[j]+0.5*gr_slide[j]) - 2.0);
							gr_offset[j] += dArg[13]*(double(outlen[dest[iAction]]) - gr_lifetime[j]*(gr_pitch[j]+0.5*gr_slide[j]) - 2.0)*double(i)/(dArg[0]*44100.0);
							if (gr_offset[j] < 0) grain[j] = false;
						}
						// define time of next grain
						nextcount = int(44.1*random(dArg[9], dArg[10]));
						if (nextcount == 0) nextcount = 1;
					}

					// decrease time
					nextcount--;

					//playing grains:
					qOUT = 0;
					for(j=0; j<6; j++)
					{
						if (gr_lifetime[j] < 0) grain[j] = false;
						if (grain[j])
						{
							PHASE = (44.1*(gr_attack[j]+gr_release[j]) - gr_lifetime[j]);
							PHASE *= gr_pitch[j] + gr_slide[j]*(1.0 - gr_lifetime[j]/(44.1*(gr_attack[j]+gr_release[j])));

							PHASE += gr_offset[j];

							OUT2 = Value(output[dest[iAction]], outlen[dest[iAction]], PHASE);
							OUT2 *= ADSR_ms(gr_attack[j], gr_release[j], 0, 0, 44.1*(gr_attack[j]+gr_release[j]) - gr_lifetime[j]);			

							qOUT += OUT2*gr_amp[j];

							gr_lifetime[j] -= 1;
						}
					}

					qOUT = qOUT*dArg[14];				
					break;
				#endif

				case QSPT_Amp:
				//dArg[0]: amplify
					qOUT = pow(10.0, dArg[0]-1.0)*qIN*LineEnv(X1, Y1, cArg[1], double(i)/LEN);
					qOUT = Clip(qOUT);
					break;

				case QSPT_Pitch:
				//dArg[0]: range
					qOUT = Value(output[dest[iAction]], outlen[dest[iAction]], ophase[0]);
					MovePos(0, 1.0 + dArg[0]*LineEnv(X1, Y1, cArg[1], double(i)/LEN));
					qOUT = Clip(qOUT);
					break;

				case QSPT_Filter:
				//cArg[0]: type 0 = LP, 1 = HP
					AMP = LineEnv(X1, Y1, cArg[1], double(i)/LEN);
					AMP *= AMP*AMP*AMP;
					if (cArg[0]) qOUT = HPFilter(0, qIN, AMP, LineEnv(X2, Y2, cArg[2], double(i)/LEN));
					else qOUT = LPFilter(0, qIN, AMP, LineEnv(X2, Y2, cArg[2], double(i)/LEN));
					qOUT = Clip(qOUT);
					break;

				case QSPT_Invert:
					qOUT = -qIN;
					break;

				case QSPT_Reverse:
					qOUT = output[dest[iAction]][LEN-i-1];
					break;

				case QSPT_Normalize:
					qOUT = qIN*AMP;
					break;

				case QSPT_Cut:
				// iArg[0]: cutstart
					qOUT = output[dest[iAction]][iArg[0] + i];
					break;

				case QSPT_Pluck:
				//dArg[0..2]: x, y, z
				//dArg[3..5]: assym, size, drywet
				//cArg[0]: 0 = string 1 = pipe
					// first reflection:
								
					double mu = 1.0-dArg[3];
					if (cArg[0] == 1) mu = -mu;
					double ki = dArg[3];

					double rv = dArg[0];
					double rvd = 1.0;

					// main delay cycle:
					rev[1] = mu*BufferValue(7, ((rvd - dArg[2]*rv)*dArg[4]));
					rv *= dArg[0];
					rvd *= dArg[1];
					rev[2] = mu*BufferValue(1, ((rvd - dArg[2]*rv)*dArg[4]));
					rv *= dArg[0];
					rvd *= dArg[1];
					rev[3] = mu*BufferValue(2, ((rvd - dArg[2]*rv)*dArg[4]));
					rv *= dArg[0];
					rvd *= dArg[1];
					rev[4] = mu*BufferValue(3, ((rvd - dArg[2]*rv)*dArg[4]));
					rv *= dArg[0];
					rvd *= dArg[1];
					rev[0] = mu*BufferValue(4, ((rvd - dArg[2]*rv)*dArg[4]));

					rv *= dArg[0];
					rvd = 1.0;
					rev[1] += ki*BufferValue(7, ((rvd - dArg[2]*rv)*dArg[4]));
					rv *= dArg[0];
					rvd *= dArg[1];
					rev[2] += ki*BufferValue(1, ((rvd - dArg[2]*rv)*dArg[4]));
					rv *= dArg[0];
					rvd *= dArg[1];
					rev[3] += ki*BufferValue(2, ((rvd - dArg[2]*rv)*dArg[4]));
					rv *= dArg[0];
					rvd *= dArg[1];
					rev[4] += ki*BufferValue(3, ((rvd - dArg[2]*rv)*dArg[4]));
					rv *= dArg[0];
					rvd *= dArg[1];
					rev[0] += ki*BufferValue(4, ((rvd - dArg[2]*rv)*dArg[4]));
					rv *= dArg[0];

					// source reflection:
					rev[0] += 0.1*BufferValue(8, (0.22*dArg[4]));
					rev[1] -= 0.2*BufferValue(8, (0.39*dArg[4]));
					rev[2] += 0.3*BufferValue(8, (0.63*dArg[4]));
					rev[3] -= 0.4*BufferValue(8, (0.81*dArg[4]));
					rev[4] += 0.5*BufferValue(8, (1.0*dArg[4]));

					qOUT = dArg[5]*0.2*(rev[1] + rev[2] + rev[3] + rev[4] + rev[0]);
					qOUT += (1.0 - dArg[5])*qIN;

					qOUT = HPFilter(0, qOUT, 0.0001, 0);
					qOUT = Clip(qOUT);
					break;
				}//switch action type
					

				///if action have "fixed note" model
				if (actions[iAction] & 128)
					MovePhase(0, FrequencyOfNote(cArg[0]));

				//Move buffer position
				BufferNext();

				if(actions[iAction] == QSPT_Pluck)
				{
					WriteToBuffer(8, qIN);
					WriteToBuffer(1, rev[1]);
					WriteToBuffer(2, rev[2]);
					WriteToBuffer(3, rev[3]);
					WriteToBuffer(4, rev[4]);
					WriteToBuffer(7, rev[0]);
				}

				///write to output[0]
				output[0][i] = qOUT;
			}//HEART OF ENGINE

			////////////////////////////////////////////////////
			////////////////////////////////////////////////////
			///// RESIZE SAMPLE AND PUT DATA
			if (outlen[dest[iAction]] > 0) delete [] output[dest[iAction]];
			output[dest[iAction]] = new double [LEN];
			outlen[dest[iAction]] = LEN;

			for (i=0; i<LEN; i++)
				output[dest[iAction]][i] = output[0][i];
		}

		////////////////////////////////////////
		///////////////////////////////////////
		// ...hooooof. we have done all. 
		if (outlen[0] > 0) delete [] output[0]; 
		outlen[0] = 0;
		CloseBuffers();
	}
}

//QSPT_Perc			1
//QSPT_Osc			2
//QSPT_Env			3
//QSPT_FFT			4
//QSPT_Tracker		5
//QSPT_Copy			6
//QSPT_Mixer		7
//QSPT_Physio		8
//QSPT_EQ			9
//QSPT_Comp			10
//QSPT_Distortion	11
//QSPT_Chorus		12
//QSPT_Flanger		13
//QSPT_Reverb		14
//QSPT_Mod			15
//QSPT_Grain		16
//QSPT_Amp			17
//QSPT_Pitch		18
//QSPT_Filter		19
//QSPT_Invert		20
//QSPT_Reverse		21
//QSPT_Normalize	22
//QSPT_Cut			23
//QSPT_Pluck		24
//QSPT_Close		25