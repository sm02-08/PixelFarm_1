shader_type canvas_item;

// the shader editor language mirrors C# and C++
// we use // for single line comments and /* */ for multi-line comments 

uniform float shake_intensity = 1.0; // this is the shake intensity. if set to 0, shaking stops
uniform float shake_speed = 20.0; 
// ^ these are also seen in the tree_shade.gdshader -> select SmallTree -> Material -> shader parameters
// -> shake intensity & shake speed 

void vertex() {
	vec2 shake = vec2(0.0); // default shake speed and with vector 2
	
	if(VERTEX.y < 0.0){ // the sprite sits above the y-axis and as we move up, the y-values
		// continue going negative. so check if the pixels are less than 0 so we can apply shaking
		// from the top down 
		shake.x = sin(TIME * shake_speed + VERTEX.y) * shake_intensity; 
	}
	VERTEX.xy += shake; // apply shake intensity to vertex
}
// now, the tree's shaking as seen in the animation 
