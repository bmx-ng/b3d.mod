' types.bmx

' Mesh bounds values, used in FitAnimMesh()
Type aiMinMax3D

	Field maxx#,maxy#,maxz#
	Field minx#,miny#,minz#
	
End Type

Rem
 Contains functions which apply to all children of an entity:
 CountTrianglesAll:Int( mesh:TMesh )
 RotateEntityAxisAll ent:TEntity, axis:Int
 UpdateNormalsAll ent:TEntity
 FlipMeshAll ent:TEntity
 ScaleMeshAxisAll ent:TEntity, axis:Int
EndRem
Type aiLoader

	Global meshflags:Int=0
	
	Function LoadMesh:TMesh( filename:String )
	
		Local scene:aiScene = New aiScene
		
		'aiSetImportPropertyInteger(aipropertystore?, AI_CONFIG_PP_SBP_REMOVE, aiPrimitiveType_LINE | aiPrimitiveType_POINT )
		
		Local flags:Int
		If meshflags=0
			flags = ..
			aiProcess_Triangulate | ..
			aiProcess_GenSmoothNormals | ..
			aiProcess_SortByPType | ..
			aiProcess_PreTransformVertices | ..
			aiProcess_FlipUVs | ..
			aiProcess_JoinIdenticalVertices
		ElseIf meshflags=1
			flags = ..
			aiProcess_Triangulate | ..
			aiProcess_GenNormals | ..
			aiProcess_SortByPType | ..
			aiProcess_CalcTangentSpace | ..
			aiProcess_FindDegenerates | ..
			aiProcess_FindInvalidData | ..
			aiProcess_GenUVCoords | ..
			aiProcess_TransformUVCoords | ..
			aiProcess_FlipUVs | ..
			aiProcess_PreTransformVertices
		EndIf
	'	aiProcess_SplitLargeMeshes | ..
	'	aiProcess_ValidateDataStructure | ..
	'	aiProcess_ImproveCacheLocality | ..
	'	aiProcess_RemoveRedundantMaterials | ..	
	'	aiProcess_ConvertToLeftHanded | ..	
		
		If scene.ImportFile(filename, flags)
		
			' Make brushes
			
			Local brushes:TBrush[scene.NumMaterials]
			Local i:Int
			
			For Local mat:aiMaterial = EachIn scene.Materials
'Rem
				DebugLog " "
				DebugLog " ----    Material Name " + mat.GetMaterialName()
				DebugLog " ----    mat.IsTwoSided() " + mat.IsTwoSided()
				DebugLog " ----    mat.GetShininess() " + mat.GetShininess()
				DebugLog " ----    mat.GetAlpha() " + mat.GetAlpha()
'EndRem
'Rem
				Local names:String[] = mat.GetPropertyNames()
				
				For Local s:String = EachIn names
					DebugLog "Property: *" + s + "*"
					
					'DebugLog "matbase " + mat.GetFloatValue(s)
					
					Select s
						Case AI_MATKEY_TEXTURE_BASE
							DebugLog "matbase " +  mat.GetMaterialString(s)
					End Select
					
				Next
'EndRem
				Local DiffuseColors:Float[] = mat.GetMaterialColor(AI_MATKEY_COLOR_DIFFUSE)	
				
				brushes[i] = CreateBrush(mat.GetDiffuseRed()*255,mat.GetDiffuseGreen()*255,mat.GetDiffuseBlue()*255)
				
				' seems alpha comes in different places denpending om model format.
				' seems wavefront obj alpha doen't load
				'BrushAlpha brushes[i],mat.GetAlpha()' * mat.GetDiffuseAlpha() (might be 0 so not good)
				
				BrushShininess brushes[i],mat.GetShininess()
				
				If mat.IsTwoSided()
					'BrushFX brushes[i] ,16
				EndIf
				
				Local texFilename:String = mat.GetMaterialTexture()
				
				DebugLog "TEXTURE filename: " + texFilename
				
				If Len(texFilename)
				
					' remove currentdir prefix, but leave relative subfolder path intact
					If  texFilename[..2] = ".\" Or texFilename[..2] = "./"
						texFilename = texFilename [2..]
					EndIf
					
					'assume the texture names are stored relative to the file
					texFilename  = ExtractDir(filename) + "/" + texFilename
					
					If Not FileType(texFilename  )
						texFilename   = ExtractDir(filename) + "/" + StripDir(texFilename)
					EndIf
					
					DebugLog texFilename
					
					If FileType(texFilename  )
						'DebugStop
						Local tex:TTexture=LoadTexture(texFilename)
						
						If tex
							BrushTexture brushes[i],tex	
						EndIf
						
					EndIf
					
				EndIf
				
				i:+1
			Next
			
			' Make mesh - was ProccessAiNodeAndChildren()
			
			Local mesh:TMesh = CreateMesh()
			
			DebugLog "scene.numMeshes:  "  + scene.numMeshes
			
			For Local m:aiMesh = EachIn scene.meshes
			
				Local surf:TSurface = CreateSurface(mesh,brushes[m.MaterialIndex])
				
				' vertices, normals and texturecoords - was MakeAiMesh()
				
				For i = 0 To m.NumVertices - 1
				
					'DebugLog  m.VertexX(i) + " , "  + m.VertexY(i) + " , "  + m.VertexZ(i)
					
					Local index:Int
					index = AddVertex(surf,m.VertexX(i) ,m.VertexY(i),m.VertexZ(i))
					
					If m.HasNormals()
						VertexNormal(surf,index,m.VertexNX(i) ,m.VertexNY(i),m.VertexNZ(i))
					EndIf
					
					If m.HasTextureCoords(0)
						VertexTexCoords(surf,index,m.VertexU(i) ,m.VertexV(i),m.VertexW(i))
					EndIf
					
					If m.HasTextureCoords(1)
						VertexTexCoords(surf,index,m.VertexU(i,1) ,m.VertexV(i,1),m.VertexW(i,1))
					EndIf
					
				Next
				
				For i = 0 To m.NumFaces - 1
				
					'DebugLog  m.TriangleVertex(i,0) + " , "  + m.TriangleVertex(i,1) + " , "  + m.TriangleVertex(i,2)
					
					' this check is only in because assimp seems to be returning out of range indexes
					' on rare occasions with aiProcess_PreTransformVertices on.
					Local validIndex:Int = True
					
					' added 3.1.1: fix for MAV when garbage index values < zero
					If m.TriangleVertex(i,0) < 0 Then validIndex = False
					If m.TriangleVertex(i,1) < 0 Then validIndex = False
					If m.TriangleVertex(i,2) < 0 Then validIndex = False
					
					If m.TriangleVertex(i,0) >=m.NumVertices Then validIndex = False
					If m.TriangleVertex(i,1) >=m.NumVertices Then validIndex = False
					If m.TriangleVertex(i,2) >=m.NumVertices Then validIndex = False				
					
					If validIndex
						AddTriangle(surf, m.TriangleVertex(i,0) ,  m.TriangleVertex(i,1) , m.TriangleVertex(i,2))
					Else
						DebugLog "TriangleVertex index was out of range for triangle nr. : " + i
						DebugLog "indexes: " + m.TriangleVertex(i,0) + " , "  + m.TriangleVertex(i,1) + " , "  + m.TriangleVertex(i,2)
					EndIf
					
				Next
				
			Next
			
			Return mesh	
			
		Else
		
			DebugLog "nothing imported"
			
		EndIf
		
		Scene.ReleaseImport()
		
	End Function
		
End Type

' helper functions
Type aiHelper

	Global mm:aiMinMax3D=New aiMinMax3D
	
	' Non-essential helper functions
	
	Function CountTrianglesAll:Int( ent:TEntity )
	
		If ent = Null Then Return 0
		Local all%
		
		For Local id% = 1 To CountSurfaces(TMesh(ent))
			Local surf:TSurface=GetSurface( TMesh(ent),id )
			Local nt% = CountTriangles(surf)
			all:+nt
		Next
		
		Return all
		
	End Function
	
	' renamed from FlipRot (applied to all children of an entity)
	Function RotateEntityAxisAll( ent:TEntity, axis:Int )
	
		If ent = Null Then Return
		Local cc:Int = CountChildren(ent)
		
		If cc
			For Local id:Int = 1 To cc
				RotateEntityAxisAll( GetChild(ent,id),axis )
			Next	
		EndIf
		
		Local rotX:Float = EntityPitch(ent)
		Local rotY:Float = EntityYaw(ent)
		Local rotZ:Float = EntityRoll(ent)
		
		Select axis
			Case 1
				rotX = -rotX
			Case 2
				rotY = -rotY		
			Case 3
				rotZ = -rotZ
		End Select
		
		RotateEntity( ent,rotX,rotY,rotZ )
		
	End Function
	
	' dirty x model fixer - renamed from UpdateEntityNormals (applied to all children of an entity)
	Function UpdateNormalsAll( ent:TEntity )
	
		If ent = Null Then Return
		Local childcount:Int = CountChildren(ent)
		
		If childcount
			For Local id:Int = 1 To childcount
				UpdateNormalsAll( GetChild(ent,id) )
			Next
		EndIf
		
		If EntityClass(ent) = "Mesh"
			UpdateNormals( TMesh(ent) )
		EndIf
		
	End Function
	
	' renamed from FlipEntity (applied to all children of an entity)
	Function FlipMeshAll( ent:TEntity )
	
		If ent = Null Then Return
		Local childcount:Int = CountChildren(ent)
		
		If childcount
			For Local id:Int = 1 To childcount
				FlipMeshAll( GetChild(ent,id) )
			Next
		EndIf
		
		If EntityClass(ent) = "Mesh"
			FlipMesh( TMesh(ent) )
		EndIf
		
	End Function
	
	' dirty x model fixer - renamed from ScaleFlipEntity (applied to all children of an entity)
	Function ScaleMeshAxisAll( ent:TEntity, axis:Int )
	
		If ent = Null Then Return
		Local childcount:Int = CountChildren(ent)
		
		If childcount
			For Local id:Int = 1 To childcount
				ScaleMeshAxisAll( GetChild(ent,id),axis )
			Next
		EndIf
		
		Local scaleX:Float = 1
		Local scaleY:Float = 1
		Local scaleZ:Float = 1
		
		Select axis
			Case 1
				scaleX = -scaleX
			Case 2
				scaleY = -scaleY		
			Case 3
				scaleZ = -scaleZ
		End Select
		
		If EntityClass(ent) = "Mesh"
			ScaleMesh( TMesh(ent),scaleX,scaleY,scaleZ )
		EndIf
		
	End Function
	
	' uses doFitAnimMesh() and getAnimMeshMinMax()
	Function FitAnimMesh( m:TEntity, x#, y#, z#, w#, h#, d#, uniform:Int=False )
	
		Local scalefactor#
		Local xoff#,yoff#,zoff#
		Local gFactor#=100000.0
		
		mm.maxx=-100000
		mm.maxy=-100000
		mm.maxz=-100000
		
		mm.minx=100000
		mm.miny=100000
		mm.minz=100000
		
		getAnimMeshMinMax( m,mm )
		
		'DebugLog "getAnimMeshMinMax " + String(mm.minx).ToInt() + ", " + String(mm.miny).ToInt() + ", " + String(mm.minz).ToInt() + ", " +..
		'String(mm.maxx).ToInt() + ", " + String(mm.Maxy).ToInt() + ", " + String(mm.maxz).ToInt()	
		
		Local xspan#=(mm.maxx-mm.minx)
		Local yspan#=(mm.maxy-mm.miny)
		Local zspan#=(mm.maxz-mm.minz)
		
		Local xscale#=w/xspan
		Local yscale#=h/yspan
		Local zscale#=d/zspan
		
		'DebugLog "Scales: " + xscale + " , " +  yscale + " , " + zscale + " , " 
		
		If uniform
		
			If xscale<yscale
				yscale=xscale
			Else
				xscale=yscale
			EndIf
			
			If zscale<xscale
				xscale=zscale
				yscale=zscale			
			Else
				zscale=xscale
			EndIf
			
		EndIf	
		
		'DebugLog "Scales: " + String(xscale).ToInt() + " , " +  String(yscale).ToInt() + " , " + String(zscale).ToInt() + " , " 
		
		xoff# = -mm.minx * xscale-(xspan/2.0) * xscale+x+w/2.0
		yoff# = -mm.miny * yscale-(yspan/2.0) * yscale+y+h/2.0
		zoff# = -mm.minz * zscale-(zspan/2.0) * zscale+z+d/2.0
		
		doFitAnimMesh( m,xoff,yoff,zoff,xscale,yscale,zscale )	
'		Delete mm
		
	End Function
	
	' internal functions for FitAnimMesh
	
	' used in FitAnimMesh()
	Function doFitAnimMesh( m:TEntity, xoff#, yoff#, zoff#, xscale#, yscale#, zscale# )
	
		Local c:Int
		Local childcount:Int=CountChildren(m)
		
		If childcount
		
			For c=1 To childcount
				'myFitEntity( m,xoff#,yoff#,zoff#,xscale#,yscale#,zscale# )
				doFitAnimMesh( GetChild(m,c),xoff#,yoff#,zoff#,xscale#,yscale#,zscale# )
			Next
			
		'Else
		EndIf
		
		myFitEntity( m,xoff#,yoff#,zoff#,xscale#,yscale#,zscale# )
		
	End Function
	
Rem
	Function doFitAnimMeshOLD( m:TEntity, xoff#, yoff#, zoff#, xscale#, yscale#, zscale# )
	
		Local c:Int
		Local childcount:Int=CountChildren(m)
		
		If childcount
		
			For c=1 To childcount
				myFitEntity( m,xoff#,yoff#,zoff#,xscale#,yscale#,zscale# )
				doFitAnimMesh( GetChild(m,c),xoff#,yoff#,zoff#,xscale#,yscale#,zscale# )
			Next
			
		Else
		
			myFitEntity( m,xoff#,yoff#,zoff#,xscale#,yscale#,zscale# )
		
		EndIf
		
	End Function
EndRem
	
	' used in doFitAnimMesh()
	Function myFitEntity( e:TEntity, xoff#, yoff#, zoff#, xscale#, yscale#, zscale# )
	
		Local x#,y#,z#
		Local x2#,y2#,z2#
		Local txoff#,tyoff#,tzoff#
		
		TFormPoint( 0,0,0,e,Null )
		
		x2=TFormedX()
		y2=TFormedY()
		z2=TFormedZ()
		
		TFormPoint( x2+xoff,y2+yoff,z2+zoff,Null,e )
		
		txoff=TFormedX() 
		tyoff=TFormedY()
		tzoff=TFormedZ()
		
		Local m:TMesh = TMesh(e)
		
		If m 'only if it's a mesh
		
			For Local sc:Int=1 To CountSurfaces(m)
				Local s:TSurface=GetSurface(m,sc)	
				
				For Local vc:Int=0 To CountVertices(s)-1
					x=VertexX(s,vc)
					y=VertexY(s,vc)
					z=VertexZ(s,vc)
					
					VertexCoords s,vc,x*xscale+txoff,y*yscale+tyoff,z*zscale+tzoff
				Next
				
			Next
			
		EndIf
		
		PositionEntity( e,EntityX(e)*xscale,EntityY(e)*yscale,EntityZ(e)*zscale )
		
	End Function
	
	' used in FitAnimMesh()
	Function getAnimMeshMinMax#( m:TEntity, mm:aiMinMax3D )
	
		Local c:Int
		Local wfac#,hfac#,dfac#
		'Local tfactor
		Local cc:Int=CountChildren(m)
		
		If EntityClass(m) = "Mesh"
		
			'If m.class = "Mesh" 
			mm = getEntityMinMax( TMesh(m),mm )
			'Else
			'	DebugLog "Class -- " + m.class
			'Endif
			
		EndIf
		
		If cc
			For c=1 To cc
				getAnimMeshMinMax( GetChild(m,c),mm )
			Next
	'	Else
		EndIf
		
	End Function

	' used in getAnimMeshMinMax()
	Function getEntityMinMax:aiMinMax3D( m:TMesh, mm:aiMinMax3D )
	
		Local x#,y#,z#
		Local sc:Int
		Local vc:Int
		Local s:TSurface	
		
		For sc=1 To CountSurfaces(m)
			s=GetSurface(m,sc)	
			
			For vc=0 To CountVertices(s)-1
				TFormPoint(VertexX(s,vc),VertexY(s,vc),VertexZ(s,vc),m,Null)
				
				x=TFormedX()
				y=TFormedY()
				z=TFormedZ()
				
				If x<mm.minx Then mm.minx=x
				If y<mm.miny Then mm.miny=y
				If z<mm.minz Then mm.minz=z				
				
				If x>mm.maxx Then mm.maxx=x
				If y>mm.maxy Then mm.maxy=y
				If z>mm.maxz Then mm.maxz=z
			Next
			
		Next
		
		Return mm
		
	End Function
	
	' Creates a list of valid files to load
	Function EnumFiles( list:TList, dir:String, skipExt:TList )
	
		Local folder:Byte Ptr=ReadDir(dir)
		Local file:String
		
		Repeat
			file=NextFile(folder)
			
			If (file <> ".") And (file <> "..") And (file)
			
				Local fullPath:String=RealPath(dir+"/"+file)
				
				If FileType(fullPath)=FILETYPE_DIR
				
					'DebugLog file
					'If(dir[0]) <> "."
						EnumFiles( list,fullPath,skipExt )
					'EndIf
					
				Else
				
					DebugLog "fullpath: " + fullPath
					
					If aiIsExtensionSupported( Lower(ExtractExt(fullPath)) )
					
						'DebugStop
						If Not skipExt.Contains( Lower(ExtractExt(fullPath)) ) ' Filter out nff for now
							' assimp author is looking into a fix
							list.AddLast(fullPath)
						EndIf
						
					EndIf
					
				EndIf
				
			EndIf
			
		Until file=Null
		CloseDir folder
		
	End Function
	
End Type
