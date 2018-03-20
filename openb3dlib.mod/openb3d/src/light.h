/*
 *  light.h
 *  iminib3d
 *
 *  Created by Simon Harrison.
 *  Copyright Si Design. All rights reserved.
 *
 */
 
#ifndef LIGHT_H
#define LIGHT_H

#include "entity.h"
 
#include <vector>
#include <cmath>
using namespace std;
 
class Light : public Entity{
 
public:
 
	static int light_no;
	static int no_lights;
	static int max_lights;
	
	// enter gl consts here for each available light
	static int gl_light[];

	static vector<Light*> light_list;

	int light_type;
	float range;
	float red,green,blue;
	float inner_ang,outer_ang;
	
	Light(){
											
		light_type=0;
		range=1.0/1000.0;
		red=1.0;
		green=1.0;
		blue=1.0;
		inner_ang=0.0;
		outer_ang=45.0;
	
	}
	
	Light* CopyEntity(Entity* parent_ent=NULL);
	void FreeEntity(void);
	
	static Light* CreateLight(int l_type=1,Entity* parent_ent=NULL);
	void LightRange(float light_range);	
	void LightColor(float r,float g,float b);
	void LightConeAngles(float inner,float outer);
	void Update();
 
 };
 
 #endif
