/*
 *  global.h
 *  iminib3d
 *
 *  Created by Simon Harrison.
 *  Copyright Si Design. All rights reserved.
 *
 */

#ifndef GLOBAL_H
#define GLOBAL_H

#include "pivot.h"
#include "mesh.h"

class Camera;

class Global{

public:

	static int width,height,mode,depth,rate;
	static float ambient_red,ambient_green,ambient_blue;

	static int vbo_enabled;
	static int vbo_min_tris;

	static int Shadows_enabled;

	static float anim_speed;

	static int fog_enabled; // used to keep track of whether fog is enabled between camera update and mesh render

	static Pivot* root_ent;

	static Camera* camera_in_use;
	
	static void Graphics();
	
	static void AmbientLight(float r,float g,float b);
	
	static void ClearCollisions();
	static void Collisions(int src_no,int dest_no,int method_no,int response_no=0);
	static void ClearWorld(int entities=true,int brushes=true,int textures=true);
	static void UpdateWorld(float anim_speed=1.0);
	static void RenderWorld();
	static void UpdateEntityAnim(Mesh& mesh);

	static int alpha_enable;
	static int blend_mode;
	static int fx1;
	static int fx2;


	
};

bool CompareEntityOrder(Entity* ent1,Entity* ent2);

#endif
