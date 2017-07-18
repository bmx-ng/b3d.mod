' showall.bmx
' Assimp sample viewer

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
'path = "../../assimplib.mod/assimp/test/models-nonbsd"
path = "../../assimplib.mod/assimp/test/models"
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

Local sp:TEntity = CreateSphere()
ScaleEntity sp,24,24,24
EntityAlpha sp,0.3

Local mesh:TMesh = CreateCube()
PointEntity cam,mesh

' slideshow
Local go:Int =1
Local lastslideTime:Int = MilliSecs()
Local slideDuration:Int = 1000
Local slideshow:Int = False

Local currentFile:String = "Press space to load the next model"

' used by fps code
Local old_ms%=MilliSecs()
Local renders%=0, fps%=0


While Not KeyDown(KEY_ESCAPE)		

	If slideshow
		If MilliSecs() > lastslideTime + slideDuration
			go = 1
		EndIf
	EndIf	

	If KeyHit(KEY_SPACE) Or go = 1
	
		go = 0
		If fileNUmber > filearray.length -1
			fileNUmber = 0
		EndIf

		DebugLog String(filearray[fileNUmber])

		If aiIsExtensionSupported( ExtractExt(String(filearray[fileNUmber])) )

			currentFile = String(filearray[fileNUmber])
			
			If mesh Then FreeEntity mesh ; mesh = Null
			
			mesh = aiLoadMesh( String(filearray[fileNUmber]) )
			
			If mesh
			'	EntityPickMode( mesh,2 )
				aiFitAnimMesh mesh,-100,-100,-100,200,200,200,True
			'	FitMesh mesh,-100,-100,-100,200,200,200,True
			EndIf
		EndIf
		
		lastslideTime = MilliSecs()
		fileNUmber:+1
		
	EndIf
	
	If mesh 
		TurnEntity mesh,0,1,0
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
	
	Text 0,20,fileNUmber + "/" + filearray.length + " " + StripDir(currentFile)
	Text 0,40,"FPS: "+fps+", Tri count: "+aiHelper.CountTrianglesAll(mesh)
	
	Flip
	
Wend
End

