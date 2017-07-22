' assimp.bmx

Strict

Rem
bbdoc: Assimp wrapper for Openb3d
about: Assimp mesh loader and helper functions.
End Rem
Module Openb3dlibs.Assimp

ModuleInfo "Version: 0.38"
ModuleInfo "License: BSD-3-Clause"
ModuleInfo "Copyright: Wrapper - 2009-2017 Peter Scheutz, Mark Mcvittie"
ModuleInfo "Copyright: Library - 2006-2012 assimp team"
ModuleInfo "Source: https://github.com/markcwm/openb3dlibs.mod"
ModuleInfo "Source: https://github.com/Difference/blitzmax-assimp"

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
