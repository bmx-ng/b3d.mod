' assimplib.bmx

Strict

Rem
bbdoc: Assimp library wrapper
about: Wrapper for Assimp (Open Asset Import) library. Imported by assimp.mod.
Requires BaH.Boost source code and Koriolis.Zipstream module binaries, see module info links.
To get BaH.Boost by Subversion open command-line and make sure you "cd" to bah.mod before checkout.
End Rem
Module Openb3dlibs.Assimplib

ModuleInfo "Version: 0.41"
ModuleInfo "License: BSD-3-Clause"
ModuleInfo "Copyright: Wrapper - 2009-2017 Peter Scheutz, Mark Mcvittie"
ModuleInfo "Copyright: Library - 2006-2012 Assimp team"
ModuleInfo "Source: https://github.com/markcwm/openb3dlibs.mod"
ModuleInfo "Source: svn checkout https://github.com/maxmods/bah.mod/trunk/boost.mod"
ModuleInfo "Source: https://github.com/maxmods/koriolis.mod"
ModuleInfo "Source: https://github.com/assimp/assimp"

ModuleInfo "History: 0.41 Release Aug 2017 - update to assimp 3.2"
ModuleInfo "History: 0.40 Release Aug 2017 - added zipstream, 64-bit wrapper"
ModuleInfo "History: 0.38 Release Jul 2017 - added source wrapper, incbin streams"
ModuleInfo "History: 0.36 Release Sep 2014 - library wrapper, update to assimp 3.1.1"
ModuleInfo "History: 0.30 Release Apr 2011"
ModuleInfo "History: 0.22 Release Nov 2009"
ModuleInfo "History: 0.07 Initial Release Jan 2009"

ModuleInfo "CC_OPTS: -fexceptions"

' defs.h
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_COMPRESSED_X" ' disable compressed .x (zip)
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_COMPRESSED_BLEND" ' disable compressed .blend (zip)
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_COMPRESSED_IFC" ' disable compressed .ifc (unzip)
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_COMPRESSED_XGL" ' disable compressed .xgl (zip)
'
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_CALCTANGENTS_PROCESS" ' disable specific post processing step
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_JOINVERTICES_PROCESS"
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_TRIANGULATE_PROCESS"
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_GENFACENORMALS_PROCESS"
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_GENVERTEXNORMALS_PROCESS"
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_REMOVEVC_PROCESS"
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_SPLITLARGEMESHES_PROCESS"
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_PRETRANSFORMVERTICES_PROCESS"
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_LIMITBONEWEIGHTS_PROCESS"
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_VALIDATEDS_PROCESS"
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_IMPROVECACHELOCALITY_PROCESS"
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_FIXINFACINGNORMALS_PROCESS"
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_REMOVE_REDUNDANTMATERIALS_PROCESS"
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_OPTIMIZEGRAPH_PROCESS"
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_SORTBYPTYPE_PROCESS"
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_FINDINVALIDDATA_PROCESS"
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_TRANSFORMTEXCOORDS_PROCESS"
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_GENUVCOORDS_PROCESS"
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_ENTITYMESHBUILDER_PROCESS"
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_MAKELEFTHANDED_PROCESS"
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_FLIPUVS_PROCESS"
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_FLIPWINDINGORDER_PROCESS"
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_OPTIMIZEMESHES_PROCESS"
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_OPTIMIZEANIMS_PROCESS"
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_OPTIMIZEGRAPH_PROCESS"
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_GENENTITYMESHES_PROCESS"
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_FIXTEXTUREPATHS_PROCESS"
'
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_DLL_EXPORT" ' build dll of library
'ModuleInfo "CC_OPTS: -DASSIMP_DLL" ' link library as dll
'ModuleInfo "CC_OPTS: -DASSIMP_DOXYGEN_BUILD" ' build Doxygen-friendly c-Struct typedefs
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_BOOST_WORKAROUND" ' build without boost - no threads/not threadsafe

' CMakeLists.txt
'ModuleInfo "CC_OPTS: -DOPENDDLPARSER_BUILD" ' build OpenDDL parser - data description language
'ModuleInfo "CC_OPTS: -DOPENDDL_NO_USE_CPP11" ' Assimp is not using c++11-support
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_OWN_ZLIB" ' disable building internal zlib

' ImporterRegistry.cpp - disable specific file format loader
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_X_IMPORTER" ' DirectX
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_3DS_IMPORTER" ' 3ds Max
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_MD3_IMPORTER" ' Quake III Mesh
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_MDL_IMPORTER" ' 3D GameStudio Mesh
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_MD2_IMPORTER" ' Quake II
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_PLY_IMPORTER" ' Stanford Polygon Library
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_ASE_IMPORTER" ' 3ds Max
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_OBJ_IMPORTER" ' Wavefront
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_HMP_IMPORTER" ' 3D GameStudio Terrain
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_SMD_IMPORTER" ' Valve Model
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_MDC_IMPORTER" ' Return to Castle Wolfenstein
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_MD5_IMPORTER" ' Doom 3
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_STL_IMPORTER" ' Stereolithography
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_LWO_IMPORTER" ' LightWave
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_DXF_IMPORTER" ' AutoCAD
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_NFF_IMPORTER" ' Sense8/WorldToolKit Neutral File Format
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_RAW_IMPORTER" ' PovRAY Raw
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_OFF_IMPORTER" ' Object File Format
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_AC_IMPORTER" ' AC3D
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_BVH_IMPORTER" ' Biovision (motion capture)
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_IRRMESH_IMPORTER" ' Irrlicht Mesh
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_IRR_IMPORTER" ' Irrlicht Scene
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_Q3D_IMPORTER" ' Quick3D
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_B3D_IMPORTER" ' BlitzBasic 3D
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_COLLADA_IMPORTER" ' DAE
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_TERRAGEN_IMPORTER" ' Terragen Terrain
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_CSM_IMPORTER" ' CharacterStudio (motion capture)
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_3D_IMPORTER" ' Unreal
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_LWS_IMPORTER" ' LightWave Scene
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_OGRE_IMPORTER" ' Ogre
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_OPENGEX_IMPORTER" ' Open Game Engine Exchange - uses OpenDDL
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_MS3D_IMPORTER" ' Milkshape 3D
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_COB_IMPORTER" ' TrueSpace
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_BLEND_IMPORTER" ' Blender 3D
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_Q3BSP_IMPORTER" ' Quake III BSP
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_NDO_IMPORTER" ' Izware Nendo
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_IFC_IMPORTER" ' Industry Foundation Classes
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_XGL_IMPORTER" ' .XGL (3d XML) .ZGL (compressed XML)
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_FBX_IMPORTER" ' Autodesk
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_ASSBIN_IMPORTER" ' Assimp Binary
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_C4D_IMPORTER" ' Cinema 4D - only compatible with MSVS

' Exporter.cpp - disable specific file format exporter
ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_EXPORT" ' disable all
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_COLLADA_EXPORTER" ' .DAE
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_X_EXPORTER" ' DirectX
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_STEP_EXPORTER" ' Industry Foundation Classes
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_OBJ_EXPORTER" ' Wavefront
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_STL_EXPORTER" ' Stereolithography
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_PLY_EXPORTER" ' Stanford Polygon Library
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_3DS_EXPORTER" ' 3ds Max
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_ASSBIN_EXPORTER" ' Assimp Binary
'ModuleInfo "CC_OPTS: -DASSIMP_BUILD_NO_ASSXML_EXPORTER" ' Assimp XML

Import Brl.Math
Import Brl.Retro
Import Koriolis.Zipstream

Import "source.bmx"
Import "common.bmx"

Include "types.bmx"

Rem
bbdoc: Returns the error text of the last failed import process.
about: See <a href="http://assimp.sourceforge.net/lib_html/class_assimp_1_1_importer.html">Assimp.cpp</a>
and <a href="http://assimp.sourceforge.net/lib_html/cimport_8h.html">cimport.h</a>.
End Rem
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
