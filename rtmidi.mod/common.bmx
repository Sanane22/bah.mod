' Copyright (c) 2010-2018 Bruce A Henderson
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

?macos
Import "-framework CoreMIDI"
Import "-framework CoreFoundation"
Import "-framework CoreAudio"
?linux
Import "-lasound"
?win32
Import "-lwinmm"
?

Import "source.bmx"

Extern

	Function bmx_rtmidiin_create:Byte Ptr(clientName:String, queueSizeLimit:Int, api:Int)
	Function bmx_rtmidiin_openPort(handle:Byte Ptr, portNumber:Int, portName:String)
	Function bmx_rtmidiin_closePort(handle:Byte Ptr)
	Function bmx_rtmidiin_openVirtualPort(handle:Byte Ptr, portName:String)
	Function bmx_rtmidiin_getPortCount:Int(handle:Byte Ptr)
	Function bmx_rtmidiin_getPortName:String(handle:Byte Ptr, portNumber:Int)
	Function bmx_rtmidiin_free(handle:Byte Ptr)
	Function bmx_rtmidiin_getMessage:Byte[](handle:Byte Ptr, timestamp:Double Ptr)
	Function bmx_rtmidiin_ignoreTypes(handle:Byte Ptr, midiSysex:Int, midiTime:Int, midiSense:Int)
	Function bmx_rtmidiin_isPortOpen:Int(handle:Byte Ptr)

	Function bmx_rtmidiout_create:Byte Ptr(clientName:String, api:Int)
	Function bmx_rtmidiout_openPort(handle:Byte Ptr, portNumber:Int, portName:String)
	Function bmx_rtmidiout_closePort(handle:Byte Ptr)
	Function bmx_rtmidiout_openVirtualPort(handle:Byte Ptr, portName:String)
	Function bmx_rtmidiout_getPortCount:Int(handle:Byte Ptr)
	Function bmx_rtmidiout_getPortName:String(handle:Byte Ptr, portNumber:Int)
	Function bmx_rtmidiout_sendMessage(handle:Byte Ptr, message:Byte Ptr, length:Int)
	Function bmx_rtmidiout_free(handle:Byte Ptr)
	Function bmx_rtmidiout_isPortOpen:Int(handle:Byte Ptr)

	Function bmx_rtmidi_getVersion:String()
	Function bmx_rtmidi_getCompiledApi:Int[]()

End Extern

Rem
bbdoc: Search for a working compiled API.
End Rem
Const API_UNSPECIFIED:Int = 0
Rem
bbdoc: Macintosh OS-X Core Midi API.
End Rem
Const API_MACOSX_CORE:Int = 1
Rem
bbdoc: The Advanced Linux Sound Architecture API.
End Rem
Const API_LINUX_ALSA:Int = 2
Rem
bbdoc: The JACK Low-Latency MIDI Server API.
End Rem
Const API_UNIX_JACK:Int = 3
Rem
bbdoc: The Microsoft Multimedia MIDI API.
End Rem
Const API_WINDOWS_MM:Int = 4
