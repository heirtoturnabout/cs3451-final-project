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

	// Your implementation starts here

	// example hash function
    rand = 50.0 * 1.05 * fract(v * 0.3183099 + vec2(0.71, 0.113));
    rand = -1.0 + 2 * 1.05 * fract(rand.x * rand.y * (rand.x + rand.y) * rand);
	// Your implementation ends here
    rand = sin(sin(sin(rand)));
    return rand;
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
	// Your implementation starts here
    for(int i = 0; i < num; i++)
    {
        sum += pow(2, -1 * i) * worley_noise(pow(2, i) * v);
    }
	// Your implementation ends here
    return sum;
}

float height(vec2 v)
{
    float h = 0;
	// Your implementation starts here
    h = 0.75 * noiseOctave(v, 10);
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