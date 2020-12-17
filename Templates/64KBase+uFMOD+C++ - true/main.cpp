#define WIN32_LEAN_AND_MEAN
#define WIN32_EXTRA_LEAN
#include <windows.h>

//OpenGL
#include <gl\gl.h>
#include <gl\GLU.H>

//UFMOD
#include "ufmod.h"
/*
	«аголовки
*/

HWND hWnd;
HGLRC hGLRC;
HDC hDC;
extern "C" unsigned int _fltused=0;
LRESULT CALLBACK WindowFunc(HWND hWnd,UINT msg,WPARAM wParam,LPARAM lParam);

//—сылка на ресурс музыки
HINSTANCE hInst;

/*
	–еализаци€
*/
int WinMainCRTStartup() {
	MSG msg;
	WNDCLASS wcl;


	wcl.hInstance=NULL;
	wcl.lpszClassName = "OpenGLWinClass";
	wcl.lpfnWndProc = WindowFunc;
	wcl.style = CS_OWNDC | CS_HREDRAW | CS_VREDRAW;
	wcl.hIcon = NULL;
	wcl.hCursor = LoadCursor(NULL,IDC_ARROW);
	wcl.lpszMenuName = NULL;
	wcl.cbClsExtra = 0;
	wcl.cbWndExtra = 0;
	wcl.hbrBackground = (HBRUSH)GetStockObject(WHITE_BRUSH);
	RegisterClass(&wcl);
	hWnd = CreateWindow(
	  "OpenGLWinClass",
	  "Win API Template",
	  WS_OVERLAPPEDWINDOW | WS_CLIPCHILDREN | WS_CLIPSIBLINGS,
	  200,
	  150,
	  400,
	  420,
	  HWND_DESKTOP, NULL,
	  NULL, NULL);

	ShowWindow(hWnd, 1);
	UpdateWindow(hWnd);

	while(GetMessage(&msg,NULL,0,0))     {
	   TranslateMessage(&msg);
	   DispatchMessage(&msg);
	}
	    
	return 0;
}

LRESULT CALLBACK WindowFunc(HWND hWnd,UINT msg,WPARAM wParam,LPARAM lParam)
{
switch(msg)
 {
   
   case WM_CREATE:	
   						hDC = GetDC(hWnd); // получаем дескриптор окна

						/* устанавливаем формат пикселей */
   						int m_GLPixelIndex;
					    PIXELFORMATDESCRIPTOR pfd;
					    pfd.nSize       = sizeof(PIXELFORMATDESCRIPTOR);
					    pfd.nVersion    = 1;
					    pfd.dwFlags   = PFD_DRAW_TO_WINDOW | PFD_SUPPORT_OPENGL | PFD_DOUBLEBUFFER;
					    pfd.iPixelType     = PFD_TYPE_RGBA;
					    pfd.cColorBits     = 32;
					    pfd.cRedBits       = 8;
					    pfd.cRedShift      = 16;
					    pfd.cGreenBits     = 8;
					    pfd.cGreenShift    = 8;
					    pfd.cBlueBits      = 8;
					    pfd.cBlueShift     = 0;
					    pfd.cAlphaBits     = 0;
					    pfd.cAlphaShift    = 0;
					    pfd.cAccumBits     = 64;
					    pfd.cAccumRedBits  = 16;
					    pfd.cAccumGreenBits   = 16;
					    pfd.cAccumBlueBits    = 16;
					    pfd.cAccumAlphaBits   = 0;
					    pfd.cDepthBits        = 32;
					    pfd.cStencilBits      = 8;
					    pfd.cAuxBuffers       = 0;
					    pfd.iLayerType        = PFD_MAIN_PLANE;
					    pfd.bReserved         = 0;
					    pfd.dwLayerMask       = 0;
					    pfd.dwVisibleMask     = 0;
					    pfd.dwDamageMask      = 0;
					    m_GLPixelIndex = ChoosePixelFormat( hDC, &pfd);

					    if(m_GLPixelIndex==0) 
					    {
					     m_GLPixelIndex = 1;
					     DescribePixelFormat(hDC,m_GLPixelIndex,sizeof(PIXELFORMATDESCRIPTOR),&pfd)  ;
					    }

					    SetPixelFormat( hDC, m_GLPixelIndex, &pfd);

						// инициализаци€ OpenGL тут

						hGLRC = wglCreateContext(hDC);
   						wglMakeCurrent(hDC, hGLRC);


						//»нициализаци€ музыки
						if (!uFMOD_PlaySong((char*)1, 0, XM_RESOURCE)){
							return 1;
						}
        break;
  
   case WM_DESTROY:
					//«акрываем и останавливаем uFMOD
					uFMOD_StopSong();

	   				//освобождаем ресурсы
			        if (hGLRC)
			        {
			            wglMakeCurrent(NULL, NULL);
			            wglDeleteContext(hGLRC);
			        }
			        ReleaseDC(hWnd, hDC);
			        PostQuitMessage(0);
        break;
  
   case WM_PAINT:  // перерисовка окна
				   	PAINTSTRUCT ps;
			        BeginPaint(hWnd, &ps);


			       	glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );
 					
					//рисование тут

					glFinish();
					SwapBuffers(hDC); // перерисовываем содержимое окна

			        EndPaint(hWnd, &ps);
        break;
  case WM_SIZE:		// ресайз окна
				 	glViewport(0,0, LOWORD(lParam), HIWORD(lParam));
				 	glMatrixMode( GL_PROJECTION );
			   		glLoadIdentity();
			  	  	glOrtho(-5,5, -5,5, 2,12);
			   		glMatrixMode( GL_MODELVIEW );
     break;

  default: // если пришло ненужное нам сообщение возвращаем его системе
     return DefWindowProc(hWnd,msg,wParam,lParam);
}
return 0;
}




