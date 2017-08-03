' assimplib.bmx

Strict

Rem
bbdoc: Assimp library wrapper
about: Wrapper for Assimp (Open Asset Import) library. Imported by assimp.mod.
Requires BaH.Boost source and Koriolis.Zipstream module binaries, see source links below.
To get BaH.Boost with Subversion open command-line and make sure you "cd" to bah.mod before checkout.
End Rem
Module Openb3dlibs.Assimplib

ModuleInfo "Version: 0.40"
ModuleInfo "License: BSD-3-Clause"
ModuleInfo "Copyright: Wrapper - 2009-2017 Peter Scheutz, Mark Mcvittie"
ModuleInfo "Copyright: Library - 2006-2012 Assimp team"
ModuleInfo "Source: https://github.com/markcwm/openb3dlibs.mod"
ModuleInfo "Source: svn checkout https://github.com/maxmods/bah.mod/trunk/boost.mod"
ModuleInfo "Source: https://github.com/maxmods/koriolis.mod"

ModuleInfo "History: 0.40 Release Aug 2017 - added zipstream, 64-bit wrapper"
ModuleInfo "History: 0.38 Release Jul 2017 - added source wrapper, incbin streams"
ModuleInfo "History: 0.36 Release Sep 2014 - library wrapper, update to assimp v3.1.1"
ModuleInfo "History: 0.30 Release Apr 2011"
ModuleInfo "History: 0.22 Release Nov 2009"
ModuleInfo "History: 0.07 Initial Release Jan 2009"

ModuleInfo "CC_OPTS: -fexceptions"
'ModuleInfo "CC_OPTS: -DASSIMP_ENABLE_BOOST_WORKAROUND"

Import Brl.Math
Import Brl.Retro
Import Koriolis.Zipstream

Import "source.bmx"
Import "common.bmx"

Include "types.bmx"

Function aiIsExtensionSupported:Int( pFile:String )
	Return aiIsExtensionSupported_( pFile )
End Function

Rem
 Memo:
 aiSetImportPropertyInteger caused crash, was missing p parameter
 changed aiGetMaterialTexture pMat:Int Ptr to :Byte Ptr
 changed aiImportFile:Int Ptr to :Byte Ptr
 added aiImportFileFromMemory
 unwrapped aiIsExtensionSupported caused "double free or corruption" error in ubuntu x64
EndRem
