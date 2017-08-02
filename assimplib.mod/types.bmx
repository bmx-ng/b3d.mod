' types.bmx

Type aiMatrix3x3

	Field a1:Float, a2:Float, a3:Float
	Field b1:Float, b2:Float, b3:Float
	Field c1:Float, c2:Float, c3:Float
	
End Type

Type aiMatrix4x4

	Field a1:Float, a2:Float, a3:Float, a4:Float
	Field b1:Float, b2:Float, b3:Float, b4:Float
	Field c1:Float, c2:Float, c3:Float, c4:Float
	Field d1:Float, d2:Float, d3:Float, d4:Float
	
	Field heading:Float
	Field attitude:Float
	Field bank:Float
	
	Field Tx:Float, Ty:Float, Tz:Float
	Field Sx:Float, Sy:Float, Sz:Float
	Field Rx:Float, Ry:Float, Rz:Float
	
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
		
		Sx = Sqr(a1*a1 + a2*a2 + a3*a3)
		Sy = Sqr(b1*b1 + b2*b2 + b3*b3) 
		Sz = Sqr(c1*c1 + c2*c2 + c3*c3)
		
		Local D:Float = a1 * (b2 * c3 - c2 * b3) - b1 * (a2 * c3 - c2 * a3) + c1 * (a2 * b3 - b2 * a3)
		
		Sx:* Sgn(D)
		Sy:* Sgn(D)
		Sz:* Sgn(D)
		
		Local rm:aiMatrix3x3 = New aiMatrix3x3	
		
		rm.a1 = a1 ; rm.a2 = a2 ; rm.a3 = a3
		rm.b1 = b1 ; rm.b2 = b2 ; rm.b3 = b3
		rm.c1 = c1 ; rm.c2 = c2 ; rm.c3 = c3		
		
		If sx Then
			rm.a1:/ sx	
			rm.a2:/ sx	
			rm.a3:/ sx	
		EndIf
		If sy Then
			rm.b1:/ sy
			rm.b2:/ sy	
			rm.b3:/ sy	
		EndIf
		If sz Then
			rm.c1:/ sz
			rm.c2:/ sz	
			rm.c3:/ sz	
		EndIf
		
		If (b1 > 0.998) ' singularity at north pole
			heading = ATan2(rm.a3, rm.c3)
			attitude = 90 'Pi/2
			bank = 0
			'DebugLog "' singularity at north pole **"
			Return
		EndIf
		
		If (b1 < -0.998) ' singularity at south pole
			heading = ATan2(rm.a3, rm.c3)
			attitude = -90 '-Pi/2
			bank = 0
			'DebugLog "' singularity at south pole **"
			Return
		EndIf
		
		heading = ATan2(-rm.c1, rm.a1)
		bank = ATan2(-rm.b3, rm.b2)
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
		If values.length
			Return values[0]	
		Else		
			Return 1.0
		EndIf
		
	End Method
	
	Method GetShininess:Float()
	
		Local values:Float[] = GetMaterialFloatArray(AI_MATKEY_SHININESS)
		If values.length
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
		For Local id:Int = 0 To NumProperties - 1
		
			names[id] = Properties[id].mKey
			
			DebugLog "Property name: " + Properties[id].mKey
			DebugLog "Property type: " + Properties[id].mType
			DebugLog "Property Index " + Properties[id].Index
			DebugLog "Property length " + Properties[id].DataLength
			DebugLog "Property Semantic: " + Properties[id].Semantic
			
			Select Properties[id].mType
				Case aiPTI_Float
					For Local i:Int = 0 Until (Properties[id].DataLength / 4)
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
	
		Local s:Byte[MAXLEN + (4 * PAD)]
		'Local kp:Byte Ptr = Key.ToCstring()
		
		Local retVal:Int = aiGetMaterialString(pMaterial, Key, 0, 0, Varptr s[0])
		'MemFree kp
		
		If retVal = AI_SUCCESS
			Return String.FromCString(Varptr s[4 * PAD])
		'Else
			'DebugLog "mat. aiGetMaterialString failed with code " + retVal
		EndIf
		
	End Method
	
	Method GetMaterialColor:Float[](Key:String)	
	
		Local colors:Float[4]
		If aiGetMaterialColor(pMaterial, Key, 0, 0, colors)	= AI_SUCCESS
			Return colors
		EndIf
		
	End Method
	
	Method GetMaterialIntegerArray:Int[](Key:String)
	
		Local size:Int = MAXLEN
		Local values:Int[size]
		
		If aiGetMaterialIntegerArray(pMaterial, Key, 0, 0, values, Varptr size)	= AI_SUCCESS
			values = values[..size]
			Return values
		EndIf
		
	End Method	
	
	Method GetMaterialFloatArray:Float[](Key:String)
	
		Local size:Int = MAXLEN
		Local values:Float[size]
		
		If aiGetMaterialFloatArray(pMaterial, Key, 0, 0, values, Varptr size) = AI_SUCCESS
			values = values[..size]
			Return values
		EndIf
		
	End Method
	
	Method GetMaterialTexture:String(index:Int = 0)
	
		Local s:Byte[MAXLEN + (4 * PAD)]
		Local retval:Int = aiGetMaterialTexture(pMaterial, aiTextureType_DIFFUSE, index, Varptr s[0])
		
		If retVal = AI_SUCCESS			
			Return String.FromCString(Varptr s[4 * PAD])
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
		
		mp.mKey = String.FromCString(pProps + (4 * PAD))
		
		Local pVars:Int Ptr = Int Ptr(pProps + MAXLEN + (4 * PAD))
		
		mp.Semantic = pVars[0]
		mp.Index = pVars[1]
		mp.DataLength = pVars[2]
		mp.mType = pVars[3]
		mp.mData = Byte Ptr pVars[4]
		
		'DebugLog "mp.Semantic="+mp.Semantic
		'DebugLog "mp.Index ="+mp.Index 
		'DebugLog "mp.DataLength ="+mp.DataLength 
		'DebugLog "mp.mType ="+mp.mType 
		'DebugLog "mp.mData ="+mp.mData 
		
		Return mp
		
	End Function
	
	Method GetFloatValue:Float(index:Int)
	
		Return Float Ptr(mData)[index]
		
	End Method
	
	Method GetStringValue:String()
	
		Return String.FromCString(mData + (4 * PAD))
		
	End Method
	
	Method GetIntegerValue:Int (index:Int)
	
		Return Int Ptr(mData)[index]
		
	End Method
	
	Method GetByteValue:Byte(index:Int)
	
		Return mData[index]
		
	End Method
	
End Type

Rem
bbdoc: A mesh represents a geometry or model with a single material.
about: It usually consists of a number of vertices and a series of primitives/faces 
referencing the vertices. In addition there might be a series of bones, each 
of them addressing a number of vertices with a certain weight. Vertex data 
is presented in channels with each channel containing a single per-vertex 
information such as a set of texture coords or a normal vector.
If a data pointer is non-null, the corresponding data stream is present.
From C++ programs you can also use the comfort functions Has*() to
test for the presence of various data streams.
<br><br>
A mesh uses only a single material which is referenced by a material ID.
@note The mPositions member is usually not optional. However, vertex positions 
*could* be missing if the AI_SCENE_FLAGS_INCOMPLETE flag is set in aiScene::mFlags.
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
	Field pColors:Byte Ptr[AI_MAX_NUMBER_OF_COLOR_SETS * PAD]
	Field pTextureCoords:Byte Ptr[AI_MAX_NUMBER_OF_TEXTURECOORDS * PAD]
	Field NumUVComponents:Int[AI_MAX_NUMBER_OF_TEXTURECOORDS]
	Field pFaces:Int Ptr
	Field NumBones:Int
	Field pBones:Byte Ptr
	Field MaterialIndex:Int
	
	' vertices
	
	Method VertexX:Float(index:Int)
	
		Return pVertices[index * 3]
		
	End Method
	
	Method VertexY:Float(index:Int)
	
		Return pVertices[(index * 3) + 1]
		
	End Method
	
	Method VertexZ:Float(index:Int)
	
		Return pVertices[(index * 3) + 2]
		
	End Method
	
	' normals
	
	Method VertexNX:Float(index:Int)
	
		Return pNormals[index * 3]
		
	End Method
	
	Method VertexNY:Float(index:Int)
	
		Return pNormals[(index * 3) + 1]
		
	End Method
	
	Method VertexNZ:Float(index:Int)
	
		Return pNormals[(index * 3) + 2]
		
	End Method
	
	' texcoords - funky :-)
	
	Method VertexU:Float(index:Int, coord_set:Int = 0)
	
		Return Float Ptr(pTextureCoords[coord_set])[index * 3]
		
	End Method
	
	Method VertexV:Float(index:Int, coord_set:Int = 0)
	
		Return Float Ptr(pTextureCoords[coord_set])[(index * 3) + 1]
		
	End Method
	
	Method VertexW:Float(index:Int, coord_set:Int = 0)
	
		Return Float Ptr(pTextureCoords[coord_set])[(index * 3) + 2]
		
	End Method
	
	Method VertexRed:Float(index:Int, color_set:Int = 0)
	
		Return Float Ptr(pColors[color_set])[index * 4]
		
	End Method
	
	Method VertexGreen:Float(index:Int, color_set:Int = 0)
	
		Return Float Ptr(pColors[color_set])[(index * 4) + 1]
		
	End Method
	
	Method VertexBlue:Float(index:Int, color_set:Int = 0)
	
		Return Float Ptr(pColors[color_set])[(index * 4) + 2]
		
	End Method
	
	Method VertexAlpha:Float(index:Int, color_set:Int = 0)
	
		Return Float Ptr(pColors[color_set])[(index * 4) + 3]
		
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
	
	Method HasVertexColors:Int(color_set:Int)
	
		If NumVertices <= 0 Then Return False
		If color_set >= AI_MAX_NUMBER_OF_COLOR_SETS Then Return False
		If pColors[color_set] <> Null Then Return True
		
	End Method	
	
	Method TriangleVertex:Int(index:Int, corner:Int)
	
		Local faceIndexes:Int Ptr = Int Ptr pFaces[((index * 2) + 1) * PAD]
		Return faceIndexes[corner]
		
	End Method
	
	Method GetTriangularFaces:Int[,]()
	
		Local faces:Int[NumFaces, 3]
		Local index:Int
		
		For Local count:Int = 0 To NumFaces - 1
			Local faceCount:Int = pFaces[index * PAD]
			Local faceIndexes:Int Ptr = Int Ptr pFaces[(index + 1) * PAD]
			
			' TODO for nontriangular faces: faceCount could be other than 3
			For Local n:Int = 0 To 2
				faces[count, n] = faceIndexes[n]
			Next
			
			index:+ 2
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
	
	Function Create:aiNode(pointer:Byte Ptr, parent:aiNode = Null)
	
		Local node:aiNode = New aiNode
		node.Parent = parent
		node.pointer = pointer
		
		node.name = String.FromCString(pointer + (4 * PAD))
		
		DebugLog "Nodename " + node.name
		
		node.transformation = aiMatrix4x4.Create(Float Ptr (Byte Ptr pointer + MAXLEN + (4 * PAD)))
		
		Local pBase:Int Ptr = Int Ptr(Byte Ptr pointer + MAXLEN + (4 * PAD) + (16 * 4))
		
		'For Local i:Int = 0 To 11
		'	DebugLog "pBase " + i + "=" + pBase[i]
		'Next
		
		'Rem
		node.NumMeshes = pBase[3 * PAD] ' int 3/6
		
		DebugLog "Mesh count for this node: " + node.NumMeshes
		
		Local pMeshIndexArray:Int Ptr = Int Ptr pBase[4 * PAD] ' ptr 4/8
		
		node.MeshIndexes = node.MeshIndexes[..node.NumMeshes]
		
		For Local id:Int = 0 To node.NumMeshes - 1
			node.MeshIndexes[id] = pMeshIndexArray[id * PAD]
		Next
		'End Rem
		
		' get child nodes
		node.NumChildren = pBase[1 * PAD] ' int 1/2
		
		DebugLog "node.NumChildren=" + node.NumChildren
		
		If node.NumChildren
			Local pChildArray:Int Ptr = Int Ptr pBase[2 * PAD] ' ptr 2/4
			
			'For Local i:Int = 0 To 11
			'	DebugLog "pChildArray " + i + "=" + pChildArray[i]
			'Next
			
			node.Children = node.Children[..node.NumChildren]
			
			For Local id:Int = 0 To node.NumChildren - 1
				node.Children[id] = aiNode.Create(Byte Ptr pChildArray[id * PAD], node)
			Next
		EndIf
		
		Return node
		
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
	
	Method ImportFile:Int Ptr(fileName:String, readflags:Int)
	
		If (Left(filename, 5) = "zip::") ' load zip mesh (ram stream by Pertubatio)
		
			Local fileStream:TStream = CreateBufferedStream(fileName)
			Local bufLen:Int = StreamSize(fileStream)
			Local buffer:Byte Ptr = MemAlloc(bufLen)
			Local ramStream:TRamStream = CreateRamStream(buffer, bufLen, True, True)
			CopyStream(fileStream, ramStream)
			
			pointer = aiImportFileFromMemory(buffer, bufLen, readFlags, Right(fileName, 3))
			
			MemFree(buffer)
			CloseStream(fileStream)
			CloseStream(ramStream)
			
		ElseIf (Left(filename, 8) = "incbin::") ' load incbin mesh by Happy Cat - Jan 2013
		
			Local binName:String = Mid(filename, 9)
			Local buffer:Byte Ptr = IncbinPtr(binName)
			Local bufLen:Int = IncbinLen(binName)
			If (buffer = Null Or bufLen = 0) Then Return Null
			
			pointer = aiImportFileFromMemory(buffer, bufLen, readFlags, Right(fileName, 3))
			
		Else
		?win32
			' TODO this is a fix for wavefront mtl not being found
			' does this mess up UNC paths or something else?
			filename = filename.Replace("/", "\")
		?
			pointer = aiImportFile(filename, readflags)
			
		EndIf
		
		If pointer <> Null
		
			flags = pointer[0]
			
			'For Local n:Int = 0 To 23
			'	DebugLog "pointer " + n + "=" + pointer[n]
			'Next
			
			rootNode = aiNode.Create(Byte Ptr pointer[1 * PAD]) ' 1/2
			numMeshes = pointer[2 * PAD] ' 2/4
			
			Local pMeshArray:Int Ptr = Int Ptr pointer[3 * PAD] ' 3/6
			meshes = meshes[..numMeshes]
			
			DebugLog "flags = " + flags
			DebugLog "rootNode.pointer = " + rootNode.pointer
			DebugLog "numMeshes = " + numMeshes ' 1/3
			DebugLog "pMeshArray = " + pMeshArray ' 2/5
			
			For Local id:Int = 0 To numMeshes - 1
				Local pMesh:Int Ptr = Int Ptr pMeshArray[id * PAD]
				
				'For Local n:Int = 0 To 13
				'	DebugLog "pmesh " + n + "=" + pMesh[n]
				'Next
				
				meshes[id] = New aiMesh
				meshes[id].PrimitiveTypes = pMesh[0]
				meshes[id].NumVertices = pMesh[1]
				meshes[id].NumFaces = pMesh[2]
				
				meshes[id].pVertices = Float Ptr pMesh[(2 * PAD) + ONE32] ' 3/4 - calculate 32/64 offsets
				meshes[id].pNormals = Float Ptr pMesh[(3 * PAD) + ONE32] ' 4/6
				meshes[id].pTangents = Byte Ptr pMesh[(4 * PAD) + ONE32] ' 5/8
				meshes[id].pBitangents = Byte Ptr pMesh[(5 * PAD) + ONE32] ' 6/10
				
				DebugLog "meshes[" + id + "].PrimitiveTypes = " + meshes[id].PrimitiveTypes 
				DebugLog "meshes[" + id + "].NumVertices = " + meshes[id].NumVertices 
				DebugLog "meshes[" + id + "].NumFaces = " + meshes[id].NumFaces 
				DebugLog "meshes[" + id + "].pVertices = " + meshes[id].pVertices 
				DebugLog "meshes[" + id + "].pNormals = " + meshes[id].pNormals 
				DebugLog "meshes[" + id + "].pTangents = " + meshes[id].pTangents 
				DebugLog "meshes[" + id + "].pBitangents = " + meshes[id].pBitangents 
				
				Local pMeshPointerOffset:Int = (6 * PAD) + ONE32 ' 7/12
				
				For Local n:Int = 0 To AI_MAX_NUMBER_OF_COLOR_SETS - 1
					meshes[id].pColors[n] = Byte Ptr pMesh[pMeshPointerOffset + n] ' ptr arr - twice the size in 64-bit
					'DebugLog "meshes[" + id + "].pColors[n] = " + meshes[id].pColors[n]
				Next
				
				pMeshPointerOffset:+ (AI_MAX_NUMBER_OF_COLOR_SETS * PAD) ' 15/28
				
				For Local n:Int = 0 To AI_MAX_NUMBER_OF_TEXTURECOORDS - 1
					meshes[id].pTextureCoords[n] = Byte Ptr pMesh[pMeshPointerOffset + n] ' ptr arr
					'DebugLog "meshes[" + id + "].pTextureCoords[n] = " + meshes[id].pTextureCoords[n]
				Next 
				
				pMeshPointerOffset:+ (AI_MAX_NUMBER_OF_TEXTURECOORDS * PAD) ' 23/44
				
				For Local n:Int = 0 To AI_MAX_NUMBER_OF_TEXTURECOORDS - 1
					meshes[id].NumUVComponents[n] = pMesh[pMeshPointerOffset + n] ' int arr - same size as 32-bit
					'DebugLog "meshes[" + id + "].NumUVComponents[n] = " + meshes[id].NumUVComponents[n]
				Next
				
				pMeshPointerOffset:+ AI_MAX_NUMBER_OF_TEXTURECOORDS ' 31/52
				
				meshes[id].pFaces = Int Ptr pMesh[pMeshPointerOffset]
				meshes[id].NumBones = pMesh[pMeshPointerOffset + (1 * PAD)] ' 32/54
				meshes[id].pBones = Byte Ptr pMesh[pMeshPointerOffset + (2 * PAD)] ' 33/55
				meshes[id].MaterialIndex = pMesh[pMeshPointerOffset + (3 * PAD)] ' 34/57
				
				'For Local n:Int = 0 To meshes[id].NumFaces - 1
				'	DebugLog "meshes[id].pFaces " + n + "="+meshes[id].pFaces[n]
				'Next
				
				DebugLog "meshes[" + id + "].pFaces = " + meshes[id].pFaces
				DebugLog "meshes[" + id + "].NumBones = " + meshes[id].NumBones 
				DebugLog "meshes[" + id + "].pBones = " + meshes[id].pBones 
				DebugLog "meshes[" + id + "].MaterialIndex = " + meshes[id].MaterialIndex
				
			Next
			
			NumMaterials = pointer[4 * PAD] ' 4/8
			
			Local pMaterialArray:Int Ptr = Int Ptr pointer[5 * PAD] ' 5/10
			materials = materials[..NumMaterials]
			
			DebugLog "NumMaterials = " + NumMaterials
			DebugLog "pMaterialArray = " + pMaterialArray
			
			For Local id:Int = 0 To NumMaterials - 1 
				DebugLog "Material found"
				
				materials[id] = New aiMaterial
				materials[id].pMaterial = Int Ptr pMaterialArray[id * PAD]
				materials[id].NumProperties = materials[id].pMaterial[1 * PAD]
				materials[id].NumAllocated = materials[id].pMaterial[2 * PAD]
				
				'Rem
				' loading properties is not needed, but I do it for now to make a list of loaded properties
				' redim
				materials[id].Properties = materials[id].Properties[..materials[id].pMaterial[1 * PAD]]
				
				Local pMaterialPropertyArray:Int Ptr = Int Ptr materials[id].pMaterial[0]	
				
				For Local pid:Int = 0 To materials[id].NumProperties - 1
					DebugLog "Materialproperty found"
					materials[id].Properties[pid] = aiMaterialProperty.Create(Byte Ptr pMaterialPropertyArray[pid * PAD])
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
