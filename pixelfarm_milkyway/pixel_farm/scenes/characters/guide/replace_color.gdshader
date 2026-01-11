shader_type canvas_item;

uniform vec4 original_0 : source_color; // first color: the original_0 is the purple outline of the player
uniform vec4 original_1 : source_color; // second color: this is the more lavender color in the middle of the player
uniform vec4 original_2 : source_color; 
uniform vec4 original_3 : source_color;
uniform vec4 original_4 : source_color;


uniform vec4 replace_0 : source_color; // 3rd parameter: replace original_0 with a new color
uniform vec4 replace_1 : source_color; // 4th parameter: same as above 
uniform vec4 replace_2 : source_color; 
uniform vec4 replace_3 : source_color; 
uniform vec4 replace_4 : source_color; 


// if you want to add more replacement colors (like change the yellow fur tone too of the sprite), just use these ^ (like make more of them) and you can change them in the Material -> Shader Parameters 

const float precision = 0.1; 

vec4 replace_color(vec4 color) {
	vec4 original_colors[5] = vec4[5](original_0, original_1, original_2, original_3, original_4); 
	vec4 replace_colors[5] = vec4[5](replace_0, replace_1, replace_2, replace_3, replace_4); // array to hold the replace colors
	
	for (int i = 0; i < 5; i++){ 
		if(distance(color, original_colors[i]) <= precision) {
			color = replace_colors[i]; 
		}
	}
	
	return color; 
}

//void vertex() {
	//// Called for every vertex the material is visible on.
//}

void fragment() {
	// Called for every pixel the material is visible on.
	// we want to make this sprite diff from our player, so we have to change the colors of this one
	//vec4 color = texture(TEXTURE, UV); 
	

	
	COLOR = replace_color(texture(TEXTURE, UV)); 
}

//void light() { // this part is not needed
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
