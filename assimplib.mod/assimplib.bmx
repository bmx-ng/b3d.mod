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
bbdoc: Assimp
about: Wrapper for Open Asset Import library. Requires BaH.Boost.
End Rem
Module Openb3dlibs.Assimplib

ModuleInfo "Version: 0.40"
ModuleInfo "License: BSD-3-Clause License"
ModuleInfo "Copyright: 2009-2011 Peter Scheutz"
ModuleInfo "Authors: Peter Scheutz, Mark Mcvittie"
ModuleInfo "Source: https://github.com/markcwm/openb3dlibs.mod"
ModuleInfo "Original: https://github.com/Difference/blitzmax-assimp"

ModuleInfo "History: 0.40 Release on Jul 2017 - source wrapper, mesh streams"
ModuleInfo "History: 0.35 Release on Sep 2014 - library wrapper, Assimp v3.1.1"
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
