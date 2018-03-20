
#ifdef OPENB3D_GLEW
	#include "glew.h"
#else
	#ifdef linux
	#define GL_GLEXT_PROTOTYPES
	#include <GL/gl.h>
	#include <GL/glext.h>
	#endif

	#ifdef WIN32
	#include <gl\GLee.h>
	#endif

	#ifdef __APPLE__
	#include "GLee.h"
	#endif
#endif

#include "voxel.h"
#include "global.h"
#include "camera.h"

void Add3DVertex(Surface* surf, float x, float y, float z,float u,float v,float w){
	surf->no_verts++;

	surf->vert_coords.push_back(x);
	surf->vert_coords.push_back(y);
	surf->vert_coords.push_back(-z); // ***ogl***

	surf->vert_col.push_back(1.0);
	surf->vert_col.push_back(1.0);
	surf->vert_col.push_back(1.0);
	surf->vert_col.push_back(1.0);


	surf->vert_norm.push_back(0.0);
	surf->vert_norm.push_back(0.0);
	surf->vert_norm.push_back(-1.0);

	surf->vert_tex_coords1.push_back(u);
	surf->vert_tex_coords1.push_back(v);
	surf->vert_tex_coords1.push_back(w);

}

VoxelSprite* VoxelSprite::CreateVoxelSprite(int slices, Entity* parent_ent){

	VoxelSprite* voxelSprite=new VoxelSprite();

	voxelSprite->class_name="VoxelSprite";

	voxelSprite->AddParent(*parent_ent);
	entity_list.push_back(voxelSprite);

	//update matrix
	if(voxelSprite->parent!=0){
		voxelSprite->mat.Overwrite(voxelSprite->parent->mat);
		voxelSprite->UpdateMat();
	}else{
		voxelSprite->UpdateMat(true);
	}
	//voxelSprite->no_surfs=-1;
	float t,t2;
	int i;

	voxelSprite->no_mats=0;




	voxelSprite->min_x=-1;
	voxelSprite->max_x=1;
	voxelSprite->min_y=-1;
	voxelSprite->max_y=1;
	voxelSprite->min_z=-1;
	voxelSprite->max_z=1;





	Surface* surf;
	surf=voxelSprite->CreateSurface();
	
		for(i=-slices; i<=slices; i++) { // draw slices perpendicular to x-axis
			t = i/(float)slices;
			t2 = (i+slices)/(float)(2*slices);
			surf->tris.push_back(surf->no_verts);
			Add3DVertex(surf, t,-1,-1, t2,0,0);
			surf->tris.push_back(surf->no_verts);
			Add3DVertex(surf, t,1,-1, t2,1,0);
			surf->tris.push_back(surf->no_verts);
			Add3DVertex(surf, t,1,1, t2,1,1);
			surf->tris.push_back(surf->no_verts);
			Add3DVertex(surf, t,-1,1, t2,0,1);
			surf->no_tris++;
		}

	surf=voxelSprite->CreateSurface();
		for(i=-slices; i<=slices; i++) { // draw slices perpendicular to y-axis
			t = i/(float)slices;
			t2 = (i+slices)/(float)(2*slices);
			surf->tris.push_back(surf->no_verts);
			Add3DVertex(surf, -1,t,-1, 0,t2,0);
			surf->tris.push_back(surf->no_verts);
			Add3DVertex(surf, 1,t,-1, 1,t2,0);
			surf->tris.push_back(surf->no_verts);
			Add3DVertex(surf, 1,t,1, 1,t2,1);
			surf->tris.push_back(surf->no_verts);
			Add3DVertex(surf, -1,t,1, 0,t2,1);
			surf->no_tris++;
		}

	surf=voxelSprite->CreateSurface();
		for(i=-slices; i<=slices; i++) { // draw slices perpendicular to z-axis
			t = i/(float)slices;
			t2 = (i+slices)/(float)(2*slices);
			surf->tris.push_back(surf->no_verts);
			Add3DVertex(surf,-1,-1,t, 0,0, t2);
			surf->tris.push_back(surf->no_verts);
			Add3DVertex(surf,1,-1,t, 1,0, t2);
			surf->tris.push_back(surf->no_verts);
			Add3DVertex(surf,1,1,t, 1,1, t2);
			surf->tris.push_back(surf->no_verts);
			Add3DVertex(surf,-1,1,t, 0,1, t2);
			surf->no_tris++;
		}
	voxelSprite->reset_bounds=0;



	list<Surface*>::iterator surf_it;
	int surf_number=0, level=0;

	for(surf_it=voxelSprite->surf_list.begin();surf_it!=voxelSprite->surf_list.end();surf_it++){
		level=1;
		surf=*surf_it;
		voxelSprite->LOD[surf_number*16]=0;

		for(int lod=2;lod<=slices*2;lod*=2){
		
			voxelSprite->LOD[surf_number*16+level]=surf->tris.size();
			level++;
			for(int t=0;t<=surf->no_tris*4;t+=(lod*4)){
				surf->tris.push_back(surf->tris[t]);
				surf->tris.push_back(surf->tris[t+1]);
				surf->tris.push_back(surf->tris[t+2]);
				surf->tris.push_back(surf->tris[t+3]);
			}

		}
		if(surf->vbo_enabled==true){
			surf->reset_vbo=1|4|8;
			surf->UpdateVBO();
			glBindBuffer(GL_ARRAY_BUFFER,surf->vbo_id[2]);
			glBufferData(GL_ARRAY_BUFFER,(surf->no_verts*3*4),&surf->vert_tex_coords1[0],GL_STATIC_DRAW);

			glBindBuffer(GL_ELEMENT_ARRAY_BUFFER,surf->vbo_id[5]);
			glBufferData(GL_ELEMENT_ARRAY_BUFFER,surf->tris.size()*2,&surf->tris[0],GL_STATIC_DRAW);

		}
		surf_number++;
	}

	voxelSprite->cull_radius=-sqrt(3);

	return voxelSprite;

}


void VoxelSprite::VoxelSpriteMaterial(Material* mat){

	material[no_mats]=mat;
	no_mats++;
}



void VoxelSprite::Render(){

	glMatrixMode(GL_MODELVIEW);
	glDisable(GL_CULL_FACE);

	glPushMatrix();
	glMultMatrixf(&mat.grid[0][0]);

	glEnableClientState(GL_NORMAL_ARRAY);

	float ambient[]={Global::ambient_red,Global::ambient_green,Global::ambient_blue};
	glLightModelfv(GL_LIGHT_MODEL_AMBIENT,ambient);

	//float no_mat[]={0.0,0.0};
	float mat_ambient[]={brush.red,brush.green,brush.blue,brush.alpha};
	float mat_diffuse[]={brush.red,brush.green,brush.blue,brush.alpha};
	float mat_specular[]={brush.shine,brush.shine,brush.shine,brush.shine};
	float mat_shininess[]={100.0}; // upto 128

	glMaterialfv(GL_FRONT_AND_BACK,GL_AMBIENT,mat_ambient);
	glMaterialfv(GL_FRONT_AND_BACK,GL_DIFFUSE,mat_diffuse);
	glMaterialfv(GL_FRONT_AND_BACK,GL_SPECULAR,mat_specular);
	glMaterialfv(GL_FRONT_AND_BACK,GL_SHININESS,mat_shininess);


	//Matrix new_mat;
	float mod_mat[16];
	glGetFloatv(GL_MODELVIEW_MATRIX,&mod_mat[0]);//new_mat.grid[0][0]);

	float x=mod_mat[2];//new_mat.grid[0][0];
	float y=mod_mat[6];//new_mat.grid[1][1];
	float z=mod_mat[10];//new_mat.grid[2][2];

	float d=-mod_mat[14];
	int lod=16*d/Global::camera_in_use->range_far;

	list<Surface*>::iterator surf_it;
	surf_it=surf_list.begin();

	int surf_number=0;

	if(fabs(x)>=fabs(y)&&fabs(x)>=fabs(z)) { // viewpoint primarily along x-axis
        }
        else if(fabs(y)>=fabs(z)) { // viewpoint primarily along y-axis
		surf_number=1;
		surf_it++;
        }
        else { // viewpoint primarily along z-axis
		surf_number=2;
		surf_it++;
		surf_it++;
        }

	Surface& surf=**surf_it;


	for(int ix=0;ix<no_mats;ix++){
		glActiveTexture(GL_TEXTURE0+ix);
		glClientActiveTexture(GL_TEXTURE0+ix);

		glEnable(GL_TEXTURE_3D);
		glBindTexture(GL_TEXTURE_3D, material[ix]->texture); 

		glTexParameteri(GL_TEXTURE_3D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
		glTexParameteri(GL_TEXTURE_3D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);
		glTexParameteri(GL_TEXTURE_3D,GL_TEXTURE_WRAP_S,GL_REPEAT);
		glTexParameteri(GL_TEXTURE_3D,GL_TEXTURE_WRAP_T,GL_REPEAT);

		glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_REPLACE);
		glEnableClientState(GL_TEXTURE_COORD_ARRAY);

		if(material[ix]->flags&4){
			glEnable(GL_ALPHA_TEST);
		}else{
			glDisable(GL_ALPHA_TEST);
		}
		// mipmapping texture flag

		if(material[ix]->flags&8){
			glTexParameteri(GL_TEXTURE_3D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
			glTexParameteri(GL_TEXTURE_3D,GL_TEXTURE_MIN_FILTER,GL_LINEAR_MIPMAP_LINEAR);
		}else{
			glTexParameteri(GL_TEXTURE_3D,GL_TEXTURE_MAG_FILTER,GL_NEAREST);
			glTexParameteri(GL_TEXTURE_3D,GL_TEXTURE_MIN_FILTER,GL_NEAREST);
		}

		switch(material[ix]->blend){
			case 0: glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_REPLACE);
			break;
			case 1: glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_DECAL);
			break;
			case 2: glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE);
			//case 2 glTexEnvf(GL_TEXTURE_ENV,GL_COMBINE_RGB_EXT,GL_MODULATE);
			break;
			case 3: glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_ADD);
			break;
			case 4:
				glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE_EXT); 
				glTexEnvf(GL_TEXTURE_ENV, GL_COMBINE_RGB_EXT, GL_DOT3_RGB_EXT); 
				break;
			case 5:
				glTexEnvi(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_COMBINE);
				glTexEnvi(GL_TEXTURE_ENV,GL_COMBINE_RGB,GL_MODULATE);
				glTexEnvi(GL_TEXTURE_ENV,GL_RGB_SCALE,2.0);
				break;
			default: glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE);
		}


		if(surf.vbo_enabled==true){
			glBindBuffer(GL_ARRAY_BUFFER,surf.vbo_id[2]);
			glTexCoordPointer(3,GL_FLOAT,0,NULL);
		}else{
			glTexCoordPointer(3,GL_FLOAT,0,&surf.vert_tex_coords1[0]);
		}

	}




	if(surf.vbo_enabled==true){
		glBindBuffer(GL_ARRAY_BUFFER,surf.vbo_id[0]);
		glVertexPointer(3,GL_FLOAT,0,NULL);
		glBindBuffer(GL_ARRAY_BUFFER,surf.vbo_id[3]);
		glNormalPointer(GL_FLOAT,0,NULL);
		glBindBuffer(GL_ARRAY_BUFFER,surf.vbo_id[4]);
		glColorPointer(4,GL_FLOAT,0,NULL);

		glBindBuffer(GL_ELEMENT_ARRAY_BUFFER,surf.vbo_id[5]);
		#ifdef __x86_64__
		glDrawElements(GL_QUADS,surf.no_tris*4/(1<<lod),GL_UNSIGNED_SHORT, (GLvoid *)(long long)(LOD[surf_number*16+lod]*2));
		#else
		glDrawElements(GL_QUADS,surf.no_tris*4/(1<<lod),GL_UNSIGNED_SHORT, (GLvoid *)(LOD[surf_number*16+lod]*2));
		#endif

	}else{

		glBindBuffer(GL_ARRAY_BUFFER,0); // reset - necessary for when non-vbo surf follows vbo surf
		glBindBuffer(GL_ELEMENT_ARRAY_BUFFER,0);

		glVertexPointer(3,GL_FLOAT,0,&surf.vert_coords[0]);
		glNormalPointer(GL_FLOAT,0,&surf.vert_norm[0]);
		glColorPointer(4,GL_FLOAT,0,&surf.vert_col[0]);
		glDrawElements(GL_QUADS,surf.no_tris*4/(1<<lod),GL_UNSIGNED_SHORT,&surf.tris[LOD[surf_number*16+lod]]);
	}

	glPopMatrix();

	for(int ix=0;ix<no_mats;ix++){

		glActiveTexture(GL_TEXTURE0+ix);
		glClientActiveTexture(GL_TEXTURE0+ix);

		// reset texture matrix
		glMatrixMode(GL_TEXTURE);
		glLoadIdentity();
	
		glDisable(GL_TEXTURE_3D);
	}
}


