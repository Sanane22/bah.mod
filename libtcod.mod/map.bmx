' Copyright (c) 2008-2009 Bruce A Henderson
' All rights reserved.
'
' Redistribution and use in source and binary forms, with or without
' modification, are permitted provided that the following conditions are met:
'     * Redistributions of source code must retain the above copyright
'       notice, this list of conditions and the following disclaimer.
'     * Redistributions in binary form must reproduce the above copyright
'       notice, this list of conditions and the following disclaimer in the
'       documentation and/or other materials provided with the distribution.
'     * Neither the auther nor the names of its contributors may be used to 
'       endorse or promote products derived from this software without specific
'       prior written permission.
'
' THIS SOFTWARE IS PROVIDED BY Bruce A Henderson ``AS IS'' AND ANY
' EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
' WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
' DISCLAIMED. IN NO EVENT SHALL Bruce A Henderson BE LIABLE FOR ANY
' DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
' (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
' LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
' ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
' (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
' SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
'
SuperStrict

Import "common.bmx"

Rem
bbdoc: Allows to easily calculate the potential visible set of map cells from the player position.
about: A cell is potentially visible if the line of sight from the player to the cell in unobstructed.
End Rem
Type TCODMap

	Field objectPtr:Byte Ptr

	Rem
	bbdoc: 
	End Rem
	Function CreateMap:TCODMap(width:Int, height:Int)
		Return New TCODMap.Create(width, height)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:TCODMap(width:Int, height:Int)
		objectPtr = bmx_tcodmap_create(width, height)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetProperties(x:Int, y:Int, isTransparent:Int, isWalkable:Int)
		bmx_tcodmap_setproperties(objectPtr, x, y, isTransparent, isWalkable)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Clear()
		bmx_tcodmap_clear(objectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Copy(source:TCODMap)
		bmx_tcodmap_copy(objectPtr, source.objectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ComputeFov(playerX:Int, playerY:Int, maxRadius:Int = 0, lightWalls:Int = True, algo:Int = FOV_BASIC)
		bmx_tcodmap_computefov(objectPtr, playerX, playerY, maxRadius, lightWalls, algo)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsInFov:Int(x:Int, y:Int)
		Return bmx_tcodmap_isinfov(objectPtr, x, y)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsTransparent:Int(x:Int, y:Int)
		Return bmx_tcodmap_istransparent(objectPtr, x, y)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsWalkable:Int(x:Int, y:Int)
		Return bmx_tcodmap_iswalkable(objectPtr, x, y)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Free()
		If objectPtr Then
			bmx_tcodmap_delete(objectPtr)
			objectPtr = Null
		End If
	End Method
	
	Method Delete()
		Free()
	End Method

End Type

Rem
bbdoc: 
End Rem
Type TCODPath

	Field objectPtr:Byte Ptr
	
	Rem
	bbdoc: 
	End Rem
	Function CreatePath:TCODPath(map:TCODMap, diagonalCost:Float = 1.41)
		Return New TCODPath.Create(map, diagonalCost)
	End Function

	Rem
	bbdoc: 
	End Rem
	Method Create:TCODPath(map:TCODMap, diagonalCost:Float = 1.41)
		objectPtr = bmx_tcodpath_create(map.objectPtr, diagonalCost)
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Method Compute:Int(ox:Int, oy:Int, dx:Int, dy:Int)
		Return bmx_tcodpath_compute(objectPtr, ox, oy, dx, dy)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetOrigin(x:Int Var, y:Int Var)
		bmx_tcodpath_getorigin(objectPtr, Varptr x, Varptr y)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDestination(x:Int Var, y:Int Var)
		bmx_tcodpath_getdestination(objectPtr, Varptr x, Varptr y)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Size:Int()
		Return bmx_tcodpath_size(objectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Get(index:Int, x:Int Var, y:Int Var)
		bmx_tcodpath_get(objectPtr, index, Varptr x, Varptr y)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method IsEmpty:Int()
		Return bmx_tcodpath_isempty(objectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Walk:Int(x:Int Var, y:Int Var, recalculateWhenNeeded:Int)
		Return bmx_tcodpath_walk(objectPtr, Varptr x, Varptr y, recalculateWhenNeeded)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Free()
		If objectPtr Then
			bmx_tcodpath_delete(objectPtr)
			objectPtr = Null
		End If
	End Method
	
	Method Delete()
		Free()
	End Method
	
End Type


