#version 330 core

layout(std140) uniform camera
{
    mat4 projection;
    mat4 view;
    mat4 pvm;
    mat4 ortho;
    vec4 position;
};


vec2 hash2(vec2 v)
{
    vec2 rand = vec2(0, 0);
    vec3 v3 = fract(vec3(v.xyx) * vec3(.1031, .1030, .0973));
    v3 += dot(v3, v3.yzx+33.33);
    return fract((v3.xx+v3.yz)*v3.zy);
}

float worley_noise(vec2 v) {
    vec2 cell = floor(v);
    //vec2 st = gl_FragCoord.xy/u_resolution.xy;
    
    float dist = 10;
    for (int y = -1; y <= 1; y++) {
        for (int x = -1; x <= 1; x++) {
            vec2 offset = vec2(x, y);
            dist = min(dist, distance(fract(v), hash2(cell + offset) + offset));
        }
    }
    
    return dist;
}

float noiseOctave(vec2 v, int num)
{
    float sum = 0;
	float weight = 1.0;
	float scale = 2.0;
	for(int i =0; i<num; i++){
		weight *= 0.5;
		sum += weight * worley_noise(scale * v + 0.2 * scale);
		scale *= 1.5;
	}
	return sum;
}

float height(vec2 v)
{
    float h = 0;
	// Your implementation starts here
    h = 0.75 * noiseOctave(v, 5);
    if(h < 0)
        h *= .5;
	// Your implementation ends here
    return h * 2.;
}

uniform mat4 model;		/*model matrix*/

/*input variables*/
layout(location = 0) in vec4 pos;

/*output variables*/
out vec3 vtx_pos;		////vertex position in the world space

void main()
{
    vtx_pos = pos.xyz;
    vtx_pos.z = height(pos.xy);

    gl_Position = pvm * model * vec4(vtx_pos, 1.);
}