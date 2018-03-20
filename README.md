Openb3dlibs
===========

Blitzmax Openb3d library collection

#### Newton Dynamics ####

Blitzmax library wrapper for Newton dynamics 3.13. Newton 3.13 source is included in the module but can also be found on <a href="https://github.com/MADEAPPS/newton-dynamics/releases">Github</a>.

The wrapper is not ready for use yet but there are a few basic examples.

#### License ####

Both the library and wrapper are licensed with the zlib license.

#### Assimp (Open Asset Import) ####

BlitzMax library wrapper for Assimp 3.2.

Assimp source is included with this module and [Boost](http://www.boost.org/users/history/) is required, specifically [BaH.Boost](https://github.com/maxmods/bah.mod). There is a Boost workaround option which can be enabled in assimplib.bmx (and then comment the boost imports in source.bmx) but this is not recommended as it lacks threads and is not threadsafe ie. can't be access by more than one thread at a time. To enable a specific file format comment the define in assimplib.bmx and uncomment the import/s in source.bmx. You can also disable specific post processing steps in the same way.

The wrapper is a source import and can load meshes from streams either incbin or zipstream, so for unzip functionality [Koriolis.Zipstream](https://github.com/maxmods/koriolis.mod) is required. The module works in 32-bit and 64-bit but animations are not yet implemented.

#### License ####

Both the library and wrapper are licensed with the 3-clause BSD license.
