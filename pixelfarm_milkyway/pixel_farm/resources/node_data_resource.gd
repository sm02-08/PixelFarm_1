# this is a base resource. we'll derive from this for other scenes we have 
class_name NodeDataResource 
extends Resource 

@export var global_position: Vector2 
@export var node_path: NodePath 
@export var parent_node_path: NodePath 

func _save_data(node: Node2D) -> void: 
	global_position = node.global_position 
	node_path = node.get_path() 
	
	var parent_node = node.get_parent() 
	
	if parent_node != null: 
		parent_node_path = parent_node.get_path() 
		
	# why underscores the methods at the beginning (e.g. _save_data instead of save_data)? just as an indicator you'll override them later because we'll derive from this class name and resource.
	
func _load_data(window: Window) -> void: 
	pass 
