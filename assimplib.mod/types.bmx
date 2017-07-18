' types.bmx

Type aiMatrix3x3

	Field a1:Float , a2:Float , a3:Float
	Field b1:Float , b2:Float , b3:Float
	Field c1:Float , c2:Float , c3:Float
	
End Type

Type aiMatrix4x4

	Field a1:Float , a2:Float , a3:Float , a4:Float
	Field b1:Float , b2:Float , b3:Float , b4:Float
	Field c1:Float , c2:Float , c3:Float , c4:Float
	Field d1:Float , d2:Float , d3:Float , d4:Float
	
	Field heading:Float
	Field attitude:Float
	Field bank:Float
	
	Field Tx:Float
	Field Ty:Float
	Field Tz:Float
	Field Sx:Float
	Field Sy:Float
	Field Sz:Float	
	Field Rx:Float
	Field Ry:Float
	Field Rz:Float
	
	Function Create:aiMatrix4x4(p:Float Ptr)
	
		Local m:aiMatrix4x4 = New aiMatrix4x4
		
		Rem	
			DebugLog "Matrix"
			For Local i:Int = 0 To 15
				DebugLog i + " " + p[i]
			Next		
		EndRem
		
		m.a1 = p[0]
		m.a2 = p[1]
		m.a3 = p[2]
		m.a4 = p[3]
		
		m.b1 = p[4]
		m.b2 = p[5]
		m.b3 = p[6]
		m.b4 = p[7]

		m.c1 = p[8]
		m.c2 = p[9]
		m.c3 = p[10]
		m.c4 = p[11]

		m.d1 = p[12]
		m.d2 = p[13]
		m.d3 = p[14]
		m.d4 = p[15]
		
		Return m									
		
	End Function
	
	Method Decompose()
	
		_Decompose()		
		
		rx = heading
		ry = attitude
		rz = bank
		
	End Method
	
	Method _Decompose()
	
		Tx = a4
		Ty = b4 
		Tz = c4
		
		Sx = Sqr( a1*a1 + a2*a2 + a3*a3 )
		Sy = Sqr( b1*b1 + b2*b2 + b3*b3 ) 
		Sz = Sqr( c1*c1 + c2*c2 + c3*c3 )
		
		Local D:Float = a1 * (b2 * c3 - c2 * b3) - b1 * (a2 * c3 - c2 * a3) + c1 * (a2 * b3 - b2 * a3);
		
		Sx:* Sgn( D )
		Sy:* Sgn( D )
		Sz:* Sgn( D )
		
		Local rm:aiMatrix3x3 = New aiMatrix3x3	
		
		rm.a1 = a1 ; rm.a2 = a2 ; rm.a3 = a3
		rm.b1 = b1 ; rm.b2 = b2 ; rm.b3 = b3
		rm.c1 = c1 ; rm.c2 = c2 ; rm.c3 = c3		
		
		If sx Then
			rm.a1:/sx	
			rm.a2:/sx	
			rm.a3:/sx	
		EndIf
		If sy Then
			rm.b1:/sy
			rm.b2:/sy	
			rm.b3:/sy	
		EndIf
		If sz Then
			rm.c1:/sz
			rm.c2:/sz	
			rm.c3:/sz	
		EndIf
		
		If (b1 > 0.998) ' singularity at north pole
			heading = ATan2(rm.a3,rm.c3)
			attitude = 90 'Pi/2
			bank = 0
			'DebugLog "' singularity at north pole **"
			Return
		EndIf
		
		If (b1 < -0.998) ' singularity at south pole
			heading = ATan2(rm.a3,rm.c3)
			attitude = - 90 '-Pi/2
			bank = 0
			'DebugLog "' singularity at south pole **"
			Return
		EndIf
		
		heading = ATan2(-rm.c1,rm.a1)
		bank = ATan2(-rm.b3,rm.b2)
		attitude = ASin(rm.b1)	
		
	End Method

	Method GetScaleX:Float()
	
		Return Sqr(a1*a1 + a2*a2 + a3*a3)
		
	End Method
	
	Method GetScaleY:Float()
	
		Return Sqr(b1*b1 + b2*b2 + b3*b3)

	End Method
	
	Method GetScaleZ:Float()
	
		Return Sqr(c1*c1 + c2*c2 + c3*c3)
		
	End Method
	
End Type

Type aiMaterial

	Field pMaterial:Int Ptr
	Field Properties:aiMaterialProperty[]
	Field NumProperties:Int
	Field NumAllocated:Int
	
	' helper functions based on Assimp api 
	
	Method GetMaterialName:String()
	
		Return GetMaterialString(AI_MATKEY_NAME)
		
	End Method	
	
	Method IsTwoSided:Int()
	
		Local values:Int[] = GetMaterialIntegerArray(AI_MATKEY_TWOSIDED)
		If values.length Then Return values[0]
		
	End Method
	
	Method GetAlpha:Float()
	
		Local values:Float[] = GetMaterialFloatArray(AI_MATKEY_OPACITY)
		If values.length Then
			Return values[0]	
		Else		
			Return 1.0
		EndIf
		
	End Method
	
	Method GetShininess:Float()
	
		Local values:Float[] = GetMaterialFloatArray(AI_MATKEY_SHININESS)
		If values.length Then
			Return values[0]	
		Else		
			Return 1.0
		EndIf
		
	End Method
	
	' diffuse
	Method GetDiffuseRed:Float()
	
		Local Colors:Float[] = GetMaterialColor(AI_MATKEY_COLOR_DIFFUSE)
		If Colors.length Then Return Colors[0]
		
	End Method
	
	Method GetDiffuseGreen:Float()
	
		Local Colors:Float[] = GetMaterialColor(AI_MATKEY_COLOR_DIFFUSE)
		If Colors.length Then Return Colors[1]
		
	End Method
	
	Method GetDiffuseBlue:Float()
	
		Local Colors:Float[] = GetMaterialColor(AI_MATKEY_COLOR_DIFFUSE)
		If Colors.length Then Return Colors[2]
		
	End Method
	
	Method GetDiffuseAlpha:Float()
	
		Local Colors:Float[] = GetMaterialColor(AI_MATKEY_COLOR_DIFFUSE)
		If Colors.length Then Return Colors[3]
		
	End Method		
	
	' helper functions assumes material properties loaded with scene 
	
	Method GetTexture()
	
	End Method
	
	Method GetPropertyNames:String[]()
	
		Local names:String[NumProperties]	
		For Local i:Int = 0 To NumProperties - 1
		
			names[i] = Properties[i].mKey
			'DebugLog "Property name: " + Properties[i].mKey
			'DebugLog "Property type: " + Properties[i].mType
			'DebugLog "Property Index " + Properties[i].Index
			'DebugLog "Property length " + Properties[i].DataLength
			'DebugLog "Property Semantic: " + Properties[i].Semantic
			
			Select Properties[i].mType
				Case aiPTI_Float
					For Local i:Int = 0 Until Properties[i].DataLength / 4 
				'		DebugLog "FLOAT: " + Properties[i].GetFloatValue(i)
					Next
				Case aiPTI_String
			'		DebugLog "String: " + Properties[i].GetStringValue()
				Case aiPTI_Integer
				
				Case aiPTI_Buffer
				
			End Select
			
		Next
		Return names
		
	End Method	
	
	' native ai functions 
	
	Method GetMaterialString:String(Key:String)
	
		Local s:Byte[4+MAXLEN]
		'Local kp:Byte Ptr = Key.ToCstring()
		
		Local retVal:Int = aiGetMaterialString(pMaterial,Key,0,0,Varptr s[0])
		'MemFree kp
		
		If retVal = AI_SUCCESS
			Return String.FromCString(Varptr s[4])
		'Else
			'DebugLog "mat. aiGetMaterialString failed with code " + retVal
		EndIf
		
	End Method
	
	Method GetMaterialColor:Float[](Key:String)	
	
		Local colors:Float[4]
		If aiGetMaterialColor(pMaterial,Key,0,0,colors)	= AI_SUCCESS
			Return colors
		EndIf
		
	End Method
	
	Method GetMaterialIntegerArray:Int[](Key:String)
		
		Local size:Int = 1024
		Local values:Int[size]
		
		If aiGetMaterialIntegerArray(pMaterial,Key,0,0,values,Varptr size)	= AI_SUCCESS
			values = values[..size]
			Return values
		EndIf
		
	End Method	
	
	Method GetMaterialFloatArray:Float[](Key:String)
	
		Local size:Int = 1024
		Local values:Float[size]
		
		If aiGetMaterialFloatArray(pMaterial,Key,0,0,values,Varptr size)	= AI_SUCCESS
			values = values[..size]
			Return values
		EndIf
		
	End Method	
	
	Method GetMaterialTexture:String(index:Int=0)
	
		Local s:Byte[4+MAXLEN]
		Local retval:Int = aiGetMaterialTexture(pMaterial,aiTextureType_DIFFUSE,index,Varptr s[0])
		
		If retVal = AI_SUCCESS			
			Return String.FromCString(Varptr s[4])
		Else
			DebugLog "mat. GetMaterialTexture failed with code " + retVal
		EndIf	
		
	End Method
	
End Type

' used in aiMaterial
Type aiMaterialProperty

	Field mKey:String
	Field Semantic:Int
	Field Index:Int
	Field DataLength:Int
	Field mType:Int				
	Field mData:Byte Ptr		
	
	Function Create:aiMaterialProperty(pProps:Byte Ptr)
	
		Local mp:aiMaterialProperty = New aiMaterialProperty
		
		mp.mKey = String.FromCString(pProps + 4)
		
		Local pVars:Int Ptr = Int Ptr(pProps + MAXLEN + 4 )
		
		mp.Semantic:Int = pVars[0]
		mp.Index = pVars[1]
		mp.DataLength = pVars[2]
		mp.mType = pVars[3]
		mp.mData = Byte Ptr pVars[4]
		
		Return mp
		
	End Function
	
	Method GetFloatValue:Float(index:Int)
	
		Return Float Ptr (mData)[index]
		
	End Method
	
	Method GetStringValue:String()
	
		Return String.FromCString(mData + 4 )
		
	End Method
	
	Method GetIntegerValue:Int (index:Int)
	
		Return Int Ptr (mData)[index]
		
	End Method
	
	Method GetByteValue:Byte(index:Int)
	
		Return mData[index]
		
	End Method
	
End Type

Rem
bbdoc: A mesh represents a geometry Or model with a single material.
	about:

* It usually consists of a number of vertices And a series of primitives/faces 
* referencing the vertices. In addition there might be a series of bones, each 
* of them addressing a number of vertices with a certain weight. Vertex data 
* is presented in channels with each channel containing a single per-vertex 
* information such as a set of texture coords Or a normal vector.
* If a data pointer is non-Null, the corresponding data stream is present.
* From C++-programs you can also use the comfort functions Has*() To
* test For the presence of various data streams.
*
* A Mesh uses only a single material which is referenced by a material ID.
* @note The mPositions member is usually Not optional. However, vertex positions 
* *could* be missing If the AI_SCENE_FLAGS_INCOMPLETE flag is set in 
* @code
* aiScene::mFlags
* @endcode
*/
EndRem
Type aiMesh

	Field PrimitiveTypes:Int
	Field NumVertices:Int
	Field NumFaces:Int
	Field pVertices:Float Ptr
	Field pNormals:Float Ptr
	Field pTangents:Byte Ptr
	Field pBitangents:Byte Ptr
	Field pColors:Byte Ptr[AI_MAX_NUMBER_OF_COLOR_SETS]
	Field pTextureCoords:Byte Ptr[AI_MAX_NUMBER_OF_TEXTURECOORDS]
	Field NumUVComponents:Int[AI_MAX_NUMBER_OF_TEXTURECOORDS]
	Field pFaces:Int Ptr
	Field NumBones:Int
	Field pBones:Byte Ptr
	Field MaterialIndex:Int
	
	' vertices
	
	Method VertexX:Float(index:Int)
	
		Return pVertices[index*3]
		
	End Method
	
	Method VertexY:Float(index:Int)
	
		Return pVertices[index*3+1]
		
	End Method
	
	Method VertexZ:Float(index:Int)
	
		Return pVertices[index*3+2]
		
	End Method
	
	' normals
	
	Method VertexNX:Float(index:Int)
	
		Return pNormals[index*3]
		
	End Method
	
	Method VertexNY:Float(index:Int)
	
		Return pNormals[index*3+1]
		
	End Method
	
	Method VertexNZ:Float(index:Int)
	
		Return pNormals[index*3+2]
		
	End Method
	
	' texcoords - funky :-)
	
	Method VertexU:Float(index:Int,coord_set:Int=0)
	
		Return Float Ptr(pTextureCoords[coord_set])[index*3]
		
	End Method

	Method VertexV:Float(index:Int,coord_set:Int=0)
	
		Return Float Ptr(pTextureCoords[coord_set])[index*3 + 1]
		
	End Method

	Method VertexW:Float(index:Int,coord_set:Int=0)
	
		Return Float Ptr(pTextureCoords[coord_set])[index*3 + 2 ]
		
	End Method
	
	Method VertexRed:Float(index:Int,color_set:Int=0)
	
		Return Float Ptr(pColors[color_set])[index*4]
		
	End Method
	
	Method VertexGreen:Float(index:Int,color_set:Int=0)
	
		Return Float Ptr(pColors[color_set])[index*4 + 1]
		
	End Method
	
	Method VertexBlue:Float(index:Int,color_set:Int=0)
	
		Return Float Ptr(pColors[color_set])[index*4 + 2]
		
	End Method
	
	Method VertexAlpha:Float(index:Int,color_set:Int=0)
	
		Return Float Ptr(pColors[color_set])[index*4 + 3]
		
	End Method		
	
	Method HasPositions:Int()
	
		If NumVertices <= 0 Then Return False
		If pVertices <> Null Then Return True
		
	End Method
	
	Method HasFaces:Int()
	
		If NumVertices <= 0 Then Return False
		If pFaces <> Null Then Return True
		
	End Method	
	
	Method HasNormals:Int()
	
		If NumVertices <= 0 Then Return False
		If pNormals <> Null Then Return True
		
	End Method	
	
	Method HasTangentsAndBitangents:Int() 
	
		If NumVertices <= 0 Then Return False	
		If pTangents = Null Then Return False
		If pBitangents <> Null Then Return True
		
	End Method
	
	Method HasTextureCoords:Int(coord_set:Int)
	
		If coord_set >= AI_MAX_NUMBER_OF_TEXTURECOORDS Then Return False
		If pTextureCoords[coord_set] <> Null Then Return True
		
	End Method
	
	Method HasVertexColors:Int( color_set:Int)
	
		If NumVertices <= 0 Then Return False
		If color_set >= AI_MAX_NUMBER_OF_COLOR_SETS Then Return False
		If pColors[color_set] <> Null Then Return True
		
	End Method	
	
	Method TriangleVertex:Int(index:Int,corner:Int)
	
		Local faceIndexes:Int Ptr = Int Ptr pFaces[index*2+1]
		Return faceIndexes[corner]
		
	End Method
	
	Method GetTriangularFaces:Int[,]()
	
		Local faces:Int[NumFaces,3]
		Local index:Int
		
		For Local count:Int = 0 To NumFaces - 1
			Local faceCount:Int = pFaces[index]
			Local faceIndexes:Int Ptr = Int Ptr pFaces[index+1]
			
			' TODO for nontriangular faces: faceCount could be other than 3
			For Local n:Int = 0 To 2
				faces[count , n] = faceIndexes[n]
			Next
			
			index:+2
		Next
		
		Return faces
		
	End Method
	
End Type

' used in aiScene
Type aiNode

	Field pointer:Byte Ptr
	Field name:String
	Field transformation:aiMatrix4x4
	Field NumChildren:Int
	Field Children:aiNode[]
	Field NumMeshes:Int
	Field MeshIndexes:Int[]
	Field Parent:aiNode
	
	Function Create:aiNode(pointer:Byte Ptr,parent:aiNode = Null)
	
		Local n:aiNode = New aiNode
		n.Parent = parent
		n.pointer = pointer
		n.name = String.FromCString(pointer + 4)
		
		'DebugLog "Nodename " + n.name

		n.transformation = aiMatrix4x4.Create(Float Ptr (Byte Ptr pointer + MAXLEN + 4))
		
		Local pBase:Int Ptr = Int Ptr(Byte Ptr pointer + MAXLEN + 4 + 16*4)
		
		'Rem
		n.NumMeshes = pBase[3]
		
		'DebugLog "Mesh count for this node: " + n.NumMeshes
		
		Local pMeshIndexArray:Int Ptr = Int Ptr pBase[4]
		
		n.MeshIndexes = n.MeshIndexes[..n.NumMeshes ]
		
		For Local i:Int = 0 To n.NumMeshes - 1
			n.MeshIndexes[i] = pMeshIndexArray[i]
		Next
		'End Rem
		
		' get child nodes
		n.NumChildren = pBase[1]
		
		If n.NumChildren		
			Local pChildArray:Int Ptr = Int Ptr pBase[2]
			
			n.Children = n.Children[..n.NumChildren]
			
			For Local i:Int = 0 To n.NumChildren - 1
				n.Children[i] = aiNode.Create(Byte Ptr pChildArray[i],n)
			Next
		EndIf
		
		Return n
		
	End Function
	
End Type

Type aiScene

	Field pointer:Int Ptr
	Field flags:Int
	
	Field rootNode:aiNode
	Field numMeshes:Int
	Field meshes:aiMesh[]
	Field NumMaterials:Int
	Field materials:aiMaterial[]
	
	' aiImportFileFromMemory by Happy Cat (JM) - Jan 2013
	Method ImportFile:Int Ptr( filename:String,readflags:Int )
	
		If (Left(filename, 8) = "incbin::")
		
			Local binName:String = Mid(filename, 9)
			Local binPtr:Byte Ptr = IncbinPtr(binName)
			Local binLen:Int = IncbinLen(binName)
			
			If (binPtr = Null Or binLen = 0) Then Return Null
			
			pointer = aiImportFileFromMemory(binPtr, binLen, readFlags, Right(fileName, 3))
			
		Else
		?win32	
			' TODO this is a fix for wavefront mtl not being found
			' does this mess up UNC paths or something else?
			filename = filename.Replace("/","\")
		?
			'DebugLog "filename " + filename
			
			pointer = aiImportFile(filename, readflags)
		EndIf
		
		If pointer <> Null
		
			flags = pointer[0]
			
			rootNode = aiNode.Create(Byte Ptr pointer[1])
			numMeshes = pointer[2]
			
			Local pMeshArray:Int Ptr = Int Ptr pointer[3]
			meshes = meshes[..numMeshes]
			
			For Local i:Int = 0 To numMeshes - 1 
				Local pMesh:Int Ptr = Int Ptr pMeshArray[i]
				
				meshes[i] = New aiMesh
				meshes[i].PrimitiveTypes = pMesh[0]
				meshes[i].NumVertices = pMesh[1]
				meshes[i].NumFaces = pMesh[2]
				
				meshes[i].pVertices = Float Ptr pMesh[3]
				meshes[i].pNormals = Float Ptr pMesh[4]
				meshes[i].pTangents = Byte Ptr pMesh[5]
				meshes[i].pBitangents = Byte Ptr pMesh[6]
				
				Local pMeshPointerOffset:Int = 7
				
				For Local n:Int = 0 To AI_MAX_NUMBER_OF_COLOR_SETS - 1
					meshes[i].pColors[n] = Byte Ptr pMesh[pMeshPointerOffset + n]
				Next
				
				pMeshPointerOffset:+ AI_MAX_NUMBER_OF_COLOR_SETS
				
				For Local n:Int = 0 To AI_MAX_NUMBER_OF_TEXTURECOORDS - 1
					meshes[i].pTextureCoords[n] = Byte Ptr pMesh[pMeshPointerOffset + n]
				Next 
				
				pMeshPointerOffset:+ AI_MAX_NUMBER_OF_TEXTURECOORDS
				
				For Local n:Int = 0 To AI_MAX_NUMBER_OF_TEXTURECOORDS - 1
					meshes[i].NumUVComponents[n] = pMesh[pMeshPointerOffset + n]
				Next
				
				pMeshPointerOffset:+ AI_MAX_NUMBER_OF_TEXTURECOORDS
				
				meshes[i].pFaces = Int Ptr pMesh[pMeshPointerOffset]
				meshes[i].NumBones = pMesh[pMeshPointerOffset+1]
				meshes[i].pBones = Byte Ptr pMesh[pMeshPointerOffset+2]
				meshes[i].MaterialIndex = pMesh[pMeshPointerOffset+3]
				
			Next
			
			NumMaterials = pointer[4]
			
			Local pMaterialArray:Int Ptr = Int Ptr pointer[5]
			materials = materials[..NumMaterials]
			
			For Local i:Int = 0 To NumMaterials - 1 
				'DebugLog "Material found"
				
				materials [i] = New aiMaterial 
				materials [i].pMaterial = Int Ptr pMaterialArray[i]
				materials [i].NumProperties = materials [i].pMaterial[1]
				materials [i].NumAllocated = materials [i].pMaterial[2]	
				
				'Rem ' loading properties is not needed, but I do it for now to make a list of loaded properties
				' redim
				materials [i].Properties = materials [i].Properties[..materials [i].pMaterial[1]]
				
				Local pMaterialPropertyArray:Int Ptr = Int Ptr materials [i].pMaterial[0]	
				
				For Local p:Int = 0 To materials [i].NumProperties - 1
					'DebugLog "Materialproperty found"
					materials [i].Properties[p] = aiMaterialProperty.Create(Byte Ptr pMaterialPropertyArray[p])
				Next
				
				'EndRem
			Next
			
		EndIf
		
		Return pointer
		
	End Method
	
	Method ReleaseImport()
	
		If pointer <> Null
			aiReleaseImport(pointer)
		EndIf
		
		pointer = Null
		rootNode = Null
		meshes = Null
		numMeshes = 0
		flags = 0
	
	End Method
		
End Type
