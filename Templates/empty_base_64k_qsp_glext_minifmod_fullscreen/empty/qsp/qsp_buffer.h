//
// Quite SAMPLEPOOL source
//
// qsp_buffer.h - functions for buffering
// needs floor() function;

#define QSP_BUFFERSIZE	90000
#define QSP_BUFFERS		16

namespace QSP
{
	double* buffer[QSP_BUFFERS];
	int bufferpos = 0;
	
	inline void BufferNext()
	{
		bufferpos++;
		if (bufferpos >= QSP_BUFFERSIZE) bufferpos = 0;
	}

	double BufferValue(int b, double Pos)
	{
		if (Pos < 0) Pos = 0;
		if (Pos > QSP_BUFFERSIZE-1) Pos = QSP_BUFFERSIZE-1;
		return ValueCycle(buffer[b], QSP_BUFFERSIZE, double(bufferpos) - Pos);
	}

	void WriteToBuffer(int b, double value)
	{
		buffer[b][bufferpos] = value;
	}

	// double BufferValueStatic(int b, double Pos) {...}
	//
	// function is deleted, use now this: BufferValue(b, floor(Pos))
	//

	inline void InitBuffers()
	{
		for (int i = 0; i < QSP_BUFFERS; i++)
			buffer[i] = new double [QSP_BUFFERSIZE];
	}

	inline void NullBuffers()
	{
		for (int i = 0; i < QSP_BUFFERS; i++)
			for (int j=0; j < QSP_BUFFERSIZE; j++)
				buffer[i][j] = 0;
	}

	inline void CloseBuffers()
	{
		for (int i = 0; i < QSP_BUFFERS; i++)
			delete [] buffer[i];
	}
}

