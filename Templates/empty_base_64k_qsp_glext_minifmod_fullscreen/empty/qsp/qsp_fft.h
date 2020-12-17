//
// Quite SAMPLEPOOL source
//
// qsp_fft.h - functions for fourier transfer
// 

namespace QSP
{
	// DFT - very slow algorythm of Fourier Transfer
	void DFT(double* a, double* b, int n)
	{
		double one_n = 1.0/double(n);
		for(int i=0; i<n; i++)
		{
			b[i] = 0;
			for(int j=1; j < n/2; j++)
			{
				if (b[i] <-1) b[i] = -1;
				if (b[i] >1) b[i] = 1;

				b[i] += a[2*j+1]*OSine(j*double(i+1)*one_n);
				b[i] += a[2*j]*OSine(0.25 + j*double(i+1)*one_n);
			}
		}
	}
}