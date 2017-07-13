' user_data.bmx
' set and retrieve custom user data.

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
	
	Local inc:Int=0
	While (inc<40)
		inc:+1
		world.Update(timestep)
		
		RenderWorld
				
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
	
	' Attach our custom data structure to the body.
	ng.mydata = New TUserData ' new global
	ng.mydata.bodyID = 5
	body.SetUserData(Object(ng.mydata))
	
	collision.Destroy()
	Return body
	
End Function

' callbacks are for sending newton data, each callback has a specific set of parameters
Function cb_applyForce(body:TNBody, timestep:Float, threadIndex:Int)

	' Request the custom data, print the ID, and increment it.
	Local mydata:TUserData = TUserData(body.GetUserData())
	Print "BodyID: "+mydata.bodyID
	mydata.bodyID:+1
	
End Function

' Define a custom data structure to store a body ID.
Type TUserData
  Field bodyID:Int=0
End Type

Type TNewtonGlobal
	' should be global if used in callback
	Field matrix:TNMatrix
	Field mydata:TUserData
End Type
