class_name SceneDataResource 
extends NodeDataResource 

@export var node_name: String 
@export var scene_file_path: String 

func _save_data(node: Node2D) -> void: 
	super._save_data(node) # pass in base class from node_data_resource.gd 
	
	node_name = node.name
	scene_file_path = node.scene_file_path 
	# continued explanation from res://resources/tilemap_layer_data_resource.gd
	# from line 11, we get the scene file path and if we just check the resource in "Stack Trace" (below, when you run it), we can see the information that's now inside the parameters of save_data_component.gd's last line of return save_data_resource 
	
func _load_data(window: Window) -> void: # defines load_data for save_leveL_data_resource.gd 
	var parent_node: Node2D 
	var scene_node: Node2D 
	# we'll use thes resource on the savedatacomponent where the scene node is of node2D and is attached to a parent node which is also of type node2D
	
	if parent_node_path != null: # the parent node path is cropfields 
		parent_node = window.get_node_or_null(parent_node_path)
		
	if node_path != null: 
		var scene_file_resource: Resource = load(scene_file_path)
		scene_node = scene_file_resource.instantiate() as Node2D 
		
	if parent_node != null and scene_node != null: 
		scene_node.global_position = global_position # we get the position that we saved, then reset the position of the new save 
		parent_node.add_child(scene_node) # and then attach the new save to the parent node, which is cropfields
