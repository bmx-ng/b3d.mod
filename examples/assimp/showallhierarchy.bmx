' showallhierarchy.bmx
' Assimp sample viewer with hierarchy functions

Strict

Import Openb3dlibs.Assimp

Graphics3D DesktopWidth(),DesktopHeight(),0,2


Local cam:TCamera=CreateCamera()
PositionEntity cam,0,150,-145

CameraClsColor cam,200,200,255
CameraRange cam,0.1,1000

Local light:TLight=CreateLight()
RotateEntity light,45,0,0

' get some files to show
Local filelist:TList = New TList
Local skipExt:TList = New TList

Local path$
path = "../../assimplib.mod/assimp/test/models-nonbsd"
'path = "../../assimplib.mod/assimp/test/models"
If FileSize(path)=-1 Then Print "Error: path not found"

'skipExt.addlast("xml")
'skipExt.addlast("nff")
'skipExt.addlast("blend")
'skipExt.addlast("bvh")
'skipExt.addlast("dxf")
'skipExt.addlast("ifc")
'skipExt.addlast("irrmesh")

Local test%=0
Select test
	Case 0 ' load all
		aiEnumFiles( filelist,path,skipExt )
	Case 1 ' specify a format
		aiEnumFiles( filelist,path+"/OBJ",skipExt )
	Case 2 ' current directory
		aiEnumFiles( filelist,"./",skipExt )
	Case 3 ' load path
		path=RequestDir( "Select a Folder",CurrentDir() )
		If FileType(path$) = 2 Then aiEnumFiles( filelist,path,skipExt )
End Select

Local filearray:Object[] = filelist.Toarray()
Local fileNUmber:Int = 0

If filearray.length = 0 Then
	Notify "No files to show, please choose a different directory"
	End
EndIf

Local sp:TMesh = CreateSphere()
'ScaleEntity sp,24,24,24
'EntityAlpha sp,0.4

Local mainEnt:TMesh = CreateCube()
PointEntity cam,mainEnt

' slideshow
Local go:Int = 1
Local lastslideTime:Int = MilliSecs()
Local slideDuration:Int = 2000
Local slideshow:Int = False

Local currentModel:String = "Press space to load the next model"

' used by fps code
Local old_ms%=MilliSecs()
Local renders%=0, fps%=0


While Not KeyDown(KEY_ESCAPE)		

	If slideshow
		If MilliSecs() > lastslideTime + slideDuration
			go = True
		EndIf
	EndIf
	
	' hierarchy functions
	If KeyHit(KEY_X)
		aiHelper.RotateEntityAxisAll( mainEnt,1 )
	EndIf
	If KeyHit(KEY_Y)
		aiHelper.RotateEntityAxisAll( mainEnt,2 )
	EndIf
	If KeyHit(KEY_Z)
		aiHelper.RotateEntityAxisAll( mainEnt,3 )
	EndIf
	
	If KeyHit(KEY_U)
		aiHelper.UpdateNormalsAll( mainEnt )
	EndIf
	
	If KeyHit(KEY_F)
		aiHelper.FlipMeshAll( mainEnt )
	EndIf
	
	If KeyHit(KEY_1)
		aiHelper.ScaleMeshAxisAll( mainEnt,1 )
	EndIf
	If KeyHit(KEY_2)
		aiHelper.ScaleMeshAxisAll( mainEnt,2 )
	EndIf
	If KeyHit(KEY_3)
		aiHelper.ScaleMeshAxisAll( mainEnt,3 )
	EndIf
	
	If KeyHit(KEY_SPACE) Or go = 1
	
		go = 0
		If fileNUmber > filearray.length-1
			fileNUmber = 0
		EndIf
		
		DebugLog String(filearray[fileNUmber])
		
		If aiIsExtensionSupported( ExtractExt(String(filearray[fileNUmber])) )
		
			currentModel = String(filearray[fileNUmber])
			
			If mainEnt Then FreeEntity mainEnt ; mainEnt = Null
			
			mainEnt = aiLoadMesh( String(filearray[fileNUmber]) )
			
			If mainEnt Then aiFitAnimMesh mainEnt,-100,-100,-100,200,200,200,True	
			
		EndIf
		
		lastslideTime = MilliSecs()
		fileNUmber:+1
		
	EndIf
	
	If mainEnt
		TurnEntity mainEnt,0,1,0
	EndIf
	
	' control camera
	MoveEntity cam,KeyDown(KEY_D)-KeyDown(KEY_A),0,KeyDown(KEY_W)-KeyDown(KEY_S)
	TurnEntity cam,KeyDown(KEY_DOWN)-KeyDown(KEY_UP),KeyDown(KEY_LEFT)-KeyDown(KEY_RIGHT),0
	
	RenderWorld
	
	' calculate fps
	renders=renders+1
	If MilliSecs()-old_ms>=1000
		old_ms=MilliSecs()
		fps=renders
		renders=0
	EndIf
	
	Text 0,20,fileNUmber+"/"+filearray.length+" "+StripDir(currentModel)
	Text 0,40,"FPS: "+fps+", Tri count: "+aiHelper.CountTrianglesAll(mainEnt)
	Text 0,60,"Space: next model, X,Y,Z: rotate entity on axis, "
	Text 0,80,"U: update normals, F: flip mesh faces, 1,2,3: scale mesh on axis"
	
	Flip
	
Wend
End

