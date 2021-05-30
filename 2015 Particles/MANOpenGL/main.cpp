/*#include <stdio.h>

void main () {
	int i, m, k, ii;
	i = 1;
	m = 0;
	ii = 1000000;
	for (int j=1; j < 639; j++) {
		k = 0;
		m = 0;
		if (ii > i) 
			ii = i;
		i = j;
		while (m < 8 && k<100) {
			if (i % 2 != 0) //{
				m++;
				i /= 2;
			//}
			k++;
		}
		if (m > 7)
			printf("%d, %d, %d \n",j,m,k);
	}
	return;
}
*/


#pragma comment(linker,"/MERGE:.rdata=.text")

//#define WIN32_LEAN_AND_MEAN
//#define WIN32_EXTRA_LEAN


#include <windows.h>
#include <math.h>
//#include <stdlib.h>
//#include <stdio.h>

#include "draw.h"

#ifndef PI
#define PI 3.14159265358979
#endif

///////////////////////////////////////////////////////////////////////////////
// opengl initialize section
///////////////////////////////////////////////////////////////////////////////
HWND hWnd;
HGLRC hGLRC;
HDC hDC;

bool FullScreen;
long windowWidth = 640;
long windowHeight = 480;
//long windowWidth = 1024;
//long windowHeight = 768;
long windowBits = 32;

void initLights(){
    // set up light colors (ambient, diffuse, specular) and enable it
    GLfloat lightAmbient[] = {.2f, .2f, .2f, 1.0f};  
    GLfloat lightDiffuse[] = {.7f, .7f, .7f, 1.0f};  
    GLfloat lightSpecular[] = {1, 1, 1, 1};          
    glLightfv(GL_LIGHT0, GL_AMBIENT, lightAmbient);
    glLightfv(GL_LIGHT0, GL_DIFFUSE, lightDiffuse);
    glLightfv(GL_LIGHT0, GL_SPECULAR, lightSpecular);
    float lightPosition[4] = {20, 20, 20, 1};
    glLightfv(GL_LIGHT0, GL_POSITION, lightPosition);
    glEnable(GL_LIGHT0);
}

void initGLmode(){
	glClearColor(0, 0, 0, 0);                   // background color
	glShadeModel(GL_SMOOTH);                    // shading mathod: GL_SMOOTH or GL_FLAT
	
	// enable /disable features
	glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);
	glHint(GL_LINE_SMOOTH_HINT, GL_NICEST);
	glHint(GL_POINT_SMOOTH_HINT, GL_NICEST);
	glHint(GL_POLYGON_SMOOTH_HINT, GL_NICEST);

	glEnable(GL_TEXTURE_2D);
	glEnable(GL_CULL_FACE);

	glEnable(GL_LIGHTING);
	glLightModeli(GL_LIGHT_MODEL_TWO_SIDE, 1);

	glEnable(GL_BLEND);
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA
		//GL_SOURCE_ALPHA,GL_ONE
		);

	 // track material ambient and diffuse from surface color, call it before glEnable(GL_COLOR_MATERIAL)
	glColorMaterial(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE);
	glEnable(GL_COLOR_MATERIAL);
	
	glEnable(GL_DEPTH_TEST);
	glDepthFunc(GL_ALWAYS);
	glEnable(GL_POLYGON_OFFSET_FILL);
	glPolygonOffset ( -0.1, -0.1 );
}


///////////////////////////////////////////////////////////////////////////////
// Work section
///////////////////////////////////////////////////////////////////////////////
void draw(){
	glPushMatrix();
	glTranslatef(0,0,-75);


	drawScene();

	// Coordinates axes
	glLineWidth(1);
	glDisable(GL_LIGHTING);
	glBegin(GL_LINES);
	glColor3f(1,0,0);
		glVertex3f(0,0,0);
		glVertex3f(10,0,0);
	glColor3f(0,1,0);
		glVertex3f(0,0,0);
		glVertex3f(0,10,0);
	glColor3f(0,0,1);
		glVertex3f(0,0,0);
		glVertex3f(0,0,10);
	glEnd();
	glEnable(GL_LIGHTING);
	glColor3f(1, 1, 1); // если что-то потерялось выведится белым цветом
	glPopMatrix();
}

void windowResize(WPARAM wParam, LPARAM lParam) {
	glViewport(0, 0, LOWORD(lParam), HIWORD(lParam));
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	// FOV, AspectRatio, NearClip, FarClip
	gluPerspective(60.0f, (float)LOWORD(lParam)/HIWORD(lParam), 1.0f, 100000.0f);
	glMatrixMode(GL_MODELVIEW);
	return;
}

///////////////////////////////////////////////////////////////////////////////
// Window section
///////////////////////////////////////////////////////////////////////////////
bool keys[256];

LRESULT CALLBACK WindowFunc(HWND hWnd,UINT msg,WPARAM wParam,LPARAM lParam){
	switch(msg){
		case WM_CREATE:	
			hDC = GetDC(hWnd);
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

			if(m_GLPixelIndex==0){
			 m_GLPixelIndex = 1;
			 DescribePixelFormat(hDC,m_GLPixelIndex,sizeof(PIXELFORMATDESCRIPTOR),&pfd)  ;
			};

			// инициализация OpenGL тут
			SetPixelFormat( hDC, m_GLPixelIndex, &pfd);
			hGLRC = wglCreateContext(hDC);
			wglMakeCurrent(hDC, hGLRC);

			initGLmode();
			initLights();
			SwapBuffers(hDC);
		break;
		case WM_DESTROY:

			if (FullScreen){             // Change back to non fullscreen
				ChangeDisplaySettings((DEVMODE *)NULL, 0);
			};
			ShowCursor(true);

			if (hGLRC){
				wglMakeCurrent(NULL, NULL);
				wglDeleteContext(hGLRC);
			}
			ReleaseDC(hWnd, hDC);
			PostQuitMessage(0);
		break;
  
		case WM_PAINT:
			glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );

			draw();

			SwapBuffers(hDC);
		break;
		case WM_SIZE:
			windowResize(wParam, lParam);
		break;
		case WM_KEYDOWN:
			keys[wParam] = TRUE;
		break;
		case WM_KEYUP:
			if (keys[27])// DestroyWindow(hWnd);
				SendMessage(hWnd,WM_CLOSE,0,0);
			keys[wParam] = FALSE;
		break;
		default: // если пришло ненужное нам сообщение возвращаем его системе
			return DefWindowProc(hWnd,msg,wParam,lParam);
	}
	return 0;
}

#ifdef _DEBUG
	int WINAPI WinMain(HINSTANCE hInstance,HINSTANCE hPrevInstance,LPSTR lpCmdLine,int nCmdShow)
#else
	//int WinMainCRTStartup()
	int ENTRY_Main()
#endif
{
	MSG msg;

	FullScreen = false;
	//if( MessageBox(
		//NULL, 
		//"1024x768 fullscreen?.", 
		//"SCRIMERS Starcube-Trackmo", 
		//MB_YESNO | MB_ICONQUESTION
		//)==IDYES) {
	//	FullScreen = true;
	//};
	
#ifdef _DEBUG
#else
    HINSTANCE	hInstance;				// Holds The Instance Of The Application
#endif



    WNDCLASS	wc;						// Windows Class Structure
    DWORD		dwExStyle;				// Window Extended Style
    DWORD		dwStyle;				// Window Style
    RECT		WindowRect;				// Grabs Rectangle Upper Left / Lower Right Values
    WindowRect.left=(long)0;			// Set Left Value To 0
    WindowRect.right=(long)windowWidth;		// Set Right Value To Requested Width
    WindowRect.top=(long)0;				// Set Top Value To 0
    WindowRect.bottom=(long)windowHeight;		// Set Bottom Value To Requested Height


    hInstance			= GetModuleHandle(NULL);				// Grab An Instance For Our Window
    wc.style			= CS_HREDRAW | CS_VREDRAW | CS_OWNDC;	// Redraw On Size, And Own DC For Window.
    wc.lpfnWndProc		= (WNDPROC) WindowFunc;					// WndProc Handles Messages
    wc.cbClsExtra		= 0;									// No Extra Window Data
    wc.cbWndExtra		= 0;									// No Extra Window Data
    wc.hInstance		= hInstance;							// Set The Instance
    wc.hIcon			= LoadIcon(NULL, IDI_WINLOGO);			// Load The Default Icon
    wc.hCursor			= LoadCursor(NULL, IDC_ARROW);			// Load The Arrow Pointer
    wc.hbrBackground	= NULL;									// No Background Required For GL
    wc.lpszMenuName		= NULL;									// We Don't Want A Menu
    wc.lpszClassName	= "OpenGL";								// Set The Class Name

    if (!RegisterClass(&wc)){									// Attempt To Register The Window Class
    	MessageBox(NULL,"Failed To Register The Window Class.","ERROR",MB_OK|MB_ICONEXCLAMATION);
    	return FALSE;											// Return FALSE
    }

    if (FullScreen){												// Attempt Fullscreen Mode?
    	DEVMODE dmScreenSettings;								// Device Mode
    	memset(&dmScreenSettings,0,sizeof(dmScreenSettings));	// Makes Sure Memory's Cleared
    	dmScreenSettings.dmSize=sizeof(dmScreenSettings);		// Size Of The Devmode Structure
		dmScreenSettings.dmPelsWidth	= windowWidth;				// Selected Screen Width
    	dmScreenSettings.dmPelsHeight	= windowHeight;				// Selected Screen Height
    	dmScreenSettings.dmBitsPerPel	= windowBits;					// Selected Bits Per Pixel
    	dmScreenSettings.dmFields=DM_BITSPERPEL|DM_PELSWIDTH|DM_PELSHEIGHT;

    	// Try To Set Selected Mode And Get Results.  NOTE: CDS_FULLSCREEN Gets Rid Of Start Bar.
    	if (ChangeDisplaySettings(&dmScreenSettings,CDS_FULLSCREEN)!=DISP_CHANGE_SUCCESSFUL){
    		// If The Mode Fails, Offer Two Options.  Quit Or Use Windowed Mode.
    		if (MessageBox(NULL,"The Requested Fullscreen Mode Is Not Supported By\nYour Video Card. Use Windowed Mode Instead?","NeHe GL",MB_YESNO|MB_ICONEXCLAMATION)==IDYES){
    			FullScreen=FALSE;		// Windowed Mode Selected.  Fullscreen = FALSE
    		}else{
    			// Pop Up A Message Box Letting User Know The Program Is Closing.
    			MessageBox(NULL,"Program Will Now Close.","ERROR",MB_OK|MB_ICONSTOP);
    			return FALSE;									// Return FALSE
    		}
    	}
    }

    if (FullScreen){											// Are We Still In Fullscreen Mode?
    	dwExStyle=WS_EX_APPWINDOW;								// Window Extended Style
    	dwStyle=WS_POPUP | WS_CLIPSIBLINGS | WS_CLIPCHILDREN;	// Windows Style
    	ShowCursor(FALSE);										// Hide Mouse Pointer
    }else{
    	dwExStyle=WS_EX_APPWINDOW | WS_EX_WINDOWEDGE;			// Window Extended Style
    	dwStyle=WS_POPUP | WS_CLIPSIBLINGS | WS_CLIPCHILDREN | WS_CAPTION | WS_SYSMENU;	// Windows Style
    }

    AdjustWindowRectEx(&WindowRect, dwStyle, FALSE, dwExStyle);		// Adjust Window To True Requested Size

    // Create The Window
    if (!(hWnd=CreateWindowEx(	dwExStyle,							// Extended Style For The Window
    							"OpenGL",							// Class Name
    							"Try some OpenGL",					// Window Title
    							dwStyle |							// Defined Window Style
    							WS_CLIPSIBLINGS |					// Required Window Style
    							WS_CLIPCHILDREN,					// Required Window Style
    							0, 0,								// Window Position
    							WindowRect.right-WindowRect.left,	// Calculate Window Width
    							WindowRect.bottom-WindowRect.top,	// Calculate Window Height
    							NULL,								// No Parent Window
    							NULL,								// No Menu
    							hInstance,							// Instance
    							NULL)))								// Dont Pass Anything To WM_CREATE
    {
    	
    	MessageBox(NULL,"Window Creation Error.","ERROR",MB_OK|MB_ICONEXCLAMATION);
    	return FALSE;								// Return FALSE
    }

	ShowWindow(hWnd, 1);
	UpdateWindow(hWnd);
	//ShowCursor(false);

	SetForegroundWindow(hWnd);
	SetFocus(hWnd);

	while(GetMessage(&msg,NULL,0,0)){
	   TranslateMessage(&msg);
	   DispatchMessage(&msg);
	}

	ExitProcess(0);
}


