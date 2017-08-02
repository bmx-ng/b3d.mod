' showdebug.bmx

Strict

Framework Openb3d.Openb3d
Import Openb3dLibs.Assimp

'Include "typeslib.bmx"
'Include "types.bmx"

Local width%=DesktopWidth(),height%=DesktopHeight(),depth%=0,Mode%=2

Graphics3D width,height,depth,Mode

Local cam:TCamera=CreateCamera()
PositionEntity cam,0,10,-15

Local light:TLight=CreateLight()

Local sphere:TMesh=CreateSphere()
HideEntity sphere

Local path$ = "../../assimplib.mod/assimp/test/models"
Local ent:TMesh

Local test%=2

Select test

	Case 1 ' load assimp mesh
		Local time:Int=MilliSecs()
		Local file:String = "../media/zombie.b3d"
		ent = aiLoader.LoadMesh(file, Null, -2)
		DebugLog "assimp time="+(time-MilliSecs())
		
	' debugging
	Case 2 ' model trouble
		DebugLog "modeltrouble test:"
		ent=aiLoader.LoadMesh("modeltrouble/assimp301/house.dae")
		FitMesh ent,-10,0,-10,20,20,20,True
		
	Case 3
		DebugLog "modeltrouble test:"
		ent=aiLoader.LoadMesh("modeltrouble/assimp303/model.obj")
		FitMesh ent,-10,0,-10,20,20,20,True
		
	Case 4 ' ascii cob bug test
		DebugLog "cob test:"
		ent=aiLoader.LoadMesh(path+"COB/dwarf_ascii.cob")
		If ent=Null Then ent=sphere
		FitMesh ent,-10,0,-10,20,20,20,True
		
	Case 5
		DebugLog "cob test:"
		ent=aiLoader.LoadMesh(path+"COB/molecule_ascii.cob")
		If ent=Null Then ent=sphere
		FitMesh ent,-10,0,-10,20,20,20,True
		
	Case 6 ' blend bug test
		' error: terminate called after throwing an instance of 'Assimp::Blender::Error'
		' what(): BlendDNA: Did not find a field named `angle` in structure `Camera`
		DebugLog "blend test:"
		ent=aiLoader.LoadMesh(path+"BLEND/4Cubes4Mats_248.blend")
		If ent=Null Then ent=sphere
		FitMesh ent,-10,0,-10,20,20,20,True
		
	Case 7
		DebugLog "blend test:"
		ent=aiLoader.LoadMesh(path+"BLEND/blender_269_regress1.blend")
		If ent=Null Then ent=sphere
		FitMesh ent,-10,0,-10,20,20,20,True
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
	
	Text 0,0,"FPS: "+fps
	Text 0,20,"+/- to animate"
	Text 0,40,"[] to select different child entity (bone)"
	Text 0,60,"WSAD move camera, LR arrows turn entity"
	If child_ent<>Null
		Text 0,80,"Child Name: "+EntityName(child_ent)
	EndIf
	Text 0,100,"No children: "+count_children

	Flip
	
Wend
End
