#include "Common.h"
#include "OpenGLCommon.h"
#include "OpenGLMarkerObjects.h"
#include "OpenGLBgEffect.h"
#include "OpenGLMesh.h"
#include "OpenGLViewer.h"
#include "OpenGLWindow.h"
#include "TinyObjLoader.h"
#include "OpenGLSkybox.h"
#include <algorithm>
#include <iostream>
#include <random>
#include <unordered_set>
#include <vector>
#include <string>

#ifndef __Main_cpp__
#define __Main_cpp__

#ifdef __APPLE__
#define CLOCKS_PER_SEC 100000
#endif

class MyDriver : public OpenGLViewer
{
    std::vector<OpenGLTriangleMesh *> mesh_object_array;
    OpenGLBgEffect *bgEffect = nullptr;
    OpenGLSkybox *skybox = nullptr;
    clock_t startTime;

public:
    virtual void Initialize()
    {
        draw_axes = false;
        startTime = clock();
        OpenGLViewer::Initialize();
    }

    virtual void Initialize_Data()
    {
        //// Load all the shaders you need for the scene 
        //// In the function call of Add_Shader_From_File(), we specify three names: 
        //// (1) vertex shader file name
        //// (2) fragment shader file name
        //// (3) shader name used in the shader library
        //// When we bind a shader to an object, we implement it as follows:
        //// object->Add_Shader_Program(OpenGLShaderLibrary::Get_Shader("shader_name"));
        //// Here "shader_name" needs to be one of the shader names you created previously with Add_Shader_From_File()

        OpenGLShaderLibrary::Instance()->Add_Shader_From_File("shaders/basic.vert", "shaders/basic.frag", "basic");
        OpenGLShaderLibrary::Instance()->Add_Shader_From_File("shaders/basic.vert", "shaders/environment.frag", "environment");
        OpenGLShaderLibrary::Instance()->Add_Shader_From_File("shaders/stars.vert", "shaders/stars.frag", "stars");
        OpenGLShaderLibrary::Instance()->Add_Shader_From_File("shaders/basic.vert", "shaders/alphablend.frag", "blend");
        OpenGLShaderLibrary::Instance()->Add_Shader_From_File("shaders/billboard.vert", "shaders/alphablend.frag", "billboard");
        //river
        OpenGLShaderLibrary::Instance()->Add_Shader_From_File("shaders/terrain.vert", "shaders/terrain.frag", "river");
        //mountain
        OpenGLShaderLibrary::Instance()->Add_Shader_From_File("shaders/terrain2.vert", "shaders/terrain2.frag", "mountain");
        OpenGLShaderLibrary::Instance()->Add_Shader_From_File("shaders/skybox.vert", "shaders/skybox.frag", "skybox");

        //// Load all the textures you need for the scene
        //// In the function call of Add_Shader_From_File(), we specify two names:
        //// (1) the texture's file name
        //// (2) the texture used in the texture library
        //// When we bind a texture to an object, we implement it as follows:
        //// object->Add_Texture("tex_sampler", OpenGLTextureLibrary::Get_Texture("tex_name"));
        //// Here "tex_sampler" is the name of the texture sampler2D you used in your shader, and
        //// "tex_name" needs to be one of the texture names you created previously with Add_Texture_From_File()

        OpenGLTextureLibrary::Instance()->Add_Texture_From_File("tex/earth_color.png", "sphere_color");
        OpenGLTextureLibrary::Instance()->Add_Texture_From_File("tex/earth_normal.png", "sphere_normal");
        OpenGLTextureLibrary::Instance()->Add_Texture_From_File("tex/bunny_color.jpg", "bunny_color");
        OpenGLTextureLibrary::Instance()->Add_Texture_From_File("tex/bunny_normal.png", "bunny_normal");
        OpenGLTextureLibrary::Instance()->Add_Texture_From_File("tex/window.png", "window_color");
        OpenGLTextureLibrary::Instance()->Add_Texture_From_File("tex/buzz_color.png", "buzz_color");
        OpenGLTextureLibrary::Instance()->Add_Texture_From_File("tex/star.png", "star_color");

        //// Add all the lights you need for the scene (no more than 4 lights)
        //// The four parameters are position, ambient, diffuse, and specular.
        //// The lights you declared here will be synchronized to all shaders in uniform lights.
        //// You may access these lights using lt[0].pos, lt[1].amb, lt[1].dif, etc.
        //// You can also create your own lights by directly declaring them in a shader without using Add_Light().
        //// Here we declared three default lights for you. Feel free to add/delete/change them at your will.

        opengl_window->Add_Light(Vector3f(3, 1, 3), Vector3f(0.1, 0.1, 0.1), Vector3f(1, 1, 1), Vector3f(0.5, 0.5, 0.5)); 
        opengl_window->Add_Light(Vector3f(0, 0, -5), Vector3f(0.1, 0.1, 0.1), Vector3f(0.9, 0.9, 0.9), Vector3f(0.5, 0.5, 0.5));
        opengl_window->Add_Light(Vector3f(-5, 1, 3), Vector3f(0.1, 0.1, 0.1), Vector3f(0.9, 0.9, 0.9), Vector3f(0.5, 0.5, 0.5));

        //// Add the background / environment
        //// Here we provide you with four default options to create the background of your scene:
        //// (1) Gradient color (like A1 and A2; if you want a simple background, use this one)
        //// (2) Programmable Canvas (like A7 and A8; if you consider implementing noise or particles for the background, use this one)
        //// (3) Sky box (cubemap; if you want to load six background images for a skybox, use this one)
        //// (4) Sky sphere (if you want to implement a sky sphere, enlarge the size of the sphere to make it colver the entire scene and update its shaders for texture colors)
        //// By default, Option (2) (Buzz stars) is turned on, and all the other three are commented out.
        
        // Implement sky box
        
        {
            // from https://www.humus.name/index.php?page=Cubemap&item=Powerlines
            const std::vector<std::string> cubemap_files{
                "cubemap/posx.jpg",     //// + X
                "cubemap/negx.jpg",     //// - X
                "cubemap/posy.jpg",     //// + Y
                "cubemap/negy.jpg",     //// - Y
                "cubemap/posz.jpg",     //// + Z
                "cubemap/negz.jpg",     //// - Z 
            };
            OpenGLTextureLibrary::Instance()->Add_CubeMap_From_Files(cubemap_files, "cube_map");

            skybox = Add_Interactive_Object<OpenGLSkybox>();
            skybox->Add_Shader_Program(OpenGLShaderLibrary::Get_Shader("skybox"));
            skybox->Initialize();
        }


        // Add Stanford bunny to scene
        
        {
            //// create object by reading an obj mesh
            auto bunny = Add_Obj_Mesh_Object("obj/bunny.obj");

            //// set object's transform
            Matrix4f s, t;
            s << 0.3, 0, 0, 0,
                0, 0.3, 0, 0,
                0, 0, 0.3, 0,
                0, 0, 0, 1;
            t << 1, 0, 0, 4,
                 0, 1, 0, -18,
                 0, 0, 1, -5,
                 0, 0, 0, 1,
            bunny->Set_Model_Matrix(s * t);

            //// set object's material
            bunny->Set_Ka(Vector3f(0.1, 0.1, 0.1));
            bunny->Set_Kd(Vector3f(0.7, 0.7, 0.7));
            bunny->Set_Ks(Vector3f(2, 2, 2));
            bunny->Set_Shininess(128);

            //// bind texture to object
            bunny->Add_Texture("tex_color", OpenGLTextureLibrary::Get_Texture("bunny_color"));
            bunny->Add_Texture("tex_normal", OpenGLTextureLibrary::Get_Texture("bunny_normal"));

            //// bind shader to object
            bunny->Add_Shader_Program(OpenGLShaderLibrary::Get_Shader("basic"));
        }

        // Add river generated by Worley noise
        {
            //// create object by reading an obj mesh
            auto terrain1 = Add_Obj_Mesh_Object("obj/plane.obj");

            //// set object's transform
            Matrix4f r, s, t;
            r << 1, 0, 0, 0,
                0, 0, 1, 0,
                0, -1, 0, 0,
                0, 0, 0, 1;
            s << 0.7, 0, 0, 0,
                0, 0.6, 0, 0,
                0, 0, 2, 0,
                0, 0, 0, 1;
            t << 1, 0, 0, 4.7,
                 0, 1, 0, -6.5,
                 0, 0, 1, 0,
                 0, 0, 0, 1,
            terrain1->Set_Model_Matrix(t * s * r);

            //// set object's material
            terrain1->Set_Ka(Vector3f(0.1f, 0.1f, 0.1f));
            terrain1->Set_Kd(Vector3f(0.7f, 0.7f, 0.7f));
            terrain1->Set_Ks(Vector3f(1, 1, 1));
            terrain1->Set_Shininess(128.f);

            //// bind shader to object (we do not bind texture for this object because we create noise for texture)
            terrain1->Add_Shader_Program(OpenGLShaderLibrary::Get_Shader("river"));
            terrain1->Add_Shader_Program(OpenGLShaderLibrary::Get_Shader(""));
        }

        // Now add two planes generated by Perlin noise
        {
            //// create object by reading an obj mesh
            auto terrain2 = Add_Obj_Mesh_Object("obj/plane.obj");

            //// set object's transform
            Matrix4f r, s, t;
            r << 1, 0, 0, 0,
                0, 0, 1, 0,
                0, -1, 0, 0,
                0, 0, 0, 1;
            s << 2, 0, 0, 0,
                0, 2, 0, 0,
                0, 0, 2, 0,
                0, 0, 0, 1;
            t << 1, 0, 0, -4.8,
                 0, 1, 0, -6,
                 0, 0, 1, 0,
                 0, 0, 0, 1,
            terrain2->Set_Model_Matrix(t * s * r);

            //// set object's material
            terrain2->Set_Ka(Vector3f(0.1f, 0.1f, 0.1f));
            terrain2->Set_Kd(Vector3f(0.7f, 0.7f, 0.7f));
            terrain2->Set_Ks(Vector3f(1, 1, 1));
            terrain2->Set_Shininess(100.f);

            //// bind shader to object (we do not bind texture for this object because we create noise for texture)
            terrain2->Add_Shader_Program(OpenGLShaderLibrary::Get_Shader("mountain"));
        }

        {
            //// create object by reading an obj mesh
            auto terrain3 = Add_Obj_Mesh_Object("obj/plane.obj");

            //// set object's transform
            Matrix4f r, s, t;
            r << 1, 0, 0, 0,
                0, 0, 1, 0,
                0, -1, 0, 0,
                0, 0, 0, 1;
            s << 2, 0, 0, 0,
                0, 2, 0, 0,
                0, 0, 2, 0,
                0, 0, 0, 1;
            t << 1, 0, 0, 7.5,
                 0, 1, 0, -6,
                 0, 0, 1, 0,
                 0, 0, 0, 1,
            terrain3->Set_Model_Matrix(t * s * r);

            //// set object's material
            terrain3->Set_Ka(Vector3f(0.1f, 0.1f, 0.1f));
            terrain3->Set_Kd(Vector3f(0.7f, 0.7f, 0.7f));
            terrain3->Set_Ks(Vector3f(1, 1, 1));
            terrain3->Set_Shininess(100.f);

            //// bind shader to object (we do not bind texture for this object because we create noise for texture)
            terrain3->Add_Shader_Program(OpenGLShaderLibrary::Get_Shader("mountain"));
        }


        //// This for-loop updates the rendering model for each object on the list
        for (auto &mesh_obj : mesh_object_array){
            Set_Polygon_Mode(mesh_obj, PolygonMode::Fill);
            Set_Shading_Mode(mesh_obj, ShadingMode::TexAlpha);
            mesh_obj->Set_Data_Refreshed();
            mesh_obj->Initialize();
        }
        Toggle_Play();
    }

    //// add mesh object by reading an .obj file
    OpenGLTriangleMesh *Add_Obj_Mesh_Object(std::string obj_file_name)
    {
        auto mesh_obj = Add_Interactive_Object<OpenGLTriangleMesh>();
        Array<std::shared_ptr<TriangleMesh<3>>> meshes;
        // Obj::Read_From_Obj_File(obj_file_name, meshes);
        Obj::Read_From_Obj_File_Discrete_Triangles(obj_file_name, meshes);

        mesh_obj->mesh = *meshes[0];
        std::cout << "load tri_mesh from obj file, #vtx: " << mesh_obj->mesh.Vertices().size() << ", #ele: " << mesh_obj->mesh.Elements().size() << std::endl;

        mesh_object_array.push_back(mesh_obj);
        return mesh_obj;
    }

    //// add mesh object by reading an array of vertices and an array of elements
    OpenGLTriangleMesh* Add_Tri_Mesh_Object(const std::vector<Vector3>& vertices, const std::vector<Vector3i>& elements)
    {
        auto obj = Add_Interactive_Object<OpenGLTriangleMesh>();
        mesh_object_array.push_back(obj);
        // set up vertices and elements
        obj->mesh.Vertices() = vertices;
        obj->mesh.Elements() = elements;

        return obj;
    }

    //// Go to next frame
    virtual void Toggle_Next_Frame()
    {
        for (auto &mesh_obj : mesh_object_array)
            mesh_obj->setTime(GLfloat(clock() - startTime) / CLOCKS_PER_SEC);

        if (bgEffect){
            bgEffect->setResolution((float)Win_Width(), (float)Win_Height());
            bgEffect->setTime(GLfloat(clock() - startTime) / CLOCKS_PER_SEC);
            bgEffect->setFrame(frame++);
        }

        if (skybox){
            skybox->setTime(GLfloat(clock() - startTime) / CLOCKS_PER_SEC);
        }   

        OpenGLViewer::Toggle_Next_Frame();
    }

    virtual void Run()
    {
        OpenGLViewer::Run();
    }
};

int main(int argc, char *argv[])
{
    MyDriver driver;
    driver.Initialize();
    driver.Run();
}

#endif