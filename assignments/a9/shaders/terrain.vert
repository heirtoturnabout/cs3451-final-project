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

    return rand;
}


float perlin_noise(vec2 v)
{
	// Your implementation starts here

    float noise = 0;
    vec2 i = floor(v);
    vec2 f = fract(v);
    vec2 m = f * f * (3.0 - 2.0 * f);

    noise = mix(mix(dot(hash2(i + vec2(0.0, 0.0)), f - vec2(0.0, 0.0)), dot(hash2(i + vec2(1.0, 0.0)), f - vec2(1.0, 0.0)), m.x), mix(dot(hash2(i + vec2(0.0, 1.0)), f - vec2(0.0, 1.0)), dot(hash2(i + vec2(1.0, 1.0)), f - vec2(1.0, 1.0)), m.x), m.y);
	// Your implementation ends here
    return noise;
} 

float simplex_noise(vec2 v) {
    const float K1 = 0.366025404; // (sqrt(3)-1)/2;
    const float K2 = 0.211324865; // (3-sqrt(3))/6;

	vec2  i = floor(v + (v.x + v.y) * K1);
    vec2  a = v - i + (i.x + i.y) * K2;
    float m = step(a.y,a.x); 
    vec2  o = vec2(m,1.0-m);
    vec2  b = a - o + K2;
	vec2  c = a - 1.0 + 2.0*K2;
    vec3  h = max( 0.5-vec3(dot(a,a), dot(b,b), dot(c,c) ), 0.0 );
	vec3  n = h * h * h * h * vec3( dot(a,hash2(i+0.0)), dot(b,hash2(i+o)), dot(c,hash2(i+1.0)));
    return dot( n, vec3(70.0) );
}

float noiseOctave(vec2 v, int num)
{
    float sum = 0;
	// Your implementation starts here
    for(int i = 0; i < num; i++)
    {
        sum += pow(2, -1 * i) * simplex_noise(pow(2, i) * v);
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