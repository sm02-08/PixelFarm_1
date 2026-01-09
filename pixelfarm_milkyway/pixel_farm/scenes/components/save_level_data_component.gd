class_name SaveLevelDataComponent
extends Node

var level_scene_name: String 
var save_game_data_path: String = "user://game_data/" # we're using the user path here. go to https://docs.godotengine.org/en/stable/tutorials/io/data_paths.html to know which file path this will be in
# oh btw according to the docs, to store persistent data files like the player's save or settings, use user:// instead of res:// as the prefix because when the game's running, the project's file system will likely be read-only 
# "The user:// prefix points to a different directory on the user's device. Unlike res://, the directory pointed at by user:// is created automatically and guaranteed to be writable to, even in an exported project."
# A LOT OF COMMENTS BUT easy access to get to the game data would be: Windows+R, %APPDATA%\Godot and Enter
var save_file_name: String = "save_%s_game_data.tres" # there's a format operator in here
var game_data_resource: SaveGameDataResource 

# for ease of searching when i inevitably ctrl+f this part later, i'll spam some keywords: win+r win + r windows + r window + r wins + r wins+r app_userdata AppData 

# and when testing, make sure to go to C:\Users\shell\AppData\Roaming\Godot\app_userdata\pixel_farm\game_data and delete the .tres file. deleting it will allow the game to start fresh, while not deleting it saves your farming progress 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("save_level_data_component")
	level_scene_name = get_parent().name
	# when the ready method is called, we'll get the name "TestSceneCropfieldsTilledDirt" from the parent. this will allow us to use the scene level name to be part of the name for the data file 
	
# to continue, we now need a new resource to act as a container and contain all the small resources from each of the nodes which contain a save data component 
# check save_game_data_resource.gd ^ to see how this is done 

func save_node_data() -> void: 
	var nodes = get_tree().get_nodes_in_group("save_data_component") # pass in save data component string
	# cont. from save_game() right below (the explanation below applies for this whole function btw not just the line above) 
	# from the scene tree, we get all of the nodes which have the group "save_data_component" then we bring those nodes into a collection, then create a new instance of the save game data resource, which is an array of resources. 
	# we then go into hte save data component method, and get hte resource from the save data component. go to save_data_component.gd to see a continuation of the explanation
	
	game_data_resource = SaveGameDataResource.new() 
	
	if nodes != null: 
		for node: SaveDataComponent in nodes: 
			if node is SaveDataComponent: 
				var save_data_resource: NodeDataResource = node._save_data() 
				var save_final_resource = save_data_resource.duplicate() 
				game_data_resource.save_data_nodes.append(save_final_resource)
				
				
func save_game() -> void: 
	if !DirAccess.dir_exists_absolute(save_game_data_path): # check if the game directory exists 
		DirAccess.make_dir_absolute(save_game_data_path) # if a director doesn't exist, create a directory for the game 
		
		#explanation: continued from save_game_manager.gd: 
		# using directory access, we check if the directory exists first, and then the game path will be the user path (which is defined in godot). 
	
	var level_save_file_name: String = save_file_name % level_scene_name 
	# it'll use the format from the 4 variables defined at the very top 
	# cont. explanation: then, we create the level save file name, which is save_levelname_game_data. then we go and save the node data itself as shown below 
	# scroll up for the next part of the explanation, to save_node_data() 
	
	save_node_data() 
	
	var result: int = ResourceSaver.save(game_data_resource, save_game_data_path + level_save_file_name) # we save the game data resource which is the array of all the resources that now have properties set 
	print("Save result: ", result) # and the result is 0 so it's successfully saved 
	
func load_game() -> void: # we build up the level save file name
	var level_save_file_name: String = save_file_name % level_scene_name 
	var save_game_path: String = save_game_data_path + level_save_file_name 
	
	if !FileAccess.file_exists(save_game_path): # first check if the file exists
		return 
	
	game_data_resource = ResourceLoader.load(save_game_path) # if the file exists, we have some information in there to help us load those resources again 
	# game data resource is the array collection of all the resources 
	
	if game_data_resource == null: 
		return 
		
	var root_node: Window = get_tree().root 
	# then we get the tree's root node and start to go through the resources inside the game data resource collection, in the forloop below
	
	for resource in game_data_resource.save_data_nodes: 
		if resource is Resource: 
			if resource is NodeDataResource: 
				resource._load_data(root_node) # then, we can call the load_data function from scene_data_resource.gd. go to tilemap_layer_data_resource.gd now
				
# now the script is complete

#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
