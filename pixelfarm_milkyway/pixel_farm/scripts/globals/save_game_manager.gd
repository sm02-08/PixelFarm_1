# this script was also set in globals through project -> project settings -> globals
# this script includes the hotkey to save game, which will be ctrl+s (deviating from the tutorial which uses "P" for some reason) 

extends Node

func _unhandled_input(event: InputEvent) -> void: # this is the input map
	if event.is_action_pressed("save_game"):
		save_game() # when the same_game access is pressed, we go into the function save_game()

func save_game() -> void: 
	var save_level_data_component: SaveLevelDataComponent = get_tree().get_first_node_in_group("save_level_data_component")
	# here, we check if our scene has a save level data component 
	
	if save_level_data_component != null: 
		# then we grab the save level data component
		save_level_data_component.save_game() # and then save the game from there 
		# now go to save_leveL_data_component.gd for further explanations of the code 

func load_game() -> void: 
	# copy everything from save_game() 
	var save_level_data_component: SaveLevelDataComponent = get_tree().get_first_node_in_group("save_level_data_component")
	
	if save_level_data_component != null: 
		save_level_data_component.load_game() # this is changed from save_game to load_game 

# now, we need to create a special save game data node 
# for test scenes, we save data slightly differently from the main game 



## Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
