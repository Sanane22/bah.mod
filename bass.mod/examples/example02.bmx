'
' Play an mp3 via a TStream
'
' bass_track_baby.mp3 - for song “Pretty Baby, Are You Happy?” (composed by R.Dattatreya, arranged and recorded by A.Ustinov).
' ( http://www.ntonyx.com/mp3_songs.htm )
'
SuperStrict

Framework BaH.Bass
Import BRL.GLMax2D


If Not TBass.Init(-1,44100,0,Null,Null) Then
	DebugLog "Can't initialize device : " + TBass.ErrorGetCode()
	End
End If

Local file:TStream = ReadStream("resources/bass_track_baby.mp3")

Local stream:TBassStream = New TBassStream.CreateTStream(file, 0, 0)


If stream Then
	Local length:Long = stream.GetLength(BASS_POS_BYTE)

	If Not stream.Play(False) Then
		DebugLog "can't play... : "  + TBass.ErrorGetCode()
	Else
	
	Graphics 640, 480, 0
	
	Local active:Int = stream.IsActive()
	
	While active And Not KeyDown(key_escape)
	
		Cls
		

		' display some stuff And wait a bit
		Local _left:Int, _right:Int

		stream.GetLevel(_left, _right)

		Local pos:Long = stream.GetPosition(BASS_POS_BYTE)

		Local time:Double = stream.Bytes2Seconds(pos)


		DrawText "position - " + pos, 50, 50
		DrawText "elapsed  - " + Int(time/60) + ":" + Int(time Mod 60), 50, 70
		
		
		If active = BASS_ACTIVE_STALLED Then  ' playback has stalled

			DrawText "-- Buffering : " + stream.GetFilePosition(BASS_FILEPOS_BUFFER) + " --", 20, 90

		Else
			Local lwidth:Int = _left / 410.0
			DrawRect 100 - lwidth, 100, lwidth, 20
			DrawRect 110, 100, _right / 410.0, 20
		End If


		DrawText "CPU - " + TBass.GetCPU(), 240, 50


		Delay 50
		
		Flip
		
		active = stream.IsActive()

	Wend
	
	' wind the frequency down...

	stream.SlideAttribute(BASS_ATTRIB_FREQ, 1000, 500)

	Delay 300

	' ...And fade-out To avoid a "click"

	stream.SlideAttribute(BASS_ATTRIB_VOL, -1 , 200)

	' wait For slide To finish

	While stream.IsSliding(0)
		Delay 1
	Wend


	End If
Else
	DebugLog "didn't load : " + TBass.ErrorGetCode()
End If

TBass.Free()

End


