' Copyright (c) 2010-2011 Bruce A Henderson
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

Rem
bbdoc: Text Encoding Conversion
End Rem
Module BaH.libiconv

?Not win32
'ModuleInfo "CC_OPTS: -DLIBICONV_STATIC"
?win32
ModuleInfo "LD_OPTS: -L%PWD%/lib/win32/"
?

Import BRL.Stream
Import "common.bmx"

Rem
bbdoc: 
End Rem
Type TIConv

	Field iconvPtr:Byte Ptr
	Global errno:Int

	Rem
	bbdoc: Creates a new TIConv instance for the specified conversion.
	about: The values permitted for fromcode and tocode and the supported combinations are system dependent.
	The following encodings are supported, in all combinations :
	<table>
	<tr><td>European languages</td><td>ASCII, ISO−8859−{1,2,3,4,5,7,9,10,13,14,15,16}, KOI8−R, KOI8−U, KOI8−RU, CP{1250,1251,1252,1253,1254,1257},
		CP{850,866,1131}, Mac{Roman,CentralEurope,Iceland,Croatian,Romania}, Mac{Cyrillic,Ukraine,Greek,Turkish}, Macintosh</td></tr>
	<tr><td>Semitic languages</td><td>ISO−8859−{6,8}, CP{1255,1256}, CP862, Mac{Hebrew,Arabic}</td></tr>
	<tr><td>Japanese</td><td>EUC−JP, SHIFT_JIS, CP932, ISO−2022−JP, ISO−2022−JP−2, ISO−2022−JP−1</td></tr>
	<tr><td>Chinese</td><td>EUC−CN, HZ, GBK, CP936, GB18030, EUC−TW, BIG5, CP950, BIG5−HKSCS, BIG5−HKSCS:2001, BIG5−HKSCS:1999, ISO−2022−CN, ISO−2022−CN−EXT</td>
	<tr><td>Korean</td><td>EUC−KR, CP949, ISO−2022−KR, JOHAB</td></tr>
	<tr><td>Armenian</td><td>ARMSCII−8</td></tr>
	<tr><td>Georgian</td><td>Georgian−Academy, Georgian−PS</td></tr>
	<tr><td>Tajik</td><td>KOI8−T</td></tr>
	<tr><td>Kazakh</td><td>PT154, RK1048</td></tr>
	<tr><td>Thai</td><td>TIS−620, CP874, MacThai</td></tr>
	<tr><td>Laotian</td><td>MuleLao−1, CP1133</td></tr>
	<tr><td>Vietnamese</td><td>VISCII, TCVN, CP1258</td></tr>
	<tr><td>Platform specifics</td><td>HP−ROMAN8, NEXTSTEP</td></tr>
	<tr><td>Full Unicode</td><td>UTF−8<br/>
		UCS−2, UCS−2BE, UCS−2LE<br/>
		UCS−4, UCS−4BE, UCS−4LE<br/>
		UTF−16, UTF−16BE, UTF−16LE<br/>
		UTF−32, UTF−32BE, UTF−32LE<br/>
		UTF−7<br/>
		C99, JAVA</td></tr>
	</table>
	<p>
	The empty encoding name "" is equivalent to "char": it denotes the locale dependent character encoding.
	</p>
	<p>
	When the string "//TRANSLIT" is appended to tocode, transliteration is activated. This means that when a character cannot be
	represented in the target character set, it can be approximated through one or several characters that look similar to the original character.
	</p>
	<p>
	When the string "//IGNORE" is appended to tocode, characters that cannot be represented in the target character set will be silently discarded.
	</p>
	<p>
	An instance of TIConv can only be used in a single thread - not concurrently in multiple threads.
	</p>
	End Rem
	Function Create:TIConv(toCode:String, fromCode:String)
		Local this:TIConv = New TIConv
		
		Local t:Byte Ptr = toCode.ToCString()
		Local f:Byte Ptr = fromCode.ToCString()
		
		this.iconvPtr = iconv_open(t, f)
		
		MemFree(t)
		MemFree(f)
		
		If Int(Int Ptr(this.iconvPtr)) <> -1 Then
			Return this
		End If
		
		errno = bmx_getErrno()
	End Function
	
	Rem
	bbdoc: Perform character set conversion.
	returns: The number of characters converted in a non-reversible way during this call; reversible conversions are not counted. In case of error, it returns −1.
	about: Converts one multibyte character at a time, and for each character conversion it increments @inbuf and decrements @inbytesleft by
	the number of converted input bytes, it increments @outbuf and decrements @outbytesleft by the number of converted output bytes,
	and it updates the conversion state. If the character encoding of the input is stateful, the method can also convert a sequence of input bytes to an
	update of the conversion state without producing any output bytes; such input is called a shift sequence. The conversion can stop for four reasons:
	<ul>
	<li>An invalid multibyte sequence is encountered in the input. In this case it sets LastError to EILSEQ and returns -1. @inbuf is left pointing to the
	beginning of the invalid multibyte sequence.</li>
	<li>The input byte sequence has been entirely converted, i.e. @inbytesleft has gone down to 0. In this case the method returns the number of non-reversible
	conversions performed during this call.</li>
	<li>An incomplete multibyte sequence is encountered in the input, and the input byte sequence terminates after it. In this case it sets LastError to EINVAL
	and returns −1. @inbuf is left pointing to the beginning of the incomplete multibyte sequence.</li>
	<li>The output buffer has no more room for the next converted character. In this case it sets LastError to E2BIG and returns −1.</li>
	</ul>
	<p>
	The following errors can occur, among others:
	<table>
	<tr><td>E2BIG</td><td>There is not sufficient room at @outbuf.</td></tr>
	<tr><td>EILSEQ</td><td>An invalid multibyte sequence has been encountered in the input.</td></tr>
	<tr><td>EINVAL</td><td>An incomplete multibyte sequence has been encountered in the input.</td></tr>
	</table>
	</p>
	End Rem
	Method Convert:Int(inbuf:Byte Ptr Ptr, inBytesLeft:Int Var, outbuf:Byte Ptr Ptr, outBytesLeft:Int Var)
		Local ret:Int = bmx_iconv(iconvPtr, inbuf, Varptr inBytesLeft, outbuf, Varptr outBytesLeft)
		If ret = -1 Then
			errno = bmx_getErrno()
		End If
		Return ret
	End Method
	
	Rem
	bbdoc: Returns the last error number.
	End Rem
	Function LastError:Int()
		Return errno
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method ConvertStream(inStream:TStream, outStream:TStream, maxOut:Int = 0)
		
		Const MAX_BUFFER:Int = 10
		Local inBuffer:Byte[MAX_BUFFER]
		Local inOffset:Byte Ptr
		Local inSize:Int
		
		Local outBuffer:Byte[MAX_BUFFER]
		Local outOffset:Byte Ptr
		Local outSize:Int = MAX_BUFFER
		
		Local output:Int
		Local conv:Int
		
		If maxOut > 0 And outSize > maxOut Then
			outSize = maxOut
		End If
		
		
		While True
		
			inOffset = inBuffer
			Local n:Int = inStream.Read(inOffset, MAX_BUFFER)
			
			' finished reading?
			' collect any remaining data
			If n = 0 Then

				output = outSize
				outOffset = outBuffer
				conv = Convert(Null, inSize, Varptr outOffset, outSize)
				
				output :- outSize
				
				If output > 0 Then
					outStream.Write(outBuffer, output)
				End If
			
				Exit
				
			End If
			
			inSize = n
			
			Local moreToRead:Int
			
			Repeat
				moreToRead = False
		
				output = outSize
				outOffset = outBuffer
				conv = Convert(Varptr inOffset, inSize, Varptr outOffset, outSize)
				
				output :- outSize
	
				If conv = -1 Then
					If errno = EINVAL Then
					
					ElseIf errno = E2BIG Then
	
						' copy anything that we have converted
						If output > 0 Then
							outStream.Write(outBuffer, output)
						End If
						
						' have we reached the predefined max size?
						If maxOut <> 0 Then
							' yep... finished here
							'Exit
	
							' TODO : replace this with above (only for testing)
							outSize = maxOut
	
						Else
							' no, so we can simply continue
							
							outSize = MAX_BUFFER
						End If
						
						moreToRead = True
						
					End If
				Else
					' no error
	
					outStream.Write(outBuffer, output)
	
					If maxOut > 0 And outSize > maxOut Then
						outSize = maxOut
					Else
						outSize = MAX_BUFFER
					End If
			
				End If
			
			Until Not moreToRead
			
		Wend
		
	End Method

	Rem
	bbdoc: 
	End Rem
	Method Free()
		If iconvPtr Then
			iconv_close(iconvPtr)
			iconvPtr = Null
		End If
	End Method
	
	Method Delete()
		Free()
	End Method
End Type

