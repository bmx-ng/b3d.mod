' Copyright (c) 2009-2011 Peter Scheutz
' All rights reserved.
'
' Redistribution and use in source and binary forms, with or without
' modification, are permitted provided that the following conditions are met:
'   * Redistributions of source code must retain the above copyright
'     notice, this list of conditions and the following disclaimer.
'   * Redistributions in binary form must reproduce the above copyright
'     notice, this list of conditions and the following disclaimer in the
'     documentation and/or other materials provided with the distribution.
'   * Neither the name of copyright holder nor the names of its contributors
'     may be used to endorse or promote products derived from this software
'     without specific prior written permission.
'
' THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 'AS IS'
' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
' IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
' ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
' LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
' CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
' SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
' INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
' CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
' ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
' THE POSSIBILITY OF SUCH DAMAGE.

Strict

Rem
bbdoc: Assimp wrapper for Openb3d
about: Assimp mesh loader and helper functions.
End Rem
Module Openb3dlibs.Assimp

ModuleInfo "Version: 0.40"
ModuleInfo "License: BSD-3-Clause License"
ModuleInfo "Copyright: 2009-2011 Peter Scheutz"
ModuleInfo "Authors: Peter Scheutz, Mark Mcvittie"
ModuleInfo "Source: https://github.com/markcwm/openb3dlibs.mod"
ModuleInfo "Original: https://github.com/Difference/blitzmax-assimp"

Import Openb3d.B3dglgraphics
Import Openb3dlibs.Assimplib

Include "types.bmx"

Rem
bbdoc: Like <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=LoadMesh">LoadMesh</a> but without a parent parameter.
End Rem
Function aiLoadMesh:TMesh( filename:String )
	Return aiLoader.LoadMesh( filename )
End Function

Rem
bbdoc: Like <a href="http://www.blitzbasic.com/b3ddocs/command.php?name=LoadMesh">FitMesh</a>.
End Rem
Function aiFitAnimMesh( m:TEntity, x#, y#, z#, w#, h#, d#, uniform:Int=False )
	aiHelper.FitAnimMesh( m, x, y, z, w, h, d, uniform )
End Function

Rem
bbdoc: Creates a list of valid files to load.
EndRem
Function aiEnumFiles( list:TList, dir:String, skipExt:TList )
	aiHelper.EnumFiles( list, dir, skipExt )
End Function
