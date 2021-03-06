/*
* libtcod 1.5.0
* Copyright (c) 2008,2009 J.C.Wilk
* All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*     * Redistributions of source code must retain the above copyright
*       notice, this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above copyright
*       notice, this list of conditions and the following disclaimer in the
*       documentation and/or other materials provided with the distribution.
*     * The name of J.C.Wilk may not be used to endorse or promote products
*       derived from this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY J.C.WILK ``AS IS'' AND ANY
* EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL J.C.WILK BE LIABLE FOR ANY
* DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
* (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

class TCODLIB_API TCODSystem {
public :
	static uint32 getElapsedMilli();
	static float getElapsedSeconds();
	static void sleepMilli(uint32 val);
	static void saveScreenshot(const char *filename);
	static void forceFullscreenResolution(int width, int height);
	static void setFps(int val);
	static int getFps();
	static float getLastFrameLength();
	static void getCurrentResolution(int *w, int *h);
	static void updateChar(int asciiCode, int fontx, int fonty,const TCODImage *img,int x,int y);
	// filsystem stuff
	static bool createDirectory(const char *path);
	static bool deleteFile(const char *path);
	static bool deleteDirectory(const char *path);
	// thread stuff
	static int getNumCores();
	static TCOD_thread_t newThread(int (*func)(void *), void *data);
	static void deleteThread(TCOD_thread_t th);
	// mutex
	static TCOD_mutex_t newMutex();
	static void mutexIn(TCOD_mutex_t mut);
	static void mutexOut(TCOD_mutex_t mut);
	static void deleteMutex(TCOD_mutex_t mut);
	// semaphore
	static TCOD_semaphore_t newSemaphore(int initVal);
	static void lockSemaphore(TCOD_semaphore_t sem);
	static void unlockSemaphore(TCOD_semaphore_t sem);
	static void deleteSemaphore( TCOD_semaphore_t sem);
};
