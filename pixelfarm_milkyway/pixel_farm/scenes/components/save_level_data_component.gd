class_name SaveLevelDataComponent
extends Node

var level_scene_name: String 
var save_game_data_path: String = "user://game_data/"
var save_file_name: String = "save_%s_game_data.tres" # there's a format operator in here
var game_data_resource: SaveGameDataResource 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("save_level_data_component")
	level_scene_name = get_parent().name
	# when the ready method is called, we'll get the name "TestSceneCropfieldsTilledDirt" from the parent. this will allow us to use the scene level name to be part of the name for the data file 
	
# to continue, we now need a new resource to act as a container and contain all the small resources from each of the nodes which contain a save data component 
# check save_game_data_resource.gd ^ to see how this is done 

func save_node_data() -> void: 
	var nodes = get_tree().get_nodes_in_group("save_data_component") # pass in save data component string
	
	game_data_resource = SaveGameDataResource.new() 
	
	if nodes != null: 
		for node: SaveDataComponent in nodes: 
			if node is SaveDataComponent: 
				var save_data_resource: NodeDataResource = node.save_data() 
				var save_final_resource = save_data_resource.duplicate() 
				game_data_resource.save_data_nodes.append(save_final_resource)
				
				
func save_game() -> void: 
	if !DirAccess.dir_exists_absolute(save_game_data_path): # check if the game directory exists 
		DirAccess.make_dir_absolute(save_game_data_path) # if a director doesn't exist, create a directory for the game 
	
	var level_save_file_name: String = save_file_name % level_scene_name 
	# it'll use the format from the 4 variables defined at the very top 
	
	save_node_data() 
	
	var result: int = ResourceSaver.save(game_data_resource, save_game_data_path + level_save_file_name)
	print("Save result: ", result)
	
func load_game() -> void: 
	var level_save_file_name: String = save_file_name % level_scene_name 
	var save_game_path: String = save_game_data_path + level_save_file_name 
	
	if !FileAccess.file_exists(save_game_path): 
		return 
	
	game_data_resource = ResourceLoader.load(save_game_path) 
	
	if game_data_resource == null: 
		return 
		
	var root_node: Window = get_tree().root 
	
	for resource in game_data_resource.save_data_nodes: 
		if resource is Resource: 
			if resource is NodeDataResource: 
				resource._load_data(root_node) 
				
# now the script is complete

#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
