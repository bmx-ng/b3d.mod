' Copyright (c) 2014 Mark Mcvittie, Bruce A Henderson
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

' Openb3d declarations and library functions

Strict

Import b3d.b3d
Import brl.map
Import brl.Graphics
Import b3d.OpenB3dLib
Import brl.standardio

'Import "source.bmx"

' Global declarations
' -------------------
Extern
	Function BackBufferToTex_( tex:Byte Ptr, frame:Int )="BackBufferToTex"
	Function BufferToTex_( tex:Byte Ptr, buffer:Byte Ptr, frame:Int )="BufferToTex"
	Function CameraToTex_( tex:Byte Ptr, cam:Byte Ptr, frame:Int )="CameraToTex"
	Function DepthBufferToTex_( tex:Byte Ptr, frame:Int )="DepthBufferToTex"
	Function TexToBuffer_( tex:Byte Ptr, buffer:Byte Ptr, frame:Int )="TexToBuffer"
' Minib3d Only
	Function MeshCullRadius_( ent:Byte Ptr, radius:Float )="MeshCullRadius"
' Blitz3D functions, A-Z
	Function AddAnimSeq_:Int( ent:Byte Ptr, length:Int )="AddAnimSeq"
	Function AddMesh_( mesh1:Byte Ptr, mesh2:Byte Ptr )="AddMesh"
	Function AddTriangle_:Int( surf:Byte Ptr, v0:Int, v1:Int, v2:Int )="AddTriangle"
	Function AddVertex_:Int( surf:Byte Ptr, x:Float, y:Float, z:Float, u:Float, v:Float, w:Float )="AddVertex"
	Function AmbientLight_( r:Float, g:Float, b:Float )="AmbientLight"
	Function AntiAlias_( samples:Int )="AntiAlias"
	Function Animate_( ent:Byte Ptr, Mode:Int, speed:Float, seq:Int, trans:Int )="Animate"
	Function Animating_:Int( ent:Byte Ptr )="Animating"
	Function AnimLength_( ent:Byte Ptr )="AnimLength"
	Function AnimSeq_:Int( ent:Byte Ptr )="AnimSeq"
	Function AnimTime_:Float( ent:Byte Ptr )="AnimTime"
	Function BrushAlpha_( brush:Byte Ptr, a:Float )="BrushAlpha"
	Function BrushBlend_( brush:Byte Ptr, blend:Int )="BrushBlend"
	Function BrushColor_( brush:Byte Ptr, r:Float, g:Float, b:Float )="BrushColor"
	Function BrushFX_( brush:Byte Ptr, fx:Int )="BrushFX"
	Function BrushShininess_( brush:Byte Ptr, s:Float )="BrushShininess"
	Function BrushTexture_( brush:Byte Ptr, tex:Byte Ptr, frame:Int, index:Int )="BrushTexture"
	Function CameraClsColor_( cam:Byte Ptr, r:Float, g:Float, b:Float )="CameraClsColor"
	Function CameraClsMode_( cam:Byte Ptr, cls_depth:Int, cls_zbuffer:Int )="CameraClsMode"
	Function CameraFogColor_( cam:Byte Ptr, r:Float, g:Float, b:Float )="CameraFogColor"
	Function CameraFogMode_( cam:Byte Ptr, Mode:Int )="CameraFogMode"
	Function CameraFogRange_( cam:Byte Ptr, nnear:Float, nfar:Float )="CameraFogRange"
	Function CameraPick_:Byte Ptr( cam:Byte Ptr, x:Float, y:Float )="CameraPick"
	Function CameraProject_( cam:Byte Ptr, x:Float, y:Float, z:Float )="CameraProject"
	Function CameraProjMode_( cam:Byte Ptr, Mode:Int )="CameraProjMode"
	Function CameraRange_( cam:Byte Ptr, nnear:Float, nfar:Float )="CameraRange"
	Function CameraViewport_( cam:Byte Ptr, x:Int, y:Int, width:Int, height:Int )="CameraViewport"
	Function CameraZoom_( cam:Byte Ptr, zoom:Float )="CameraZoom"
	Function ClearCollisions_()="ClearCollisions"
	Function ClearSurface_( surf:Byte Ptr, clear_verts:Int, clear_tris:Int )="ClearSurface"
	Function ClearTextureFilters_()="ClearTextureFilters"
	Function ClearWorld_( entities:Int, brushes:Int, textures:Int )="ClearWorld"
	Function CollisionEntity_:Byte Ptr( ent:Byte Ptr, index:Int )="CollisionEntity"
	Function Collisions_( src_no:Int, dest_no:Int, method_no:Int, response_no:Int )="Collisions"
	Function CollisionNX_:Float( ent:Byte Ptr, index:Int )="CollisionNX"
	Function CollisionNY_:Float( ent:Byte Ptr, index:Int )="CollisionNY"
	Function CollisionNZ_:Float( ent:Byte Ptr, index:Int )="CollisionNZ"
	Function CollisionSurface_:Byte Ptr( ent:Byte Ptr, index:Int )="CollisionSurface"
	Function CollisionTime_:Float( ent:Byte Ptr, index:Int )="CollisionTime"
	Function CollisionTriangle_:Int( ent:Byte Ptr, index:Int )="CollisionTriangle"
	Function CollisionX_:Float( ent:Byte Ptr, index:Int )="CollisionX"
	Function CollisionY_:Float( ent:Byte Ptr, index:Int )="CollisionY"
	Function CollisionZ_:Float( ent:Byte Ptr, index:Int )="CollisionZ"
	Function CountChildren_:Int( ent:Byte Ptr )="CountChildren"
	Function CountCollisions_:Int( ent:Byte Ptr )="CountCollisions"
	Function CopyEntity_:Byte Ptr( ent:Byte Ptr, parent:Byte Ptr )="CopyEntity"
	Function CopyMesh_:Byte Ptr( mesh:Byte Ptr, parent:Byte Ptr )="CopyMesh"
	Function CountSurfaces_:Int( mesh:Byte Ptr )="CountSurfaces"
	Function CountTriangles_:Int( surf:Byte Ptr )="CountTriangles"
	Function CountVertices_:Int( surf:Byte Ptr )="CountVertices"
	Function CreateBlob_:Byte Ptr( fluid:Byte Ptr, radius:Float, parent_ent:Byte Ptr )="CreateBlob"
	Function CreateBrush_:Byte Ptr( r:Float, g:Float, b:Float )="CreateBrush"
	Function CreateCamera_:Byte Ptr( parent:Byte Ptr )="CreateCamera"
	Function CreateCone_:Byte Ptr( segments:Int, solid:Int, parent:Byte Ptr )="CreateCone"
	Function CreateCylinder_:Byte Ptr( segments:Int, solid:Int, parent:Byte Ptr )="CreateCylinder"
	Function CreateCube_:Byte Ptr( parent:Byte Ptr )="CreateCube"
	Function CreateFluid_:Byte Ptr()="CreateFluid"
	Function CreateGeosphere_:Byte Ptr( size:Int, parent:Byte Ptr )="CreateGeosphere"
	Function CreateMesh_:Byte Ptr( parent:Byte Ptr )="CreateMesh"
	Function CreateLight_:Byte Ptr( light_type:Int, parent:Byte Ptr )="CreateLight"
	Function CreatePivot_:Byte Ptr( parent:Byte Ptr )="CreatePivot"
	Function CreatePlane_:Byte Ptr( divisions:Int, parent:Byte Ptr )="CreatePlane"
	Function CreateQuad_:Byte Ptr( parent:Byte Ptr )="CreateQuad"
	Function CreateShadow_:Byte Ptr( parent:Byte Ptr, Static:Int )="CreateShadow"
	Function CreateSphere_:Byte Ptr( segments:Int, parent:Byte Ptr )="CreateSphere"
	Function CreateSprite_:Byte Ptr( parent:Byte Ptr )="CreateSprite"
	Function CreateSurface_:Byte Ptr( mesh:Byte Ptr, brush:Byte Ptr )="CreateSurface"
	Function CreateStencil_:Byte Ptr()="CreateStencil"
	Function CreateTerrain_:Byte Ptr( size:Int, parent:Byte Ptr )="CreateTerrain"
	Function CreateTexture_:Byte Ptr( width:Int, height:Int, flags:Int, frames:Int )="CreateTexture"
	Function CreateVoxelSprite_:Byte Ptr( slices:Int, parent:Byte Ptr )="CreateVoxelSprite"
	Function DeltaPitch_:Float( ent1:Byte Ptr, ent2:Byte Ptr )="DeltaPitch"
	Function DeltaYaw_:Float( ent1:Byte Ptr, ent2:Byte Ptr )="DeltaYaw"
	Function EntityAlpha_( ent:Byte Ptr, alpha:Float )="EntityAlpha"
	Function EntityAutoFade_( ent:Byte Ptr, near:Float, far:Float )="EntityAutoFade"
	Function EntityBlend_( ent:Byte Ptr, blend:Int )="EntityBlend"
	Function EntityBox_( ent:Byte Ptr, x:Float, y:Float, z:Float, w:Float, h:Float, d:Float )="EntityBox"
	Function EntityClass_:Byte Ptr( ent:Byte Ptr )="EntityClass"
	Function EntityCollided_:Byte Ptr( ent:Byte Ptr, type_no:Int )="EntityCollided"
	Function EntityColor_( ent:Byte Ptr, red:Float, green:Float, blue:Float )="EntityColor"
	Function EntityDistance_:Float( ent1:Byte Ptr, ent2:Byte Ptr )="EntityDistance"
	Function EntityFX_( ent:Byte Ptr, fx:Int )="EntityFX"
	Function EntityInView_:Int( ent:Byte Ptr, cam:Byte Ptr )="EntityInView"
	Function EntityName_:Byte Ptr( ent:Byte Ptr )="EntityName"
	Function EntityOrder_( ent:Byte Ptr, order:Int )="EntityOrder"
	Function EntityParent_( ent:Byte Ptr, parent_ent:Byte Ptr, glob:Int )="EntityParent"
	Function EntityPick_:Byte Ptr( ent:Byte Ptr, Range:Float )="EntityPick"
	Function EntityPickMode_( ent:Byte Ptr, pick_mode:Int, obscurer:Int )="EntityPickMode"
	Function EntityPitch_:Float( ent:Byte Ptr, glob:Int )="EntityPitch"
	Function EntityRadius_( ent:Byte Ptr, radius_x:Float, radius_y:Float )="EntityRadius"
	Function EntityRoll_:Float( ent:Byte Ptr, glob:Int )="EntityRoll"
	Function EntityShininess_( ent:Byte Ptr, shine:Float )="EntityShininess"
	Function EntityTexture_( ent:Byte Ptr, tex:Byte Ptr, frame:Int, index:Int )="EntityTexture"
	Function EntityType_( ent:Byte Ptr, type_no:Int, recursive:Int )="EntityType"
	Function EntityVisible_:Int( src_ent:Byte Ptr, dest_ent:Byte Ptr )="EntityVisible"
	Function EntityX_:Float( ent:Byte Ptr, glob:Int )="EntityX"
	Function EntityY_:Float( ent:Byte Ptr, glob:Int )="EntityY"
	Function EntityYaw_:Float( ent:Byte Ptr, glob:Int )="EntityYaw"
	Function EntityZ_:Float( ent:Byte Ptr, glob:Int )="EntityZ"
	Function ExtractAnimSeq_:Int( ent:Byte Ptr, first_frame:Int, last_frame:Int, seq:Int )="ExtractAnimSeq"
	Function FindChild_:Byte Ptr( ent:Byte Ptr, child_name$z )="FindChild"
	Function FindSurface_:Byte Ptr( mesh:Byte Ptr, brush:Byte Ptr )="FindSurface"
	Function FitMesh_( mesh:Byte Ptr, x:Float, y:Float, z:Float, width:Float, height:Float, depth:Float, uniform:Int )="FitMesh"
	Function FlipMesh_( mesh:Byte Ptr )="FlipMesh"
	Function FreeBrush_( brush:Byte Ptr )="FreeBrush"
	Function FreeEntity_( ent:Byte Ptr )="FreeEntity"
	Function FreeShadow_( shad:Byte Ptr )="FreeShadow"
	Function FreeTexture_( tex:Byte Ptr )="FreeTexture"
	Function GeosphereHeight_( geo:Byte Ptr, h:Float )="GeosphereHeight"
	Function GetBrushTexture_:Byte Ptr( brush:Byte Ptr, index:Int )="GetBrushTexture"
	Function GetChild_:Byte Ptr( ent:Byte Ptr, child_no:Int )="GetChild"
	Function GetEntityBrush_:Byte Ptr( ent:Byte Ptr )="GetEntityBrush"
	Function GetEntityType_:Int( ent:Byte Ptr )="GetEntityType"
	Function GetMatElement_:Float( ent:Byte Ptr, row:Int, col:Int )="GetMatElement"
	Function GetParentEntity_:Byte Ptr( ent:Byte Ptr )="GetParentEntity"
	Function GetSurface_:Byte Ptr( mesh:Byte Ptr, surf_no:Int )="GetSurface"
	Function GetSurfaceBrush_:Byte Ptr( surf:Byte Ptr )	="GetSurfaceBrush"
	Function Graphics3D_( width:Int, height:Int, depth:Int, Mode:Int, rate:Int )="Graphics3D"
	Function GraphicsResize_( width:Int, height:Int )="GraphicsResize"
	Function SetRenderState_( capability:Int, flag:Int ) = "SetRenderState"
	Function HandleSprite_( sprite:Byte Ptr, h_x:Float, h_y:Float )="HandleSprite"
	Function HideEntity_( ent:Byte Ptr )="HideEntity"
	Function LightColor_( light:Byte Ptr, red:Float, green:Float, blue:Float )="LightColor"
	Function LightConeAngles_( light:Byte Ptr, inner_ang:Float, outer_ang:Float )="LightConeAngles"
	Function LightRange_( light:Byte Ptr, Range:Float )="LightRange"
	Function LinePick_:Byte Ptr( x:Float, y:Float, z:Float, dx:Float, dy:Float, dz:Float, radius:Float )="LinePick"
	Function LoadAnimMesh_:Byte Ptr( file$z, parent:Byte Ptr )="LoadAnimMesh"
	Function LoadAnimTexture_:Byte Ptr( file$z, flags:Int, frame_width:Int, frame_height:Int, first_frame:Int, frame_count:Int )="LoadAnimTexture"
	Function LoadBrush_:Byte Ptr( file$z, flags:Int, u_scale:Float, v_scale:Float )="LoadBrush"
	Function LoadGeosphere_:Byte Ptr( file$z, parent:Byte Ptr )="LoadGeosphere"
	Function LoadMesh_:Byte Ptr( file$z, parent:Byte Ptr )="LoadMesh"
	Function LoadTerrain_:Byte Ptr( file$z, parent:Byte Ptr )="LoadTerrain"
	Function LoadTexture_:Byte Ptr( file$z, flags:Int )="LoadTexture"
	Function LoadSprite_:Byte Ptr( tex_file$z, tex_flag:Int, parent:Byte Ptr )="LoadSprite"
	Function MeshCSG_:Byte Ptr( m1:Byte Ptr, m2:Byte Ptr, method_no:Int )="MeshCSG"
	Function MeshDepth_:Float( mesh:Byte Ptr )="MeshDepth"
	Function MeshesIntersect_:Int( mesh1:Byte Ptr, mesh2:Byte Ptr )="MeshesIntersect"
	Function MeshHeight_:Float( mesh:Byte Ptr )="MeshHeight"
	Function MeshWidth_:Float( mesh:Byte Ptr )="MeshWidth"
	Function ModifyGeosphere_( geo:Byte Ptr, x:Int, z:Int, new_height:Float )="ModifyGeosphere"
	Function ModifyTerrain_( terr:Byte Ptr, x:Int, z:Int, new_height:Float )="ModifyTerrain"
	Function MoveEntity_( ent:Byte Ptr, x:Float, y:Float, z:Float )="MoveEntity"
	Function NameEntity_( ent:Byte Ptr, name$z )="NameEntity"
	Function PaintEntity_( ent:Byte Ptr, brush:Byte Ptr )="PaintEntity"
	Function PaintMesh_( mesh:Byte Ptr, brush:Byte Ptr )="PaintMesh"
	Function PaintSurface_( surf:Byte Ptr, brush:Byte Ptr )="PaintSurface"
	Function PickedEntity_:Byte Ptr()="PickedEntity"
	Function PickedNX_:Float()="PickedNX"
	Function PickedNY_:Float()="PickedNY"
	Function PickedNZ_:Float()="PickedNZ"
	Function PickedSurface_:Byte Ptr()="PickedSurface"
	Function PickedTime_:Float()="PickedTime"
	Function PickedTriangle_:Int()="PickedTriangle"
	Function PickedX_:Float()="PickedX"
	Function PickedY_:Float()="PickedY"
	Function PickedZ_:Float()="PickedZ"
	Function PointEntity_( ent:Byte Ptr, target_ent:Byte Ptr, roll:Float )="PointEntity"
	Function PositionEntity_( ent:Byte Ptr, x:Float, y:Float, z:Float, glob:Int )="PositionEntity"
	Function PositionMesh_( mesh:Byte Ptr, px:Float, py:Float, pz:Float )="PositionMesh"
	Function PositionTexture_( tex:Byte Ptr, u_pos:Float, v_pos:Float )="PositionTexture"
	Function ProjectedX_:Float()="ProjectedX"
	Function ProjectedY_:Float()="ProjectedY"
	Function ProjectedZ_:Float()="ProjectedZ"
	Function RenderWorld_()="RenderWorld"
	Function RepeatMesh_:Byte Ptr( mesh:Byte Ptr, parent:Byte Ptr )="RepeatMesh"
	Function ResetEntity_( ent:Byte Ptr )="ResetEntity"
	Function RotateEntity_( ent:Byte Ptr, x:Float, y:Float, z:Float, glob:Int )="RotateEntity"
	Function RotateMesh_( mesh:Byte Ptr, pitch:Float, yaw:Float, roll:Float )="RotateMesh"
	Function RotateSprite_( sprite:Byte Ptr, ang:Float )="RotateSprite"
	Function RotateTexture_( tex:Byte Ptr, ang:Float )="RotateTexture"
	Function ScaleEntity_( ent:Byte Ptr, x:Float, y:Float, z:Float, glob:Int )="ScaleEntity"
	Function ScaleMesh_( mesh:Byte Ptr, sx:Float, sy:Float, sz:Float )="ScaleMesh"
	Function ScaleSprite_( sprite:Byte Ptr, s_x:Float, s_y:Float )="ScaleSprite"
	Function ScaleTexture_( tex:Byte Ptr, u_scale:Float, v_scale:Float )="ScaleTexture"
	Function SetAnimTime_( ent:Byte Ptr, time:Float, seq:Int )="SetAnimTime"
	Function SetCubeFace_( tex:Byte Ptr, face:Int )="SetCubeFace"
	Function SetCubeMode_( tex:Byte Ptr, Mode:Int )="SetCubeMode"
	Function ShowEntity_( ent:Byte Ptr )="ShowEntity"
	Function SpriteRenderMode_( sprite:Byte Ptr, Mode:Int )="SpriteRenderMode"
	Function SpriteViewMode_( sprite:Byte Ptr, Mode:Int )="SpriteViewMode"
	Function StencilAlpha_( stencil:Byte Ptr, a:Float )="StencilAlpha"
	Function StencilClsColor_( stencil:Byte Ptr, r:Float, g:Float, b:Float )="StencilClsColor"
	Function StencilClsMode_( stencil:Byte Ptr, cls_depth:Int, cls_zbuffer:Int )="StencilClsMode"
	Function StencilMesh_( stencil:Byte Ptr, mesh:Byte Ptr, Mode:Int )="StencilMesh"
	Function StencilMode_( stencil:Byte Ptr, m:Int, o:Int )="StencilMode"
	Function TerrainHeight_:Float( terr:Byte Ptr, x:Int, z:Int )="TerrainHeight"
	Function TerrainX_:Float( terr:Byte Ptr, x:Float, y:Float, z:Float )="TerrainX"
	Function TerrainY_:Float( terr:Byte Ptr, x:Float, y:Float, z:Float )="TerrainY"
	Function TerrainZ_:Float( terr:Byte Ptr, x:Float, y:Float, z:Float )="TerrainZ"
	Function TextureBlend_( tex:Byte Ptr, blend:Int )="TextureBlend"
	Function TextureCoords_( tex:Byte Ptr, coords:Int )="TextureCoords"
	Function TextureHeight_:Int( tex:Byte Ptr )="TextureHeight"
	Function TextureFilter_( match_text$z, flags:Int )="TextureFilter"
	Function TextureName_:Byte Ptr( tex:Byte Ptr )="TextureName"
	Function TextureWidth_:Int( tex:Byte Ptr )="TextureWidth"
	Function TFormedX_:Float()="TFormedX"
	Function TFormedY_:Float()="TFormedY"
	Function TFormedZ_:Float()="TFormedZ"
	Function TFormNormal_( x:Float, y:Float, z:Float, src_ent:Byte Ptr, dest_ent:Byte Ptr )="TFormNormal"
	Function TFormPoint_( x:Float, y:Float, z:Float, src_ent:Byte Ptr, dest_ent:Byte Ptr )="TFormPoint"
	Function TFormVector_( x:Float, y:Float, z:Float, src_ent:Byte Ptr, dest_ent:Byte Ptr )="TFormVector"
	Function TranslateEntity_( ent:Byte Ptr, x:Float, y:Float, z:Float, glob:Int )="TranslateEntity"
	Function TriangleVertex_:Int( surf:Byte Ptr, tri_no:Int, corner:Int )="TriangleVertex"
	Function TurnEntity_( ent:Byte Ptr, x:Float, y:Float, z:Float, glob:Int )="TurnEntity"
	Function UpdateNormals_( mesh:Byte Ptr )="UpdateNormals"
	Function UpdateTexCoords_( surf:Byte Ptr )="UpdateTexCoords"
	Function UpdateWorld_( anim_speed:Float )="UpdateWorld"
	Function UseStencil_( stencil:Byte Ptr )="UseStencil"
	Function VectorPitch_:Float( vx:Float, vy:Float, vz:Float )="VectorPitch"
	Function VectorYaw_:Float( vx:Float, vy:Float, vz:Float )="VectorYaw"
	Function VertexAlpha_:Float( surf:Byte Ptr, vid:Int )="VertexAlpha"
	Function VertexBlue_:Float( surf:Byte Ptr, vid:Int )="VertexBlue"
	Function VertexColor_( surf:Byte Ptr, vid:Int, r:Float, g:Float, b:Float, a:Float )="VertexColor"
	Function VertexCoords_( surf:Byte Ptr, vid:Int, x:Float, y:Float, z:Float )="VertexCoords"
	Function VertexGreen_:Float( surf:Byte Ptr, vid:Int )="VertexGreen"
	Function VertexNormal_( surf:Byte Ptr, vid:Int, nx:Float, ny:Float, nz:Float )="VertexNormal"
	Function VertexNX_:Float( surf:Byte Ptr, vid:Int )="VertexNX"
	Function VertexNY_:Float( surf:Byte Ptr, vid:Int )="VertexNY"
	Function VertexNZ_:Float( surf:Byte Ptr, vid:Int )="VertexNZ"
	Function VertexRed_:Float( surf:Byte Ptr, vid:Int )="VertexRed"
	Function VertexTexCoords_( surf:Byte Ptr, vid:Int, u:Float, v:Float, w:Float, coord_set:Int )="VertexTexCoords"
	Function VertexU_:Float( surf:Byte Ptr, vid:Int, coord_set:Int )="VertexU"
	Function VertexV_:Float( surf:Byte Ptr, vid:Int, coord_set:Int )="VertexV"
	Function VertexW_:Float( surf:Byte Ptr, vid:Int, coord_set:Int )="VertexW"
	Function VertexX_:Float( surf:Byte Ptr, vid:Int )="VertexX"
	Function VertexY_:Float( surf:Byte Ptr, vid:Int )="VertexY"
	Function VertexZ_:Float( surf:Byte Ptr, vid:Int )="VertexZ"
	Function VoxelSpriteMaterial_( voxelspr:Byte Ptr, mat:Byte Ptr )="VoxelSpriteMaterial"
	Function Wireframe_( enable:Int )="Wireframe"
' ***extras***
	Function EntityScaleX_:Float( ent:Byte Ptr, glob:Int )="EntityScaleX"
	Function EntityScaleY_:Float( ent:Byte Ptr, glob:Int )="EntityScaleY"
	Function EntityScaleZ_:Float( ent:Byte Ptr, glob:Int )="EntityScaleZ"
	Function LoadShader_:Byte Ptr( ShaderName$z, VshaderFileName$z, FshaderFileName$z )="LoadShader"
	Function CreateShader_:Byte Ptr( ShaderName$z, VshaderString$z, FshaderString$z )="CreateShader"
	Function ShadeSurface_( surf:Byte Ptr, material:Byte Ptr )="ShadeSurface"
	Function ShadeMesh_( mesh:Byte Ptr, material:Byte Ptr )="ShadeMesh"
	Function ShadeEntity_( ent:Byte Ptr, material:Byte Ptr )="ShadeEntity"
	Function ShaderTexture_( material:Byte Ptr, tex:Byte Ptr, name$z, index:Int )="ShaderTexture"
	Function SetFloat_( material:Byte Ptr, name$z, v1:Float )="SetFloat"
	Function SetFloat2_( material:Byte Ptr, name$z, v1:Float, v2:Float )="SetFloat2"
	Function SetFloat3_( material:Byte Ptr, name$z, v1:Float, v2:Float, v3:Float )="SetFloat3"
	Function SetFloat4_( material:Byte Ptr, name$z, v1:Float, v2:Float, v3:Float, v4:Float )="SetFloat4"
	Function UseFloat_( material:Byte Ptr, name$z, v1:Float Ptr )="UseFloat"
	Function UseFloat2_( material:Byte Ptr, name$z, v1:Float Ptr, v2:Float Ptr )="UseFloat2"
	Function UseFloat3_( material:Byte Ptr, name$z, v1:Float Ptr, v2:Float Ptr, v3:Float Ptr )="UseFloat3"
	Function UseFloat4_( material:Byte Ptr, name$z, v1:Float Ptr, v2:Float Ptr, v3:Float Ptr, v4:Float Ptr )="UseFloat4"
	Function SetInteger_( material:Byte Ptr, name$z, v1:Int )="SetInteger"
	Function SetInteger2_( material:Byte Ptr, name$z, v1:Int, v2:Int )="SetInteger2"
	Function SetInteger3_( material:Byte Ptr, name$z, v1:Int, v2:Int, v3:Int )="SetInteger3"
	Function SetInteger4_( material:Byte Ptr, name$z, v1:Int, v2:Int, v3:Int, v4:Int )="SetInteger4"
	Function UseInteger_( material:Byte Ptr, name$z, v1:Int Ptr )="UseInteger"
	Function UseInteger2_( material:Byte Ptr, name$z, v1:Int Ptr, v2:Int Ptr )="UseInteger2"
	Function UseInteger3_( material:Byte Ptr, name$z, v1:Int Ptr, v2:Int Ptr, v3:Int Ptr )="UseInteger3"
	Function UseInteger4_( material:Byte Ptr, name$z, v1:Int Ptr, v2:Int Ptr, v3:Int Ptr, v4:Int Ptr )="UseInteger4"
	Function UseSurface_( material:Byte Ptr, name$z, surf:Byte Ptr, vbo:Int )="UseSurface"
	Function UseMatrix_( material:Byte Ptr, name$z, Mode:Int )="UseMatrix"
	Function LoadMaterial_:Byte Ptr( filename$z, flags:Int, frame_width:Int, frame_height:Int, first_frame:Int, frame_count:Int )="LoadMaterial"
	Function ShaderMaterial_( material:Byte Ptr, tex:Byte Ptr, name$z, index:Int )="ShaderMaterial"
	Function CreateOcTree_:Byte Ptr( w:Float, h:Float, d:Float, parent_ent:Byte Ptr )="CreateOcTree"
	Function OctreeBlock_( octree:Byte Ptr, mesh:Byte Ptr, level:Int, X:Float, Y:Float, Z:Float, Near:Float, Far:Float )="OctreeBlock"
	Function OctreeMesh_( octree:Byte Ptr, mesh:Byte Ptr, level:Int, X:Float, Y:Float, Z:Float, Near:Float, Far:Float )="OctreeMesh"

End Extern

Private

Global globals:TGlobal=New TGlobal

Public


' Constants
' ---------

Const USE_MAX2D:Int=True ' true to enable max2d/minib3d integration


' Blitz2D functions
' -----------------


Rem
bbdoc: Begin using Max2D functions.
End Rem
Function BeginMax2D()

	' by Oddball
	glPopClientAttrib()
	glPopAttrib()
	glMatrixMode(GL_MODELVIEW)
	glPopMatrix()
	glMatrixMode(GL_PROJECTION)
	glPopMatrix()
	glMatrixMode(GL_TEXTURE)
	glPopMatrix()
	glMatrixMode(GL_COLOR)
	glPopMatrix()

End Function

Rem
bbdoc: End using Max2D functions.
End Rem
Function EndMax2D()

	' save the Max2D settings for later - by Oddball
	glPushAttrib(GL_ALL_ATTRIB_BITS)
	glPushClientAttrib(GL_CLIENT_ALL_ATTRIB_BITS)
	glMatrixMode(GL_MODELVIEW)
	glPushMatrix()
	glMatrixMode(GL_PROJECTION)
	glPushMatrix()
	glMatrixMode(GL_TEXTURE)
	glPushMatrix()
	glMatrixMode(GL_COLOR)
	glPushMatrix()
	
	TGlobal.EnableStates()
	glDisable(GL_TEXTURE_2D)
	
	glLightModeli(GL_LIGHT_MODEL_COLOR_CONTROL,GL_SEPARATE_SPECULAR_COLOR)
	glLightModeli(GL_LIGHT_MODEL_LOCAL_VIEWER,GL_TRUE)
	
	glClearDepth(1.0)						
	glDepthFunc(GL_LEQUAL)
	glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST)

	glAlphaFunc(GL_GEQUAL,0.5)
	
End Function


' Wrapper object types
' --------------------

Type TGlobal

	Global blob:TBlob=New TBlob
	Global brush:TBrush=New TBrush
	Global cam:TCamera=New TCamera
	Global ent:TEntity=New TEntity
	Global fluid:TFluid=New TFluid
	Global geo:TGeosphere=New TGeosphere
	Global light:TLight=New TLight
	Global mat:TMaterial=New TMaterial
	Global material:TShader=New TShader
	Global mesh:TMesh=New TMesh
	Global octree:TOcTree=New TOcTree
	Global piv:TPivot=New TPivot
	Global shad:TShadowObject=New TShadowObject
	Global sprite:TSprite=New TSprite
	Global stencil:TStencil=New TStencil
	Global surf:TSurface=New TSurface
	Global terr:TTerrain=New TTerrain
	Global tex:TTexture=New TTexture
	Global voxelspr:TVoxelSprite=New TVoxelSprite

	Function GraphicsInit()
	
		TextureFilter("",9)
?Not linuxarm
		glewInit() ' required for ARB funcs
?
		' get hardware info and set vbo_enabled accordingly (use THardwareInfo.VBOSupport)
		THardwareInfo.GetInfo()
		
		If USE_MAX2D=True
		
			' save the Max2D settings for later - by Oddball
			glPushAttrib(GL_ALL_ATTRIB_BITS)
			glPushClientAttrib(GL_CLIENT_ALL_ATTRIB_BITS)
			glMatrixMode(GL_MODELVIEW)
			glPushMatrix()
			glMatrixMode(GL_PROJECTION)
			glPushMatrix()
			glMatrixMode(GL_TEXTURE)
			glPushMatrix()
			glMatrixMode(GL_COLOR)
			glPushMatrix()
		
		EndIf
		
		EnableStates()
		
		glLightModeli(GL_LIGHT_MODEL_COLOR_CONTROL,GL_SEPARATE_SPECULAR_COLOR)
		glLightModeli(GL_LIGHT_MODEL_LOCAL_VIEWER,GL_TRUE)
		
		glClearDepth(1.0)						
		glDepthFunc(GL_LEQUAL)
		glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST)
		
		glAlphaFunc(GL_GEQUAL,0.5)
		
	End Function
	
	Function EnableStates()
	
		glEnable(GL_LIGHTING)
   		glEnable(GL_DEPTH_TEST)
		glEnable(GL_FOG)
		glEnable(GL_CULL_FACE)
		glEnable(GL_SCISSOR_TEST)
		
		glEnable(GL_NORMALIZE)
		
		glEnableClientState(GL_VERTEX_ARRAY)
		glEnableClientState(GL_COLOR_ARRAY)
		glEnableClientState(GL_NORMAL_ARRAY)
		
		SetRenderState(GL_COLOR_ARRAY,1) ' when drawing with Max2d
		SetRenderState(GL_NORMAL_ARRAY,1) ' when using flat shading
		
	End Function

End Type

Rem
bbdoc: Blob entity
End Rem
Type TBlob Extends TEntity

	Method NewBlob:TBlob( inst:Byte Ptr )
	
		Local blob:TBlob=New TBlob
		entity_map.Insert( inst, blob )
		blob.instance=inst
		Return blob
		
	End Method
	
End Type

Type TBrush

	Global brush_map:TPtrMap=New TPtrMap

	Field instance:Byte Ptr
	
	Method NewBrush:TBrush( inst:Byte Ptr )
	
		Local brush:TBrush=New TBrush
		brush_map.Insert( inst, brush )
		brush.instance=inst
		Return brush
		
	End Method
	
	Method DeleteBrush( inst:Byte Ptr )
	
		brush_map.Remove( inst )
	
	End Method
	
	Method BrushValue:TBrush( inst:Byte Ptr )
	
		Return TBrush( brush_map.ValueForKey( inst ) )
	
	End Method
	
	Method BrushExists:Byte Ptr( brush:TBrush )
	
		If brush=Null
			Return Null
		Else
			Return brush.instance
		EndIf
	
	End Method
	
End Type

Type TCamera Extends TEntity

	Method NewCamera:TCamera( inst:Byte Ptr )
	
		Local cam:TCamera=New TCamera
		entity_map.Insert( inst, cam )
		cam.instance=inst
		Return cam
		
	End Method
	
End Type

Type TEntity

	Global entity_map:TPtrMap=New TPtrMap

	Field instance:Byte Ptr
	
	Method NewEntity:TEntity(inst:Byte Ptr)

		Local ent:TEntity=New TEntity
		entity_map.Insert( inst, ent )
		ent.instance=inst
		Return ent
		
	End Method
	
	Method DeleteEntity(inst:Byte Ptr)
	
		entity_map.Remove( inst )
	
	End Method

	Method EntityValue:TEntity( inst:Byte Ptr )
	
		Return TEntity( entity_map.ValueForKey( inst ) )
	
	End Method

	Function EntityExists:Byte Ptr( ent:TEntity )
	
		If ent=Null
			Return Null
		Else
			Return ent.instance
		EndIf
	
	End Function
	
	' Recursively counts all children of an entity.
	Function CountAllChildren:Int( ent:TEntity, no_children:Int=0 )

		Local children%=CountChildren( ent )
		
		For Local id:Int=1 To children
			no_children :+ 1
			no_children=CountAllChildren( GetChild( ent, id ), no_children)
		Next
		
		Return no_children
		
	End Function
	
	' Returns the specified child entity of a parent entity.
	Method GetChildFromAll:TEntity( child_no:Int, no_children:Int Var, ent:TEntity=Null )

		If ent=Null Then ent=Self
		
		Local ent2:TEntity=Null
		Local children%=CountChildren( ent )
		
		For Local id:Int=1 To children
			no_children=no_children+1
			If no_children=child_no Then Return GetChild( ent, id )
			
			If ent2=Null
				ent2=GetChildFromAll( child_no, no_children, GetChild( ent, id ) )
			EndIf
		Next
		
		Return ent2
		
	End Method
	
End Type

Rem
bbdoc: Fluid mesh entity
End Rem
Type TFluid Extends TMesh

	Method NewFluid:TFluid( inst:Byte Ptr )
	
		Local fluid:TFluid=New TFluid
		entity_map.Insert( inst, fluid )
		fluid.instance=inst
		Return fluid
		
	End Method
	
End Type

Type TGeosphere Extends TTerrain

	Method NewGeosphere:TGeosphere(inst:Byte Ptr)
	
		Local geo:TGeosphere=New TGeosphere
		entity_map.Insert( inst, geo )
		geo.instance=inst
		Return geo
		
	End Method
	
End Type

Rem
bbdoc: Hardware-info
about: Contains @{Function GetInfo()} and @{DisplayInfo(LogFile:Int=False)}.
End Rem
Type THardwareInfo

	' by klepto2
	Global ScreenWidth:Int = DesktopWidth() ' added
	Global ScreenHeight:Int = DesktopHeight()
	Global ScreenDepth:Int = DesktopDepth()
	Global ScreenHertz:Int = DesktopHertz()

	Global Vendor:String
	Global Renderer:String
	Global OGLVersion:String

	Global Extensions:String
	Global VBOSupport:Int		' Vertex Buffer Object
	Global GLTCSupport:Int		' OpenGL's TextureCompression
	Global S3TCSupport:Int		' S3's TextureCompression
	Global AnIsoSupport:Int		' An-Istropic Filtering
	Global MultiTexSupport:Int	' MultiTexturing
	Global TexBlendSupport:Int	' TextureBlend
	Global CubemapSupport:Int	' CubeMapping
	Global DepthmapSupport:Int	' DepthTexturing
	Global VPSupport:Int		' VertexProgram (ARBvp1.0)
	Global FPSupport:Int		' FragmentProgram (ARBfp1.0)
	Global ShaderSupport:Int	' glSlang Shader Program
	Global VSSupport:Int		' glSlang VertexShader
	Global FSSupport:Int		' glSlang FragmentShader
	Global SLSupport:Int		' OpenGL Shading Language 1.00

	Global MaxTextures:Int
	Global MaxTexSize:Int
	Global MaxLights:Int

	Function GetInfo()
	
		Local Extensions:String

		' Get HardwareInfo
		Vendor = String.FromCString(Byte Ptr(glGetString(GL_VENDOR)))
		Renderer = String.FromCString(Byte Ptr(glGetString(GL_RENDERER))) 
		OGLVersion = String.FromCString(Byte Ptr(glGetString(GL_VERSION)))

		' Get Extensions
		Extensions = String.FromCString(Byte Ptr(glGetString(GL_EXTENSIONS)))
		THardwareInfo.Extensions = Extensions

		' Check for Extensions
		THardwareInfo.VBOSupport = Extensions.Find("GL_ARB_vertex_buffer_object") > -1
		THardwareInfo.GLTCSupport = Extensions.Find("GL_ARB_texture_compression")
		THardwareInfo.S3TCSupport = Extensions.Find("GL_EXT_texture_compression_s3tc") > -1
		THardwareInfo.AnIsoSupport = Extensions.Find("GL_EXT_texture_filter_anisotropic")
		THardwareInfo.MultiTexSupport = Extensions.Find("GL_ARB_multitexture") > -1
		THardwareInfo.TexBlendSupport = Extensions.Find("GL_EXT_texture_env_combine") > -1
		If Not THardwareInfo.TexBlendSupport 'SMALLFIXES use the ARB version that works the same
			THardwareInfo.TexBlendSupport = Extensions.Find("GL_ARB_texture_env_combine") > -1
		EndIf
		THardwareInfo.CubemapSupport = Extensions.Find("GL_ARB_texture_cube_map") > -1
		THardwareInfo.DepthmapSupport = Extensions.Find("GL_ARB_depth_texture") > -1
		THardwareInfo.VPSupport = Extensions.Find("GL_ARB_vertex_program") > -1
		THardwareInfo.FPSupport = Extensions.Find("GL_ARB_fragment_program") > -1
		THardwareInfo.ShaderSupport = Extensions.Find("GL_ARB_shader_objects") > -1
		THardwareInfo.VSSupport = Extensions.Find("GL_ARB_vertex_shader") > -1
		THardwareInfo.FSSupport = Extensions.Find("GL_ARB_fragment_shader") > -1
		THardwareInfo.SLSupport = Extensions.Find("GL_ARB_shading_language_100") > - 1
		
		If THardwareInfo.VSSupport = False Or THardwareInfo.FSSupport = False
			THardwareInfo.ShaderSupport = False
		EndIf

		' Get some numerics
		glGetIntegerv(GL_MAX_TEXTURE_UNITS, Varptr(THardwareInfo.MaxTextures))
		glGetIntegerv(GL_MAX_TEXTURE_SIZE, Varptr(THardwareInfo.MaxTexSize))
		glGetIntegerv(GL_MAX_LIGHTS, Varptr(THardwareInfo.MaxLights))
		
	End Function

	Function DisplayInfo(LogFile:Int=False)
	
		Local position:Int, Space:Int, stream:TStream

		If LogFile
		
			stream = WriteStream("HardwareInfo.txt") 
			stream.WriteLine("Hardwareinfo:")
			stream.WriteLine("")

			' Display Desktopinfo
			stream.WriteLine("Width:  "+ScreenWidth)
			stream.WriteLine("Height: "+ScreenHeight)
			stream.WriteLine("Depth:  "+ScreenDepth)
			stream.WriteLine("Hertz:  "+ScreenHertz)
			stream.WriteLine("")
			
			' Display Driverinfo
			stream.WriteLine("Vendor:         "+Vendor)
			stream.WriteLine("Renderer:       "+Renderer)
			stream.WriteLine("OpenGL-Version: "+OGLVersion)
			stream.WriteLine("")

			' Display Hardwareranges
			stream.WriteLine("Max Texture Units: "+MaxTextures)
			stream.WriteLine("Max Texture Size:  "+MaxTexSize)
			stream.WriteLine("Max Lights:        "+MaxLights)
			stream.WriteLine("")

			' Display OpenGL-Extensions
			stream.WriteLine("OpenGL Extensions:")
			While position < Extensions.length
				Space = Extensions.Find(" ", position)
				If Space = -1 Then Exit
				stream.WriteLine(Extensions[position..Space])
				position = Space+1
			Wend

			stream.WriteLine("")
			stream.WriteLine("- Ready -")
			stream.Close()
			
		Else
		
			Print("Hardwareinfo:")
			Print("")
			
			' Display Desktopinfo
			Print("Width:  "+ScreenWidth)
			Print("Height: "+ScreenHeight)
			Print("Depth:  "+ScreenDepth)
			Print("Hertz:  "+ScreenHertz)
			Print("")
			
			' Display Driverinfo
			Print("Vendor:         "+Vendor)
			Print("Renderer:       "+Renderer)
			Print("OpenGL-Version: "+OGLVersion)
			Print("")

			' Display Hardwareranges
			Print("Max Texture Units: "+MaxTextures)
			Print("Max Texture Size:  "+MaxTexSize)
			Print("Max Lights:        "+MaxLights)
			Print("")

			' Display OpenGL-Extensions
			Print("OpenGL Extensions:")
			While position < Extensions.length
				Space = Extensions.Find(" ", position)
				If Space = -1 Then Exit
				Print(Extensions[position..Space])
				position = Space+1
			Wend

			Print("")
			Print("- Ready -")
			
		EndIf
		
	End Function
	
End Type

Type TLight Extends TEntity

	Method NewLight:TLight( inst:Byte Ptr )
	
		Local light:TLight=New TLight
		entity_map.Insert( inst, light )
		light.instance=inst
		Return light
		
	End Method
	
End Type

Type TMaterial Extends TTexture

	Method NewMaterial:TMaterial( inst:Byte Ptr )
	
		Local mat:TMaterial=New TMaterial
		tex_map.Insert( inst, mat )
		mat.instance=inst
		Return mat
		
	End Method
	
End Type

Type TMesh Extends TEntity

	Method NewMesh:TMesh( inst:Byte Ptr )
	
		Local mesh:TMesh=New TMesh
		entity_map.Insert( inst, mesh )
		mesh.instance=inst
		Return mesh
		
	End Method
	
End Type

Type TOcTree Extends TTerrain

	Method NewOcTree:TOcTree( inst:Byte Ptr )
	
		Local octree:TOcTree=New TOcTree
		entity_map.Insert( inst, octree )
		octree.instance=inst
		Return octree
		
	End Method
	
End Type

Type TPivot Extends TEntity

	Method NewPivot:TPivot( inst:Byte Ptr )
	
		Local piv:TPivot=New TPivot
		entity_map.Insert( inst, piv )
		piv.instance=inst
		Return piv
		
	End Method
	
End Type

Type TShader

	Field instance:Byte Ptr
	
	Method NewShader:TShader( inst:Byte Ptr )
	
		Local material:TShader=New TShader
		material.instance=inst
		Return material
		
	End Method

End Type

Type TShadowObject

	Global shad_map:TPtrMap=New TPtrMap

	Field instance:Byte Ptr
	
	Method NewShadowObject:TShadowObject( inst:Byte Ptr )
	
		Local shad:TShadowObject=New TShadowObject
		shad_map.Insert( inst, shad )
		shad.instance=inst
		Return shad
		
	End Method
	
	Method DeleteShadowObject( inst:Byte Ptr )
	
		shad_map.Remove( inst )
	
	End Method
	
End Type

Type TSprite Extends TMesh

	Method NewSprite:TSprite( inst:Byte Ptr )
	
		Local sprite:TSprite=New TSprite
		entity_map.Insert( inst, sprite )
		sprite.instance=inst
		Return sprite
		
	End Method
	
End Type

Type TStencil

	Field instance:Byte Ptr
	
	Method NewStencil:TStencil( inst:Byte Ptr )
	
		Local stencil:TStencil=New TStencil
		stencil.instance=inst
		Return stencil
		
	End Method
	
End Type

Rem
bbdoc: Surface
End Rem
Type TSurface

	Global surf_map:TPtrMap=New TPtrMap
	
	Field instance:Byte Ptr
	
	Method NewSurface:TSurface( inst:Byte Ptr )
	
		Local surf:TSurface=New TSurface
		surf_map.Insert( inst, surf )
		surf.instance=inst
		Return surf
		
	End Method
	
	Method SurfaceValue:TSurface( inst:Byte Ptr )
	
		Return TSurface( surf_map.ValueForKey( inst ) )
	
	End Method
	
End Type

Rem
bbdoc: Terrain entity
End Rem
Type TTerrain Extends TEntity

	Method NewTerrain:TTerrain( inst:Byte Ptr )
	
		Local terr:TTerrain=New TTerrain
		entity_map.Insert( inst, terr )
		terr.instance=inst
		Return terr
		
	End Method
	
End Type

Rem
bbdoc: Texture
End Rem
Type TTexture

	Global tex_map:TPtrMap=New TPtrMap

	Field instance:Byte Ptr
	
	Method NewTexture:TTexture( inst:Byte Ptr )
	
		Local tex:TTexture=New TTexture
		tex_map.Insert( inst, tex )
		tex.instance=inst
		Return tex
		
	End Method
	
	Method DeleteTexture( inst:Byte Ptr )
	
		tex_map.Remove( inst )
	
	End Method
	
	Method TextureValue:TTexture( inst:Byte Ptr )
	
		Return TTexture( tex_map.ValueForKey( inst ) )
	
	End Method
	
End Type

Type TVoxelSprite Extends TMesh

	Method NewVoxelSprite:TVoxelSprite( inst:Byte Ptr )
	
		Local voxelspr:TVoxelSprite=New TVoxelSprite
		entity_map.Insert( inst, voxelspr )
		voxelspr.instance=inst
		Return voxelspr
		
	End Method
		
End Type


' Wrapped functions
' -----------------

Include "functions.bmx"



Type TOpenB3DMeshLoader Extends TMeshLoader
	
	Method CanLoadMesh:Int(extension:String)
		Select extension.ToLower()
			Case "b3d"
				Return True
		End Select
	End Method

	Method LoadMesh:Object(obj:Object, parent:Object = Null)
		Local instance:Byte Ptr = LoadMesh_(String(obj), TEntity.EntityExists( TEntity(parent) ) )
		Return globals.mesh.NewMesh( instance )
	End Method

	Method LoadAnimMesh:Object(obj:Object, parent:Object = Null)
		Local instance:Byte Ptr = LoadAnimMesh_(String(obj), TEntity.EntityExists(TEntity(parent) ) )
		Return globals.mesh.NewMesh( instance )
	End Method
	
End Type

New TOpenB3DMeshLoader
