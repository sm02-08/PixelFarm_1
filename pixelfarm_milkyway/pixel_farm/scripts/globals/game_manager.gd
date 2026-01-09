extends Node

# this is a global script, which means you go to project -> project settings -> select this script as a global one to add to the list 

var game_menu_screen = preload("res://scenes/ui/game_menu_screen.tscn") # preload the scene from the scenes UI folder 

func _unhandled_input(event: InputEvent) -> void: 
	if event.is_action_pressed("game_menu"): 
		show_game_menu_screen() 

func start_game() -> void: 
	SceneManager.load_main_scene_container() 
	# ^ this means that the MainScene container will load first
	SceneManager.load_level("Level1") # back in scene_manager.gd, we defined a level called "level1" in the Dictionary. when we pass "Level1," it'll pass level_1.tscn
	# so even though we have a "Level1" node in the Main Scene parent node, when we pass in this, it'll go to the LevelRoot node, remove Level1 node, and then add what's in the dictionary instead.
	SaveGameManager.load_game() 
	SaveGameManager.allow_save_game = true 
	
func exit_game() -> void: 
	get_tree().quit() # really easy way to just quit the game

func show_game_menu_screen() -> void: 
	var game_menu_screen_instance = game_menu_screen.instantiate() 
	get_tree().root.add_child(game_menu_screen_instance)

# this method allows you to add any levels to the scene and then test it out 
