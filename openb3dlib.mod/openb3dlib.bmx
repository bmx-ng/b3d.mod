' Copyright (c) 2014 Mark Mcvittie, Angelo Rosina, Bruce A Henderson
'
' This software is provided 'as-is', without any express or implied
' warranty. In no event will the authors be held liable for any damages
' arising from the use of this software.
'
' Permission is granted to anyone to use this software for any purpose,
' including commercial applications, and to alter it and redistribute it
' freely, subject to the following restrictions:
'
'    1. The origin of this software must not be misrepresented; you must not
'    claim that you wrote the original software. If you use this software
'    in a product, an acknowledgment in the product documentation would be
'    appreciated but is not required.
'
'    2. Altered source versions must be plainly marked as such, and must not be
'    misrepresented as being the original software.
'
'    3. This notice may not be removed or altered from any source
'    distribution.
'
SuperStrict

Rem
bbdoc: 
End Rem
Module b3d.openb3dlib

ModuleInfo "Version: 1.00"
ModuleInfo "License: Wrapper - zlib/libpng"
ModuleInfo "License: OpenB3D - LGPL with static linking exception"
ModuleInfo "Copyright: Wrapper - 2014 Mark Mcvittie, Bruce A Henderson"
ModuleInfo "Copyright: Openb3d - Angelo Rosina"

ModuleInfo "History: 1.00 Initial Release"

ModuleInfo "CC_OPTS: -DOPENB3D_GLEW"
ModuleInfo "CC_OPTS: -DOPENB3D_BMX"

?win32
Import Pub.Glew
Import Pub.OpenGL ' order is important, glew before OpenGL
?macos
Import Pub.Glew
Import Pub.OpenGL ' order is important, glew before OpenGL
?linuxx86
Import Pub.Glew
Import Pub.OpenGL ' order is important, glew before OpenGL
?linuxx64
Import Pub.Glew
Import Pub.OpenGL ' order is important, glew before OpenGL
?raspberrypi
Import Pub.OpenGLES
?android
Import Pub.OpenGLES
?

Import "source.bmx"
