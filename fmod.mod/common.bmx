' Copyright (c) 2008 Bruce A Henderson
' 
' Permission is hereby granted, free of charge, to any person obtaining a copy
' of this software and associated documentation files (the "Software"), to deal
' in the Software without restriction, including without limitation the rights
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Software, and to permit persons to whom the Software is
' furnished to do so, subject to the following conditions:
' 
' The above copyright notice and this permission notice shall be included in
' all copies or substantial portions of the Software.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
' THE SOFTWARE.
' 
SuperStrict

Import BRL.Blitz

Import "-lfmodex"

Import "include/*.h"

Import "glue.cpp"

Extern
	Function bmx_fmod_getversion:Int()

	Function bmx_FMOD_System_Create:Byte Ptr(result:Int Ptr)
	Function bmx_FMOD_System_CreateSound:Byte Ptr(handle:Byte Ptr, filename:Byte Ptr, mode:Int, exInfo:Byte Ptr, ret:Int Ptr)
	Function bmx_FMOD_System_PlaySound:Byte Ptr(handle:Byte Ptr, channelId:Int, sound:Byte Ptr, paused:Int, reuse:Byte Ptr)
	Function bmx_FMOD_System_GetChannel:Byte Ptr(handle:Byte Ptr, channelId:Int)
	Function bmx_FMOD_System_CreateDSPByType:Byte Ptr(handle:Byte Ptr, dspType:Int, ret:Int Ptr)

	Function bmx_FMOD_Channel_GetSpectrum:Int(handle:Byte Ptr, spectrumArray:Float[], channelOffset:Int, windowType:Int)
	Function bmx_FMOD_Channel_GetCurrentSound:Byte Ptr(handle:Byte Ptr)

	Function bmx_soundexinfo_create:Byte Ptr()
	Function bmx_soundexinfo_setlength(handle:Byte Ptr, length:Int)	Function bmx_soundexinfo_delete(handle:Byte Ptr)

	Function bmx_FMOD_SoundGroup_GetSound:Byte Ptr(handle:Byte Ptr, index:Int)
End Extern

?win32
Extern "win32"
?Not win32
Extern
?
	Function FMOD_System_Release:Int(handle:Byte Ptr)
	Function FMOD_System_Init:Int(handle:Byte Ptr, maxChannels:Int, flags:Int, extraDriverData:Byte Ptr)
	Function FMOD_System_Update:Int(handle:Byte Ptr)
	Function FMOD_System_GetChannelsPlaying:Int(handle:Byte Ptr, channels:Int Ptr)
	Function FMOD_System_Get3DListenerAttributes:Int(handle:Byte Ptr, listener:Int, pos:Byte Ptr, vel:Byte Ptr, forward:Byte Ptr, up:Byte Ptr)
	Function FMOD_System_Get3DNumListeners:Int(handle:Byte Ptr, listeners:Int Ptr)
	Function FMOD_System_Get3DSettings:Int(handle:Byte Ptr, dopplerScale:Float Ptr, distanceFactor:Float Ptr, rollOffScale:Float Ptr)
	Function FMOD_System_Get3DSpeakerPosition:Int(handle:Byte Ptr, speaker:Int, x:Float Ptr, y:Float Ptr, active:Int Ptr)
	Function FMOD_System_GetCPUUsage:Int(handle:Byte Ptr, dsp:Float Ptr, stream:Float Ptr, update:Float Ptr, total:Float Ptr)
	Function FMOD_System_GetHardwareChannels:Int(handle:Byte Ptr, num2D:Int Ptr, num3D:Int Ptr, total:Int Ptr)
	Function FMOD_System_GetVersion:Int(handle:Byte Ptr, version:Int Ptr)
	Function FMOD_System_GetNumCDROMDrives:Int(handle:Byte Ptr, numDrives:Int Ptr)
	Function FMOD_System_GetSoundRAM:Int(handle:Byte Ptr, currentAlloced:Int Ptr, maxAlloced:Int Ptr, total:Int Ptr)
	Function FMOD_System_Close:Int(handle:Byte Ptr)
	Function FMOD_System_AddDSP:Int(handle:Byte Ptr, dsp:Byte Ptr, conn:Byte Ptr)



	Function FMOD_Sound_SetMode:Int(handle:Byte Ptr, mode:Int)
	Function FMOD_Sound_GetLength:Int(handle:Byte Ptr, length:Int Ptr, lengthType:Int)
	Function FMOD_Sound_Release:Int(handle:Byte Ptr)
	Function FMOD_Sound_GetMode:Int(handle:Byte Ptr, mode:Int Ptr)
	Function FMOD_Sound_GetLoopCount:Int(handle:Byte Ptr, loopCount:Int Ptr)
	Function FMOD_Sound_SetLoopCount:Int(handle:Byte Ptr, loopCount:Int)
	Function FMOD_Sound_SetLoopPoints:Int(handle:Byte Ptr, loopStart:Int, loopStartType:Int, loopEnd:Int, loopEndType:Int)
	Function FMOD_Sound_GetLoopPoints:Int(handle:Byte Ptr, loopStart:Int Ptr, loopStartType:Int Ptr, loopEnd:Int Ptr, loopEndType:Int Ptr)
	Function FMOD_Sound_GetMusicNumChannels:Int(handle:Byte Ptr, numChannels:Int Ptr)
	Function FMOD_Sound_GetMusicChannelVolume:Int(handle:Byte Ptr, channel:Int, volume:Int Ptr)
	Function FMOD_Sound_SetMusicChannelVolume:Int(handle:Byte Ptr, channel:Int, volume:Int)
	Function FMOD_Sound_GetDefaults:Int(handle:Byte Ptr, frequency:Float Ptr, volume:Float Ptr, pan:Float Ptr, priority:Int Ptr)
	Function FMOD_Sound_SetDefaults:Int(handle:Byte Ptr, frequency:Float, volume:Float, pan:Float, priority:Int)
	Function FMOD_Sound_GetVariations:Int(handle:Byte Ptr, frequencyVar:Float Ptr, volumeVar:Float Ptr, panVar:Float Ptr)
	Function FMOD_Sound_SetVariations:Int(handle:Byte Ptr, frequencyVar:Float, volumeVar:Float, panVar:Float)
	Function FMOD_Sound_Get3DConeSettings:Int(handle:Byte Ptr, insideConeAngle:Float Ptr, outsideConeAngle:Float Ptr, outsideVolume:Float Ptr)
	Function FMOD_Sound_Set3DConeSettings:Int(handle:Byte Ptr, insideConeAngle:Float, outsideConeAngle:Float, outsideVolume:Float)
	Function FMOD_Sound_Get3DMinMaxDistance:Int(handle:Byte Ptr, minDist:Float Ptr, maxDist:Float Ptr)
	Function FMOD_Sound_Set3DMinMaxDistance:Int(handle:Byte Ptr, minDist:Float, maxDist:Float)
	Function FMOD_Sound_GetFormat:Int(handle:Byte Ptr, soundType:Int Ptr, soundFormat:Int Ptr, channels:Int Ptr, bits:Int Ptr)
	Function FMOD_Sound_GetNumSubSounds:Int(handle:Byte Ptr, numSubSounds:Int Ptr)
	Function FMOD_Sound_GetNumTags:Int(handle:Byte Ptr, numTags:Int Ptr, numTagsUpdated:Int Ptr)
	Function FMOD_Sound_GetOpenState:Int(handle:Byte Ptr, openState:Int Ptr, percentBuffered:Int Ptr, starving:Int Ptr)
	Function FMOD_Sound_GetName:Int(handle:Byte Ptr, vstr:Byte Ptr, length:Int)


	Function FMOD_Channel_IsPlaying:Int(handle:Byte Ptr, playing:Int Ptr)
	Function FMOD_Channel_GetPaused:Int(handle:Byte Ptr, paused:Int Ptr)
	Function FMOD_Channel_Stop:Int(handle:Byte Ptr)
	Function FMOD_Channel_GetVolume:Int(handle:Byte Ptr, volume:Float Ptr)
	Function FMOD_Channel_GetFrequency:Int(handle:Byte Ptr, frequency:Float Ptr)
	Function FMOD_Channel_GetPosition:Int(handle:Byte Ptr, position:Int Ptr, posType:Int)
	Function FMOD_Channel_IsVirtual:Int(handle:Byte Ptr, virtual:Int Ptr)
	Function FMOD_Channel_GetAudibility:Int(handle:Byte Ptr, audibility:Float Ptr)
	Function FMOD_Channel_GetDelay:Int(handle:Byte Ptr, delayType:Int, delayHi:Int Ptr, delayLo:Int Ptr)
	Function FMOD_Channel_GetIndex:Int(handle:Byte Ptr, index:Int Ptr)
	Function FMOD_Channel_GetLoopCount:Int(handle:Byte Ptr, loopCount:Int Ptr)
	Function FMOD_Channel_GetLoopPoints:Int(handle:Byte Ptr, loopStart:Int Ptr, loopStartType:Int, loopEnd:Int Ptr, loopEndType:Int)
	Function FMOD_Channel_Get3DDopplerLevel:Int(handle:Byte Ptr, level:Float Ptr)
	Function FMOD_Channel_Get3DMinMaxDistance:Int(handle:Byte Ptr, minDistance:Float Ptr, maxDistance:Float Ptr)
	Function FMOD_Channel_Get3DOcclusion:Int(handle:Byte Ptr, directOcclusion:Float Ptr, reverbOcclusion:Float Ptr)
	Function FMOD_Channel_Get3DPanLevel:Int(handle:Byte Ptr, level:Float Ptr)
	Function FMOD_Channel_Get3DSpread:Int(handle:Byte Ptr, angle:Float Ptr)
	Function FMOD_Channel_Get3DAttributes:Int(handle:Byte Ptr, pos:Byte Ptr, vel:Byte Ptr)
	Function FMOD_Channel_Get3DConeOrientation:Int(handle:Byte Ptr, orientation:Byte Ptr)
	Function FMOD_Channel_SetPaused:Int(handle:Byte Ptr, paused:Int)

	Function FMOD_DSP_GetActive:Int(handle:Byte Ptr, active:Int Ptr)
	Function FMOD_DSP_SetActive:Int(handle:Byte Ptr, active:Int)
	Function FMOD_DSP_Remove:Int(handle:Byte Ptr)
	Function FMOD_DSP_Reset:Int(handle:Byte Ptr)
	Function FMOD_DSP_GetBypass:Int(handle:Byte Ptr, bypass:Int Ptr)
	Function FMOD_DSP_SetBypass:Int(handle:Byte Ptr, bypass:Int)
	Function FMOD_DSP_GetNumParameters:Int(handle:Byte Ptr, numParams:Int Ptr)
	Function FMOD_DSP_SetParameter:Int(handle:Byte Ptr, index:Int, value:Float)
	Function FMOD_DSP_GetParameter:Int(handle:Byte Ptr, index:Int, value:Float Ptr, vstr:Byte Ptr, length:Int)
	Function FMOD_DSP_GetInfo:Int(handle:Byte Ptr, vstr:Byte Ptr, version:Int Ptr, channels:Int Ptr, cw:Int Ptr, ch:Int Ptr)
	Function FMOD_DSP_GetType:Int(handle:Byte Ptr, dspType:Int Ptr)
	Function FMOD_DSP_GetDefaults:Int(handle:Byte Ptr, frequency:Float Ptr, volume:Float Ptr, pan:Float Ptr, priority:Int Ptr)

	Function FMOD_SoundGroup_GetMaxAudible:Int(handle:Byte Ptr, maxAudible:Int Ptr)
	Function FMOD_SoundGroup_GetMaxAudibleBehavior:Int(handle:Byte Ptr, behavior:Int Ptr)
	Function FMOD_SoundGroup_GetMuteFadeSpeed:Int(handle:Byte Ptr, speed:Float Ptr)
	Function FMOD_SoundGroup_GetName:Int(handle:Byte Ptr, vstr:Byte Ptr, length:Int)
	Function FMOD_SoundGroup_GetNumPlaying:Int(handle:Byte Ptr, numPlaying:Int Ptr)
	Function FMOD_SoundGroup_GetNumSounds:Int(handle:Byte Ptr, numSounds:Int Ptr)
	Function FMOD_SoundGroup_GetVolume:Int(handle:Byte Ptr, volume:Float Ptr)
	Function FMOD_SoundGroup_Release:Int(handle:Byte Ptr)
	Function FMOD_SoundGroup_SetMaxAudible:Int(handle:Byte Ptr, maxAudible:Int)
	Function FMOD_SoundGroup_SetMaxAudibleBehavior:Int(handle:Byte Ptr, behavior:Int)
	Function FMOD_SoundGroup_SetMuteFadeSpeed:Int(handle:Byte Ptr, speed:Float)
	Function FMOD_SoundGroup_SetVolume:Int(handle:Byte Ptr, volume:Float)
	Function FMOD_SoundGroup_Stop:Int(handle:Byte Ptr)

End Extern

Extern
	Rem
	bbdoc: Structure describing a point in 3D space.  
	about: FMOD uses a left handed co-ordinate system by default.
	<p>
	To use a right handed co-ordinate system specify FMOD_INIT_3D_RIGHTHANDED from FMOD_INITFLAGS in System::init. 
	</p>
	End Rem
	Type TFMODVector
		Rem
		bbdoc: X co-ordinate in 3D spa
		End Rem
		Field x:Float
		Rem
		bbdoc: Y co-ordinate in 3D spa
		End Rem
		Field y:Float
		Rem
		bbdoc: Z co-ordinate in 3D spa
		End Rem
		Field z:Float
	End Type

End Extern

Const FMOD_CHANNEL_FREE:Int = -1      ' For a channel index, FMOD chooses a free voice using the priority system. */
Const FMOD_CHANNEL_REUSE:Int = -2     ' For a channel index, re-use the channel handle that was passed in. */

Const FMOD_INIT_NORMAL:Int = $00000000 
Const FMOD_INIT_STREAM_FROM_UPDATE:Int = $00000001 
Const FMOD_INIT_3D_RIGHTHANDED:Int = $00000002 
Const FMOD_INIT_SOFTWARE_DISABLE:Int = $00000004 
Const FMOD_INIT_SOFTWARE_OCCLUSION:Int = $00000008 
Const FMOD_INIT_SOFTWARE_HRTF:Int = $00000010 
Const FMOD_INIT_ENABLE_PROFILE:Int = $00000020 
Const FMOD_INIT_VOL0_BECOMES_VIRTUAL:Int = $00000080 
Const FMOD_INIT_WASAPI_EXCLUSIVE:Int = $00000100 
Const FMOD_INIT_DSOUND_HRTFNONE:Int = $00000200 
Const FMOD_INIT_DSOUND_HRTFLIGHT:Int = $00000400 
Const FMOD_INIT_DSOUND_HRTFFULL:Int = $00000800 
Const FMOD_INIT_PS2_DISABLECORE0REVERB:Int = $00010000 
Const FMOD_INIT_PS2_DISABLECORE1REVERB:Int = $00020000 
Const FMOD_INIT_PS2_DONTUSESCRATCHPAD:Int = $00040000 
Const FMOD_INIT_PS2_SWAPDMACHANNELS:Int = $00080000 
Const FMOD_INIT_PS3_PREFERDTS:Int = $00800000 
Const FMOD_INIT_PS3_FORCE2CHLPCM:Int = $01000000 
Const FMOD_INIT_XBOX_REMOVEHEADROOM:Int = $00100000 
Const FMOD_INIT_360_MUSICMUTENOTPAUSE:Int = $00200000 
Const FMOD_INIT_SYNCMIXERWITHUPDATE:Int = $00400000 

Const FMOD_TIMEUNIT_MS:Int = $00000001 
Const FMOD_TIMEUNIT_PCM:Int = $00000002 
Const FMOD_TIMEUNIT_PCMBYTES:Int = $00000004 
Const FMOD_TIMEUNIT_RAWBYTES:Int = $00000008 
Const FMOD_TIMEUNIT_MODORDER:Int = $00000100 
Const FMOD_TIMEUNIT_MODROW:Int = $00000200 
Const FMOD_TIMEUNIT_MODPATTERN:Int = $00000400 
Const FMOD_TIMEUNIT_SENTENCE_MS:Int = $00010000 
Const FMOD_TIMEUNIT_SENTENCE_PCM:Int = $00020000 
Const FMOD_TIMEUNIT_SENTENCE_PCMBYTES:Int = $00040000 
Const FMOD_TIMEUNIT_SENTENCE:Int = $00080000 
Const FMOD_TIMEUNIT_SENTENCE_SUBSOUND:Int = $00100000 
Const FMOD_TIMEUNIT_BUFFERED:Int = $10000000 

Const FMOD_DEFAULT:Int = $00000000 
Const FMOD_LOOP_OFF:Int = $00000001 
Const FMOD_LOOP_NORMAL:Int = $00000002 
Const FMOD_LOOP_BIDI:Int = $00000004 
Const FMOD_2D:Int = $00000008 
Const FMOD_3D:Int = $00000010 
Const FMOD_HARDWARE:Int = $00000020 
Const FMOD_SOFTWARE:Int = $00000040 
Const FMOD_CREATESTREAM:Int = $00000080 
Const FMOD_CREATESAMPLE:Int = $00000100 
Const FMOD_CREATECOMPRESSEDSAMPLE:Int = $00000200 
Const FMOD_OPENUSER:Int = $00000400 
Const FMOD_OPENMEMORY:Int = $00000800 
Const FMOD_OPENMEMORY_POINT:Int = $10000000 
Const FMOD_OPENRAW:Int = $00001000 
Const FMOD_OPENONLY:Int = $00002000 
Const FMOD_ACCURATETIME:Int = $00004000 
Const FMOD_MPEGSEARCH:Int = $00008000 
Const FMOD_NONBLOCKING:Int = $00010000 
Const FMOD_UNIQUE:Int = $00020000 
Const FMOD_3D_HEADRELATIVE:Int = $00040000 
Const FMOD_3D_WORLDRELATIVE:Int = $00080000 
Const FMOD_3D_LOGROLLOFF:Int = $00100000 
Const FMOD_3D_LINEARROLLOFF:Int = $00200000 
Const FMOD_3D_CUSTOMROLLOFF:Int = $04000000 
Const FMOD_3D_IGNOREGEOMETRY:Int = $40000000 
Const FMOD_CDDA_FORCEASPI:Int = $00400000 
Const FMOD_CDDA_JITTERCORRECT:Int = $00800000 
Const FMOD_UNICODE:Int = $01000000 
Const FMOD_IGNORETAGS:Int = $02000000 
Const FMOD_LOWMEM:Int = $08000000 
Const FMOD_LOADSECONDARYRAM:Int = $20000000 
Const FMOD_VIRTUAL_PLAYFROMSTART:Int = $80000000 

Const FMOD_OK:Int = 0                        ' No errors.
Const FMOD_ERR_ALREADYLOCKED:Int = 1         ' Tried to call lock a second time before unlock was called.
Const FMOD_ERR_BADCOMMAND:Int = 2            ' Tried to call a function on a data type that does not allow this type of functionality (ie calling Sound::lock on a streaming sound).
Const FMOD_ERR_CDDA_DRIVERS:Int = 3          ' Neither NTSCSI nor ASPI could be initialised.
Const FMOD_ERR_CDDA_INIT:Int = 4             ' An error occurred while initialising the CDDA subsystem.
Const FMOD_ERR_CDDA_INVALID_DEVICE:Int = 5   ' Couldn't find the specified device.
Const FMOD_ERR_CDDA_NOAUDIO:Int = 6          ' No audio tracks on the specified disc.
Const FMOD_ERR_CDDA_NODEVICES:Int = 7        ' No CD/DVD devices were found. 
Const FMOD_ERR_CDDA_NODISC:Int = 8           ' No disc present in the specified drive.
Const FMOD_ERR_CDDA_READ:Int = 9             ' A CDDA read error occurred.
Const FMOD_ERR_CHANNEL_ALLOC:Int = 10         ' Error trying to allocate a channel.
Const FMOD_ERR_CHANNEL_STOLEN:Int = 11        ' The specified channel has been reused to play another sound.
Const FMOD_ERR_COM:Int = 12                   ' A Win32 COM related error occured. COM failed to initialize or a QueryInterface failed meaning a Windows codec or driver was not installed properly.
Const FMOD_ERR_DMA:Int = 13                   ' DMA Failure.  See debug output for more information.
Const FMOD_ERR_DSP_CONNECTION:Int = 14        ' DSP connection error.  Connection possibly caused a cyclic dependancy.
Const FMOD_ERR_DSP_FORMAT:Int = 15            ' DSP Format error.  A DSP unit may have attempted to connect to this network with the wrong format.
Const FMOD_ERR_DSP_NOTFOUND:Int = 16          ' DSP connection error.  Couldn't find the DSP unit specified.
Const FMOD_ERR_DSP_RUNNING:Int = 17           ' DSP error.  Cannot perform this operation while the network is in the middle of running.  This will most likely happen if a connection or disconnection is attempted in a DSP callback.
Const FMOD_ERR_DSP_TOOMANYCONNECTIONS:Int = 18 ' DSP connection error.  The unit being connected to or disconnected should only have 1 input or output.
Const FMOD_ERR_FILE_BAD:Int = 19              ' Error loading file.
Const FMOD_ERR_FILE_COULDNOTSEEK:Int = 20     ' Couldn't perform seek operation.  This is a limitation of the medium (ie netstreams) or the file format.
Const FMOD_ERR_FILE_DISKEJECTED:Int = 21      ' Media was ejected while reading.
Const FMOD_ERR_FILE_EOF:Int = 22              ' End of file unexpectedly reached while trying to read essential data (truncated data?).
Const FMOD_ERR_FILE_NOTFOUND:Int = 23         ' File not found.
Const FMOD_ERR_FILE_UNWANTED:Int = 24         ' Unwanted file access occured.
Const FMOD_ERR_FORMAT:Int = 25                ' Unsupported file or audio format.
Const FMOD_ERR_HTTP:Int = 26                  ' A HTTP error occurred. This is a catch-all for HTTP errors not listed elsewhere.
Const FMOD_ERR_HTTP_ACCESS:Int = 27           ' The specified resource requires authentication or is forbidden.
Const FMOD_ERR_HTTP_PROXY_AUTH:Int = 28       ' Proxy authentication is required to access the specified resource.
Const FMOD_ERR_HTTP_SERVER_ERROR:Int = 29     ' A HTTP server error occurred.
Const FMOD_ERR_HTTP_TIMEOUT:Int = 30          ' The HTTP request timed out.
Const FMOD_ERR_INITIALIZATION:Int = 31        ' FMOD was not initialized correctly to support this function.
Const FMOD_ERR_INITIALIZED:Int = 32           ' Cannot call this command after System::init.
Const FMOD_ERR_INTERNAL:Int = 33              ' An error occured that wasn't supposed to.  Contact support.
Const FMOD_ERR_INVALID_ADDRESS:Int = 34       ' On Xbox 360, this memory address passed to FMOD must be physical, (ie allocated with XPhysicalAlloc.)
Const FMOD_ERR_INVALID_FLOAT:Int = 35         ' Value passed in was a NaN, Inf or denormalized float.
Const FMOD_ERR_INVALID_HANDLE:Int = 36        ' An invalid object handle was used.
Const FMOD_ERR_INVALID_PARAM:Int = 37         ' An invalid parameter was passed to this function.
Const FMOD_ERR_INVALID_SPEAKER:Int = 38       ' An invalid speaker was passed to this function based on the current speaker mode.
Const FMOD_ERR_INVALID_VECTOR:Int = 39        ' The vectors passed in are not unit length, or perpendicular.
Const FMOD_ERR_IRX:Int = 40                   ' PS2 only.  fmodex.irx failed to initialize.  This is most likely because you forgot to load it.
Const FMOD_ERR_MAXAUDIBLE:Int = 41            ' Reached maximum audible playback count for this sound's soundgroup.
Const FMOD_ERR_MEMORY:Int = 42                ' Not enough memory or resources.
Const FMOD_ERR_MEMORY_CANTPOINT:Int = 43      ' Can't use FMOD_OPENMEMORY_POINT on non PCM source data, or non mp3/xma/adpcm data if const FMOD_CREATECOMPRESSEDSAMPLE was used.
Const FMOD_ERR_MEMORY_IOP:Int = 44            ' PS2 only.  Not enough memory or resources on PlayStation 2 IOP ram.
Const FMOD_ERR_MEMORY_SRAM:Int = 45           ' Not enough memory or resources on console sound ram.
Const FMOD_ERR_NEEDS2D:Int = 46               ' Tried to call a command on a 3d sound when the command was meant for 2d sound.
Const FMOD_ERR_NEEDS3D:Int = 47               ' Tried to call a command on a 2d sound when the command was meant for 3d sound.
Const FMOD_ERR_NEEDSHARDWARE:Int = 48         ' Tried to use a feature that requires hardware support.  (ie trying to play a VAG compressed sound in software on PS2).
Const FMOD_ERR_NEEDSSOFTWARE:Int = 49         ' Tried to use a feature that requires the software engine.  Software engine has either been turned off, or command was executed on a hardware channel which does not support this feature.
Const FMOD_ERR_NET_CONNECT:Int = 50           ' Couldn't connect to the specified host.
Const FMOD_ERR_NET_SOCKET_ERROR:Int = 51      ' A socket error occurred.  This is a catch-all for socket-related errors not listed elsewhere.
Const FMOD_ERR_NET_URL:Int = 52               ' The specified URL couldn't be resolved.
Const FMOD_ERR_NET_WOULD_BLOCK:Int = 53       ' Operation on a non-blocking socket could not complete immediately.
Const FMOD_ERR_NOTREADY:Int = 54              ' Operation could not be performed because specified sound is not ready.
Const FMOD_ERR_OUTPUT_ALLOCATED:Int = 55      ' Error initializing output device, but more specifically, the output device is already in use and cannot be reused.
Const FMOD_ERR_OUTPUT_CREATEBUFFER:Int = 56   ' Error creating hardware sound buffer.
Const FMOD_ERR_OUTPUT_DRIVERCALL:Int = 57     ' A call to a standard soundcard driver failed, which could possibly mean a bug in the driver or resources were missing or exhausted.
Const FMOD_ERR_OUTPUT_ENUMERATION:Int = 58    ' Error enumerating the available driver list. List may be inconsistent due to a recent device addition or removal.
Const FMOD_ERR_OUTPUT_FORMAT:Int = 59         ' Soundcard does not support the minimum features needed for this soundsystem (16bit stereo output).
Const FMOD_ERR_OUTPUT_INIT:Int = 60           ' Error initializing output device.
Const FMOD_ERR_OUTPUT_NOHARDWARE:Int = 61     ' FMOD_HARDWARE was specified but the sound card does not have the resources nescessary to play it.
Const FMOD_ERR_OUTPUT_NOSOFTWARE:Int = 62     ' Attempted to create a software sound but no software channels were specified in System::init.
Const FMOD_ERR_PAN:Int = 63                   ' Panning only works with mono or stereo sound sources.
Const FMOD_ERR_PLUGIN:Int = 64                ' An unspecified error has been returned from a 3rd party plugin.
Const FMOD_ERR_PLUGIN_INSTANCES:Int = 65      ' The number of allowed instances of a plugin has been exceeded.
Const FMOD_ERR_PLUGIN_MISSING:Int = 66        ' A requested output, dsp unit type or codec was not available.
Const FMOD_ERR_PLUGIN_RESOURCE:Int = 67       ' A resource that the plugin requires cannot be found. (ie the DLS file for MIDI playback)
Const FMOD_ERR_RECORD:Int = 68                ' An error occured trying to initialize the recording device.
Const FMOD_ERR_REVERB_INSTANCE:Int = 69       ' Specified Instance in FMOD_REVERB_PROPERTIES couldn't be set. Most likely because it is an invalid instance number, or another application has locked the EAX4 FX slot.
Const FMOD_ERR_SUBSOUND_ALLOCATED:Int = 70    ' This subsound is already being used by another sound, you cannot have more than one parent to a sound.  Null out the other parent's entry first.
Const FMOD_ERR_SUBSOUND_MODE:Int = 71         ' The subsound's mode bits do not match with the parent sound's mode bits.  See documentation for function that it was called with.
Const FMOD_ERR_SUBSOUNDS:Int = 72             ' The error occured because the sound referenced contains subsounds.  (ie you cannot play the parent sound as a static sample, only its subsounds.)
Const FMOD_ERR_TAGNOTFOUND:Int = 73           ' The specified tag could not be found or there are no tags.
Const FMOD_ERR_TOOMANYCHANNELS:Int = 74       ' The sound created exceeds the allowable input channel count.  This can be increased using the maxinputchannels parameter in System::setSoftwareFormat.
Const FMOD_ERR_UNIMPLEMENTED:Int = 75         ' Something in FMOD hasn't been implemented when it should be! contact support!
Const FMOD_ERR_UNINITIALIZED:Int = 76         ' This command failed because System::init or System::setDriver was not called.
Const FMOD_ERR_UNSUPPORTED:Int = 77           ' A command issued was not supported by this object.  Possibly a plugin without certain callbacks specified.
Const FMOD_ERR_UPDATE:Int = 78                ' An error caused by System::update occured.
Const FMOD_ERR_VERSION:Int = 79               ' The version number of this file format is not supported.

Const FMOD_ERR_EVENT_FAILED:Int = 80          ' An Event failed to be retrieved, most likely due to 'just fail' being specified as the max playbacks behavior.
Const FMOD_ERR_EVENT_INTERNAL:Int = 81        ' An error occured that wasn't supposed to.  See debug log for reason.
Const FMOD_ERR_EVENT_INFOONLY:Int = 82        ' Can't execute this command on an EVENT_INFOONLY event.
Const FMOD_ERR_EVENT_MAXSTREAMS:Int = 83      ' Event failed because 'Max streams' was hit when FMOD_INIT_FAIL_ON_MAXSTREAMS was specified.
Const FMOD_ERR_EVENT_MISMATCH:Int = 84        ' FSB mismatches the FEV it was compiled with or FEV was built for a different platform.
Const FMOD_ERR_EVENT_NAMECONFLICT:Int = 85    ' A category with the same name already exists.
Const FMOD_ERR_EVENT_NOTFOUND:Int = 86        ' The requested event, event group, event category or event property could not be found.

Const FMOD_DSP_TYPE_UNKNOWN:Int = 0
Const FMOD_DSP_TYPE_MIXER:Int = 1
Const FMOD_DSP_TYPE_OSCILLATOR:Int = 2
Const FMOD_DSP_TYPE_LOWPASS:Int = 3
Const FMOD_DSP_TYPE_ITLOWPASS:Int = 4
Const FMOD_DSP_TYPE_HIGHPASS:Int = 5
Const FMOD_DSP_TYPE_ECHO:Int = 6
Const FMOD_DSP_TYPE_FLANGE:Int = 7
Const FMOD_DSP_TYPE_DISTORTION:Int = 8
Const FMOD_DSP_TYPE_NORMALIZE:Int = 9
Const FMOD_DSP_TYPE_PARAMEQ:Int = 10
Const FMOD_DSP_TYPE_PITCHSHIFT:Int = 11
Const FMOD_DSP_TYPE_CHORUS:Int = 12
Const FMOD_DSP_TYPE_REVERB:Int = 13
Const FMOD_DSP_TYPE_VSTPLUGIN:Int = 14
Const FMOD_DSP_TYPE_WINAMPPLUGIN:Int = 15
Const FMOD_DSP_TYPE_ITECHO:Int = 16
Const FMOD_DSP_TYPE_COMPRESSOR:Int = 17
Const FMOD_DSP_TYPE_SFXREVERB:Int = 18
Const FMOD_DSP_TYPE_LOWPASS_SIMPLE:Int = 19

Const FMOD_DSP_ECHO_DELAY:Int = 0       ' Echo delay in ms.  10  to 5000.  Default = 500.
Const FMOD_DSP_ECHO_DECAYRATIO:Int = 1  ' Echo decay per delay.  0 to 1.  1.0 = No decay, 0.0 = total decay (ie simple 1 line delay).  Default = 0.5.
Const FMOD_DSP_ECHO_MAXCHANNELS:Int = 2 ' Maximum channels supported.  0 to 16.  0 = same as fmod's default output polyphony, 1 = mono, 2 = stereo etc.  See remarks for more.  Default = 0.  It is suggested to leave at 0!
Const FMOD_DSP_ECHO_DRYMIX:Int = 3      ' Volume of original signal to pass to output.  0.0 to 1.0. Default = 1.0.
Const FMOD_DSP_ECHO_WETMIX:Int = 4       ' Volume of echo signal to pass to output.  0.0 to 1.0. Default = 1.0.

Const FMOD_DSP_DISTORTION_LEVEL:Int = 0    ' Distortion value.  0.0 To 1.0.  Default = 0.5.

Const FMOD_DSP_PARAMEQ_CENTER:Int = 0     ' Frequency center.  20.0 to 22000.0.  Default = 8000.0.
Const FMOD_DSP_PARAMEQ_BANDWIDTH:Int = 1  ' Octave range around the center frequency to filter.  0.2 to 5.0.  Default = 1.0.
Const FMOD_DSP_PARAMEQ_GAIN:Int = 2        ' Frequency Gain.  0.05 to 3.0.  Default = 1.0. 

Const FMOD_SOUND_FORMAT_NONE:Int = 0
Const FMOD_SOUND_FORMAT_PCM8:Int = 1
Const FMOD_SOUND_FORMAT_PCM16:Int = 2
Const FMOD_SOUND_FORMAT_PCM24:Int = 3
Const FMOD_SOUND_FORMAT_PCM32:Int = 4
Const FMOD_SOUND_FORMAT_PCMFLOAT:Int = 5
Const FMOD_SOUND_FORMAT_GCADPCM:Int = 6
Const FMOD_SOUND_FORMAT_IMAADPCM:Int = 7
Const FMOD_SOUND_FORMAT_VAG:Int = 8
Const FMOD_SOUND_FORMAT_XMA:Int = 9
Const FMOD_SOUND_FORMAT_MPEG:Int = 10

