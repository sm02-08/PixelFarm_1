class_name SaveDataComponent 
extends Node

@onready var parent_node: Node2D = get_parent() as Node2D 

@export var save_data_resource: Resource 

func _ready() -> void: 
	add_to_group("save_data_component")
	# this is the same thing as using the groups collection in "Node" (like the tab right next to "Inspector". however, if we say it here, we can use these components in other scenes and don't have to keep remembering to add them to the group 
	
func _save_data() -> Resource: # this returns a type of Resource
	if parent_node == null: 
		return null 
		
	if save_data_resource == null: 
		push_error("save_data_resource: ", save_data_resource, parent_node.name)
		# ^ this checks if we set up a save data component correctly with the parent node and the resource
		
		# continued explanation from save_level_data_component.gd
		# then, we get the resource from the save data component here. then, inside the resource (SaveDataComponent node in test_scene_cropfields_tilled_dirt), which is attached to the save data component, we call save_data on the resource 
		# go to tilemap_layer_data_resource.gd for continued explanation 
		
	save_data_resource._save_data(parent_node)
	
	
	return save_data_resource 

## Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
