Openb3dlibs
===========

Blitzmax Openb3d library collection

#### Newton Dynamics ####

Blitzmax library wrapper for Newton dynamics v3.13. Newton v3.13 source is included in the module but can also be found on <a href="https://github.com/MADEAPPS/newton-dynamics/releases">Github</a>.

The wrapper is not ready for use yet but there are a few basic examples.

#### License ####

Both the library and wrapper are licensed with the zlib license.

#### Assimp (Open Asset Import) ####

BlitzMax library wrapper for Assimp v3.1.1.

Assimp source is included with the module and [Boost](http://www.boost.org/users/history/) is required so use [BaH.Boost](https://github.com/maxmods/bah.mod), the Boost workaround option does not seem to work but this lacks threads so is not recommended. 

The wrapper is now a source import again and can load meshes from streams either incbin or zipstream. For zip functionality [Koriolis.Zipstream](https://github.com/maxmods/koriolis.mod) is required. It is now working in 64-bit but animations are not yet implemented.

#### License ####

Both the library and wrapper are licensed with the 3-clause BSD license.
