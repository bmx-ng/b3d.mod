' assimplib.bmx

Strict

Rem
bbdoc: Assimp
about: Wrapper for Open Asset Import library. Requires BaH.Boost.
End Rem
Module Openb3dlibs.Assimplib

ModuleInfo "Version: 0.38"
ModuleInfo "License: BSD-3-Clause"
ModuleInfo "Copyright: Wrapper - 2009-2017 Peter Scheutz, Mark Mcvittie"
ModuleInfo "Copyright: Library - 2006-2012 assimp team"
ModuleInfo "Source: https://github.com/markcwm/openb3dlibs.mod"
ModuleInfo "Source: https://github.com/Difference/blitzmax-assimp"

ModuleInfo "History: 0.38 Release on Jul 2017 - added source wrapper, mesh streams"
ModuleInfo "History: 0.36 Release on Sep 2014 - library wrapper, update to assimp v3.1.1"
ModuleInfo "History: 0.30 Release on Apr 2011"
ModuleInfo "History: 0.22 Release on Nov 2009"
ModuleInfo "History: 0.07 Initial Release on Jan 2009"

ModuleInfo "CC_OPTS: -fexceptions"
'ModuleInfo "CC_OPTS: -DASSIMP_ENABLE_BOOST_WORKAROUND"

Import Brl.Math
Import Brl.Retro

Import "source.bmx"
Import "common.bmx"

Include "types.bmx"
