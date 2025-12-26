class_name SaveDataComponent 
extends Node

@onready var parent_node: Node2D = get_parent() as Node2D 

@export var save_data_resource: Resource 

func _ready() -> void: 
	add_to_group("save_data_component")
	# this is the same thing as using the groups collection in "Node" (like the tab right next to "Inspector". however, if we say it here, we can use these components in other scenes and don't have to keep remembering to add them to the group 
	
	

## Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
