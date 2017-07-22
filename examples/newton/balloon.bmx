' balloon.bmx
' create a spherical body, apply a force, and track its motion over time

SuperStrict

Framework Openb3d.B3dglgraphics

Import Openb3dLibs.NewtonDynamics
Import Brl.Standardio

' global variables
Global ng:TNewtonGlobal = New TNewtonGlobal

Main()


Function Main()

	' init scene
	Graphics3D DesktopWidth(),DesktopHeight(),0,2
	
	Local cam:TCamera = CreateCamera()
	PositionEntity cam,0,5,-20
	
	Local light:TLight = CreateLight()
	
	Local balloon:TMesh = CreateSphere()
	EntityColor balloon,200,200,0
	
	Local plane:TMesh = CreatePlane()
	EntityColor plane,0,100,200
		
	' Create the Newton world.
	Local world:TNWorld = TNWorld.Create()
	
	' Add the sphere.
	ng.matrix = New TNMatrix ' new global
	Local body:TNBody = addSphereToSimulation(world)
	
	' Step the (empty) world 60 times in increments of 1/60 second.
	Local timestep:Float = 1.0 / 60
	
	While Not KeyHit(KEY_ESCAPE)
		world.Update(timestep)
		
		' update the position of the balloon
		PositionEntity balloon,ng.matrix.positX,ng.matrix.positY,ng.matrix.positZ
		
		RenderWorld
		
		Text 0,20,"timestep="+timestep+" x="+ng.matrix.positX+" y="+ng.matrix.positY+" z="+ng.matrix.positZ
		Text 0,40,"Memory: "+GCMemAlloced()
		
		Flip
		GCCollect
	Wend
	
	' Clean up.
	world.DestroyAllBodies()
	world.Destroy()
	
	End
	
End Function

Function addSphereToSimulation:TNBody(world:TNWorld)

	Local foo:TNMatrix = TNMatrix.GetIdentityMatrix()
	
	' Create the sphere, size is radius
	Local collision:TNCollision = world.CreateSphere(1.0, 0, Null)
	
	' Create the rigid body
	Local body:TNBody = world.CreateDynamicBody(collision,foo,Null)
	
	body.SetMassMatrix(1.0, 1, 1, 1)
	
	' Install callback. Newton will call it whenever the object moves.
	body.SetForceAndTorqueCallback(cb_applyForce)
	
	collision.Destroy()
	Return body
	
End Function

' callbacks are for sending newton data, each callback has a specific set of parameters
Function cb_applyForce(body:TNBody, timestep:Float, threadIndex:Int)

	' Apply a force to the object.
	Local force:Float[] = [0, 1.0, 0, 0]
	body.SetForce(force[0],force[1],force[2],force[3])
	
	' Query the state (4x4 matrix) and extract the body's position.
	body.GetMatrix(ng.matrix)
	
End Function

Type TNewtonGlobal
	' should be global if used in callback
	Field matrix:TNMatrix
End Type
