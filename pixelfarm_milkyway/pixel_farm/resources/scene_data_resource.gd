class_name SceneDataResource 
extends NodeDataResource 

@export var node_name: String 
@export var scene_file_path: String 

func _save_data(node: Node2D) -> void: 
	super._save_data(node) # pass in base class from node_data_resource.gd 
	
	node_name = node.name
	scene_file_path = node.scene_file_path 
	
func _load_data(window: Window) -> void: 
	var parent_node: Node2D 
	var scene_node: Node2D 
	# we'll use thes resource on the savedatacomponent where the scene node is of node2D and is attached to a parent node which is also of type node2D
	
	if parent_node_path != null: 
		parent_node = window.get_node_or_null(parent_node_path)
		
	if node_path != null: 
		var scene_file_resource: Resource = load(scene_file_path)
		scene_node = scene_file_resource.instantiate() as Node2D 
		
	if parent_node != null and scene_node != null: 
		scene_node.global_position = global_position 
		parent_node.add_child(scene_node) 
