#version 330 core

/*default camera matrices. do not modify.*/
layout(std140) uniform camera
{
    mat4 projection;	/*camera's projection matrix*/
    mat4 view;			/*camera's view matrix*/
    mat4 pvm;			/*camera's projection*view*model matrix*/
    mat4 ortho;			/*camera's ortho projection matrix*/
    vec4 position;		/*camera's position in world space*/
};

/* set light ubo. do not modify.*/
struct light
{
	ivec4 att; 
	vec4 pos; // position
	vec4 dir;
	vec4 amb; // ambient intensity
	vec4 dif; // diffuse intensity
	vec4 spec; // specular intensity
	vec4 atten;
	vec4 r;
};
layout(std140) uniform lights
{
	vec4 amb;
	ivec4 lt_att; // lt_att[0] = number of lights
	light lt[4];
};

const light lightUno = light(ivec4(0.0), /*position*/ vec4(-3, 1, 3, 1.f), vec4(0.0), 
                                /*amb*/ vec4(0.05, 0.02, 0.03, 1.f), 
                                /*dif*/ vec4(0.4, 0.2, 0.3, 1.f), 
                                /*spec*/ vec4(0.4, 0.2, 0.3, 1.f), vec4(0.0), vec4(0.0));
vec4 posUno = lightUno.pos;

/*input variables*/
in vec3 vtx_normal; // vtx normal in world space
in vec3 vtx_position; // vtx position in world space
in vec3 vtx_model_position; // vtx position in model space
in vec4 vtx_color;
in vec2 vtx_uv;
in vec3 vtx_tangent;

uniform vec3 ka;            /* object material ambient */
uniform vec3 kd;            /* object material diffuse */
uniform vec3 ks;            /* object material specular */
uniform float shininess;    /* object material shininess */

uniform sampler2D tex_color;   /* texture sampler for color */
uniform sampler2D tex_normal;   /* texture sampler for normal vector */

/*output variables*/
out vec4 frag_color;

vec4 shading_texture_with_phong(light li, vec3 e, vec3 p, vec3 s, vec3 n)
{
    vec3 l = normalize(s);
    vec3 La = vec3(ka.x * li.amb.x, ka.y * li.amb.y, ka.z * li.amb.z);
    float dot = (l.x * n.x) + (l.y * n.y) + (l.z * n.z);
    vec3 Ld1 = vec3((kd.x*li.dif.x*max(0,dot)), (kd.y*li.dif.y*max(0,dot)), 
       (kd.z*li.dif.z*max(0,dot)));
    vec3 Ld2 = vec3(La.x + Ld1.x, La.y + Ld1.y, La.z + Ld1.z);

    vec3 v = normalize(e - p);
    vec3 r = normalize(reflect(vec3(-1.,-1.,-1.), n));
    float dot1 = (v.x * r.x) + (v.y * r.y) + (v.z * r.z);
    vec3 Lp1 = vec3(ks.x*li.spec.x*pow(max(0,dot1),shininess), ks.y*li.spec.y*pow(max(0,dot1),shininess),
        ks.z*li.spec.z*pow(max(0,dot1),shininess));
    vec3 Lp2 = vec3(Ld2.x + Lp1.x, Ld2.y + Lp1.y, Ld2.z + Lp1.z);
    return vec4(Lp2.x,Lp2.y,Lp2.z,1.f);
}

vec3 read_normal_texture()
{
    vec3 normal = texture(tex_normal, vtx_uv).rgb;
    normal = normalize(normal * 2.0 - 1.0);
    return normal;
}

void main()
{
    vec3 e = position.xyz;              //// eye position
    vec3 p = vtx_position;              //// surface position
    vec3 N = normalize(vtx_normal);     //// normal vector
    vec3 T = normalize(vtx_tangent);    //// tangent vector

    vec3 texture_normal = read_normal_texture();
    vec3 texture_color = texture(tex_color, vtx_uv).rgb;

    frag_color = vec4(texture_color.rgb, 1.0);
    // frag_color = shading_texture_with_phong(lightUno, e, p, posUno, N);
}