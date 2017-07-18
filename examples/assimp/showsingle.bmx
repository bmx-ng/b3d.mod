' showsingle.bmx
' bones.bmx from Minib3d (no animation)

Strict

Import Openb3dLibs.Assimp

Incbin "media/zombie.b3d"
Incbin "media/Zombie.jpg"

Graphics3D DesktopWidth(),DesktopHeight(),0,2


Local cam:TCamera=CreateCamera()
PositionEntity cam,0,10,-15

Local light:TLight=CreateLight()

Local sphere:TMesh=CreateSphere()
HideEntity sphere
Local ent:TMesh
Local path$ = "../../assimplib.mod/assimp/test/models"

Local test%=1
Select test
	' load anim mesh
	Case 0
		ent=LoadAnimMesh("media/zombie.b3d")
	' load incbin mesh and texture
	Case 1
		aiLoader.meshflags=0 ' 0=smooth normals, 1=flat shaded
		ent=aiLoadMesh("incbin::media/zombie.b3d")
		Local tex:TTexture=LoadTexture("incbin::media/Zombie.jpg",9,True) ' set usepixmap for incbin
		EntityTexture ent,tex
		RotateEntity ent,0,180,0
	' model trouble
	Case 2
		ent=aiLoadMesh("modeltrouble/assimp301/house.dae")
		RotateEntity ent,0,180,0
		FitMesh ent,-10,0,-10,20,20,20,True
	Case 3
		ent=aiLoadMesh("modeltrouble/assimp303/model.obj")
		RotateEntity ent,0,180,0
		FitMesh ent,-10,0,-10,20,20,20,True
	Rem
	' ascii cob bug test
	Case 4
		ent=aiLoadMesh(path+"COB/dwarf_ascii.cob")
		If ent=Null Then ent=sphere
		RotateEntity ent,0,180,0
		FitMesh ent,-10,0,-10,20,20,20,True
	Case 5
		ent=aiLoadMesh(path+"COB/molecule_ascii.cob")
		If ent=Null Then ent=sphere
		RotateEntity ent,0,180,0
		FitMesh ent,-10,0,-10,20,20,20,True
	' mac .a bug test (.dylib works)
	' error: terminate called after throwing an instance of 'Assimp::Blender::Error'
	' what(): BlendDNA: Did not find a field named `angle` in structure `Camera`
	Case 6
		ent=aiLoadMesh(path+"BLEND/4Cubes4Mats_248.blend")
		If ent=Null Then ent=sphere
		RotateEntity ent,0,180,0
		FitMesh ent,-10,0,-10,20,20,20,True
	Case 7
		ent=aiLoadMesh(path+"BLEND/blender_269_regress1.blend")
		If ent=Null Then ent=sphere
		RotateEntity ent,0,180,0
		FitMesh ent,-10,0,-10,20,20,20,True
	EndRem
End Select

' child entity variables
Local child_ent:TEntity ' this will store child entity of anim mesh
Local child_no%=1 ' used to select child entity
Local count_children%=TEntity.CountAllChildren(ent) ' total no. of children belonging to entity

' marker entity. will be used to highlight selected child entity (with zombie anim mesh it will be a bone)
Local marker_ent:TMesh=CreateSphere(8)
EntityColor marker_ent,255,255,0
ScaleEntity marker_ent,.25,.25,.25
EntityOrder marker_ent,-1

' anim time - this will be incremented/decremented each frame and then supplied to SetAnimTime to animate entity
Local anim_time#=0

' used by fps code
Local old_ms%=MilliSecs()
Local renders%=0, fps%=0


While Not KeyDown(KEY_ESCAPE)		

	If KeyHit(KEY_ENTER) Then DebugStop
	
	If KeyDown(KEY_LEFT) Then TurnEntity ent,0,3,0
	If KeyDown(KEY_RIGHT) Then TurnEntity ent,0,-3,0
	
	' control camera
	MoveEntity cam,KeyDown(KEY_D)-KeyDown(KEY_A),0,KeyDown(KEY_W)-KeyDown(KEY_S)

	' change anim time values
	If KeyDown(KEY_MINUS) Then anim_time#=anim_time#-0.1
	If KeyDown(KEY_EQUALS) Then anim_time#=anim_time#+0.1
	
	' animte entity
	SetAnimTime(ent,anim_time#)

	' select child entity
	If KeyHit(KEY_OPENBRACKET) Then child_no=child_no-1
	If KeyHit(KEY_CLOSEBRACKET) Then child_no=child_no+1
	If child_no<1 Then child_no=1
	If child_no>count_children Then child_no=count_children
	
	' get child entity
	Local count%=0 ' this is just a count variable needed by GetChildFromAll. must be set to 0.
	child_ent=ent.GetChildFromAll(child_no,count) ' get child entity

	' position marker entity at child entity position
	If child_ent<>Null
		PositionEntity marker_ent,EntityX(child_ent,True),EntityY(child_ent,True),EntityZ(child_ent,True)
	EndIf

	RenderWorld
	renders=renders+1
	
	' calculate fps
	If MilliSecs()-old_ms>=1000
		old_ms=MilliSecs()
		fps=renders
		renders=0
	EndIf
	
	Text 0,20,"FPS: "+fps
	Text 0,40,"+/- to animate"
	Text 0,60,"[] to select different child entity (bone)"
	Text 0,80,"WSAD move camera, LR arrows turn entity"
	If child_ent<>Null
		Text 0,100,"Child Name: "+EntityName(child_ent)
	EndIf
	Text 0,120,"No children: "+count_children

	Flip
	
Wend
End

