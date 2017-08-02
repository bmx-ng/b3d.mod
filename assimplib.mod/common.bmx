' common.bmx

?ptr64
Const PAD:Int=2 ' 64-bit padding
Const ONE32:Int=0
?Not ptr64
Const PAD:Int=1
Const ONE32:Int=1
?

' config.h

' Input parameter to the #aiProcess_SortByPType step:
' Specifies which primitive types are removed by the step
Const AI_CONFIG_PP_SBP_REMOVE:String = "PP_SBP_REMOVE"

' types.h

' just for backwards compatibility, don't use these constants anymore
Const AI_SUCCESS:Int = $0
Const AI_FAILURE:Int = -$1
Const AI_OUTOFMEMORY:Int = -$3
Const AI_INVALIDFILE:Int = -$2
Const AI_INVALIDARG:Int = -$4

' Maximum dimension for strings, ASSIMP strings are zero terminated.
Const MAXLEN:Int = 1024

' postprocess.h

' enum aiPostProcessSteps - Defines the flags for all possible post processing step

Const aiProcess_CalcTangentSpace:Int = $1
Const aiProcess_JoinIdenticalVertices:Int = $2
Const aiProcess_MakeLeftHanded:Int = $4
Const aiProcess_Triangulate:Int = $8
Const aiProcess_RemoveComponent:Int = $10
Const aiProcess_GenNormals:Int = $20
Const aiProcess_GenSmoothNormals:Int = $40
Const aiProcess_SplitLargeMeshes:Int = $80
Const aiProcess_PreTransformVertices:Int = $100
Const aiProcess_LimitBoneWeights:Int = $200
Const aiProcess_ValidateDataStructure:Int = $400
Const aiProcess_ImproveCacheLocality:Int = $800
Const aiProcess_RemoveRedundantMaterials:Int = $1000
Const aiProcess_FixInfacingNormals:Int = $2000
Const aiProcess_SortByPType:Int = $8000
Const aiProcess_FindDegenerates:Int = $10000
Const aiProcess_FindInvalidData:Int = $20000
Const aiProcess_GenUVCoords:Int = $40000
Const aiProcess_TransformUVCoords:Int = $80000
Const aiProcess_FindInstances:Int = $100000
Const aiProcess_OptimizeMeshes:Int = $200000 
Const aiProcess_OptimizeGraph:Int = $400000
Const aiProcess_FlipUVs:Int = $800000
Const aiProcess_FlipWindingOrder:Int = $1000000
Const aiProcess_SplitByBoneCount:Int = $2000000
Const aiProcess_Debone:Int = $4000000

' Shortcut to match Direct3D conventions: left-handed geometry, top-left origin for UV coords and clockwise face order
Const aiProcess_ConvertToLeftHanded:Int = aiProcess_MakeLeftHanded | aiProcess_FlipUVs | aiProcess_FlipWindingOrder

' mesh.h

' Limits. These values are required to match the settings Assimp was compiled against.

' Supported number of vertex color sets per mesh
Const AI_MAX_NUMBER_OF_COLOR_SETS:Int = $8

' Supported number of texture coord sets (UV(W) channels) per mesh
Const AI_MAX_NUMBER_OF_TEXTURECOORDS:Int = $8

' enum aiPrimitiveType - Enumerates the types of geometric primitives supported by Assimp.
Const aiPrimitiveType_POINT:Int = $1
Const aiPrimitiveType_LINE:Int = $2
Const aiPrimitiveType_TRIANGLE:Int = $4
Const aiPrimitiveType_POLYGON:Int = $8

' material.h

' enum aiTextureOp
' enum aiTextureMapMode
' enum aiTextureMapping
' enum aiTextureType - Defines the purpose of a texture 

' Dummy value.
' No texture, but the value to be used as 'texture semantic' (#aiMaterialProperty::mSemantic)
' for all material properties *not* related to textures.
Const aiTextureType_NONE:Int = $0

' The texture is combined with the result of the diffuse lighting equation.
Const aiTextureType_DIFFUSE:Int = $1

' The texture is combined with the result of the specular lighting equation.
Const aiTextureType_SPECULAR:Int = $2

' The texture is combined with the result of the ambient lighting equation.
Const aiTextureType_AMBIENT:Int = $3

' The texture is added to the result of the lighting calculation.
' It isn't influenced by incoming light.
Const aiTextureType_EMISSIVE:Int = $4

' The texture is a height map.
' By convention, higher grey-scale values stand for higher elevations from the base height.
Const aiTextureType_HEIGHT:Int = $5

' The texture is a (tangent space) normal-map.
' Again, there are several conventions for tangent-space normal maps.
' Assimp does (intentionally) not differenciate here.
Const aiTextureType_NORMALS:Int = $6

' The texture defines the glossiness of the material.
' The glossiness is in fact the exponent of the specular (phong) lighting equation.
' Usually there is a conversion function defined to map the linear color values in the texture
' to a suitable exponent. Have fun.
Const aiTextureType_SHININESS:Int = $7

' The texture defines per-pixel opacity.
' Usually 'white' means opaque and 'black' means 'transparency'. Or quite the opposite. Have fun.
Const aiTextureType_OPACITY:Int = $8

' Displacement texture.
' The exact purpose and format is application-dependent.
' Higher color values stand for higher vertex displacements.
Const aiTextureType_DISPLACEMENT:Int = $9

' Lightmap texture (aka Ambient Occlusion).
' Both 'Lightmaps' and dedicated 'ambient occlusion maps' are covered by this material property.
' The texture contains a scaling value for the final color value of a pixel.
' It's intensity is not affected by incoming light.
Const aiTextureType_LIGHTMAP:Int = $A

' Reflection texture.
' Contains the color of a perfect mirror reflection.
' Rarely used, almost never for real-time applications.
Const aiTextureType_REFLECTION:Int = $B

' Unknown texture.
' A texture reference that does not match any of the definitions above is considered to be 'unknown'.
' It is still imported, but is excluded from any further postprocessing.
Const aiTextureType_UNKNOWN:Int = $C

' enum aiShadingMode
' enum aiTextureFlags
' enum aiBlendMode
' enum aiPropertyTypeInfo - material property buffer content type

Const aiPTI_Float:Int = $1
Const aiPTI_String:Int = $3
Const aiPTI_Integer:Int = $4
Const aiPTI_Buffer:Int = $5

' a few of the many matkey constants

Const AI_MATKEY_NAME:String = "?mat.name"
Const AI_MATKEY_TWOSIDED:String = "$mat.twosided"
Const AI_MATKEY_OPACITY:String = "$mat.opacity"
Const AI_MATKEY_SHININESS:String = "$mat.shininess"

Const AI_MATKEY_COLOR_DIFFUSE:String = "$clr.diffuse"
Const AI_MATKEY_COLOR_AMBIENT:String = "$clr.ambient"
Const AI_MATKEY_COLOR_SPECULAR:String = "$clr.specular"
Const AI_MATKEY_COLOR_EMISSIVE:String = "$clr.emissive"
Const AI_MATKEY_COLOR_TRANSPARENT:String = "$clr.transparent"
Const AI_MATKEY_COLOR_REFLECTIVE:String = "$clr.reflective"

' Pure key names for all texture-related properties

Const AI_MATKEY_TEXTURE_BASE:String = "$tex.file"
Const AI_MATKEY_UVWSRC_BASE:String = "$tex.uvwsrc"
Const AI_MATKEY_TEXOP_BASE:String = "$tex.op"
Const AI_MATKEY_MAPPING_BASE:String = "$tex.mapping"
Const AI_MATKEY_TEXBLEND_BASE:String = "$tex.blend"
Const AI_MATKEY_MAPPINGMODE_U_BASE:String = "$tex.mapmodeu"
Const AI_MATKEY_MAPPINGMODE_V_BASE:String = "$tex.mapmodev"
Const AI_MATKEY_TEXMAP_AXIS_BASE:String = "$tex.mapaxis"
Const AI_MATKEY_UVTRANSFORM_BASE:String = "$tex.uvtrafo"
Const AI_MATKEY_TEXFLAGS_BASE:String = "$tex.flags"

Extern

' Assimp.cpp

Rem
bbdoc: Reads the given file and returns its content.
about: See <a href="http://assimp.sourceforge.net/lib_html/class_assimp_1_1_importer.html">Assimp.cpp</a>
and <a href="http://assimp.sourceforge.net/lib_html/cimport_8h.html">cimport.h</a>.
End Rem
	Function aiImportFile:Byte Ptr( pFile$z, pFlags:Int ) = "aiImportFile"

Rem
bbdoc: Reads the given file from a given memory buffer.
about: See <a href="http://assimp.sourceforge.net/lib_html/class_assimp_1_1_importer.html">Assimp.cpp</a>
and <a href="http://assimp.sourceforge.net/lib_html/cimport_8h.html">cimport.h</a>.
End Rem
	Function aiImportFileFromMemory:Byte Ptr( pBuffer:Byte Ptr,pLength:Int,pFlags:Int,pHint$z ) = "aiImportFileFromMemory"

Rem
bbdoc: Releases all resources associated with the given import process.
about: See <a href="http://assimp.sourceforge.net/lib_html/class_assimp_1_1_importer.html">Assimp.cpp</a>
and <a href="http://assimp.sourceforge.net/lib_html/cimport_8h.html">cimport.h</a>.
End Rem
	Function aiReleaseImport( pScene:Byte Ptr ) = "aiReleaseImport"

Rem
bbdoc: Returns the error text of the last failed import process.
about: See <a href="http://assimp.sourceforge.net/lib_html/class_assimp_1_1_importer.html">Assimp.cpp</a>
and <a href="http://assimp.sourceforge.net/lib_html/cimport_8h.html">cimport.h</a>.
End Rem
	Function aiIsExtensionSupported_:Int( pFile$z ) = "aiIsExtensionSupported"

' MaterialSystem.cpp

Rem
bbdoc: Get a color (3 or 4 floats) from the material.
about: See <a href="http://assimp.sourceforge.net/lib_html/structai_material.html">MaterialSystem.cpp</a>
and <a href="http://assimp.sourceforge.net/lib_html/material_8h.html">material.h</a>.
End Rem
	Function aiGetMaterialColor:Int( pMat:Byte Ptr, pKey$z, iType:Int, ..
				index:Int, pOut:Byte Ptr ) = "aiGetMaterialColor"
				
Rem
bbdoc: Get a string from the material.
about: See <a href="http://assimp.sourceforge.net/lib_html/structai_material.html">MaterialSystem.cpp</a>
and <a href="http://assimp.sourceforge.net/lib_html/material_8h.html">material.h</a>.
End Rem
	Function aiGetMaterialString:Int( pMat:Byte Ptr, pKey$z, iType:Int, ..
				index:Int, pOut:Byte Ptr ) = "aiGetMaterialString"
				
Rem
bbdoc: Get an array of integer values from the material.
about: See <a href="http://assimp.sourceforge.net/lib_html/structai_material.html">MaterialSystem.cpp</a>
and <a href="http://assimp.sourceforge.net/lib_html/material_8h.html">material.h</a>.
End Rem
	Function aiGetMaterialIntegerArray:Int( pMat:Byte Ptr, pKey$z, iType:Int, ..
				index:Int, pOut:Int Ptr, pMax:Int Ptr ) = "aiGetMaterialIntegerArray"
				
Rem
bbdoc: Get an array of floating-point values from the material.
about: See <a href="http://assimp.sourceforge.net/lib_html/structai_material.html">MaterialSystem.cpp</a>
and <a href="http://assimp.sourceforge.net/lib_html/material_8h.html">material.h</a>.
End Rem
	Function aiGetMaterialFloatArray:Int( pMat:Byte Ptr, pKey$z, iType:Int, ..
				index:Int, pOut:Float Ptr, pMax:Int Ptr ) = "aiGetMaterialFloatArray"
				
Rem
bbdoc: Get all values pertaining to a particular texture slot from the material.
about: See <a href="http://assimp.sourceforge.net/lib_html/structai_material.html">MaterialSystem.cpp</a>
and <a href="http://assimp.sourceforge.net/lib_html/material_8h.html">material.h</a>.
End Rem
	Function aiGetMaterialTexture:Int( pMat:Byte Ptr, texType:Int, index:Int, path:Byte Ptr, ..
				mapping:Byte Ptr=Null, uvindex:Int Ptr=Null, blend:Float Ptr=Null, ..
				op:Byte Ptr=Null, mapmode:Byte Ptr=Null, flags:Int Ptr=Null ) = "aiGetMaterialTexture"
				
Rem
bbdoc: Get the number of textures for a particular texture type.
about: See <a href="http://assimp.sourceforge.net/lib_html/structai_material.html">MaterialSystem.cpp</a>
and <a href="http://assimp.sourceforge.net/lib_html/material_8h.html">material.h</a>.
End Rem
	Function aiGetMaterialTextureCount:Int( pMat:Byte Ptr, texType:Int ) = "aiGetMaterialTextureCount"
	
End Extern
