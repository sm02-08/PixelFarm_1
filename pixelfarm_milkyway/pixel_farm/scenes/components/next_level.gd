extends Area2D

const FILE_BEGIN = "res://scenes/levels/level_"
const LEVELS_PATH = "res://scenes/levels/level_1"

#signal change_level 

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		SceneManager.load_level("Level2")
		#get_tree().change_scene_to_file("res://scenes/levels/level_2.tscn")
		#get_node("LevelRoot/Level1").queue_free()
		#change_level.emit()
	#print(body)
#func start_game() -> void: 
	#SceneManager.load_main_scene_container() 
	## ^ this means that the MainScene container will load first
	#SceneManager.load_level("Level1") # back in scene_manager.gd, we defined a level called "level1" in the Dictionary. when we pass "Level1," it'll pass level_1.tscn
	## so even though we have a "Level1" node in the Main Scene parent node, when we pass in this, it'll go to the LevelRoot node, remove Level1 node, and then add what's in the dictionary instead.
	#SaveGameManager.load_game() 
	#SaveGameManager.allow_save_game = true 

#func _on_area_entered(area):
	#if area.is_in_group("player"): 
		#print("Collided with player")
		#var current_scene_file = get_tree().current_scene.scene_file_path # get_tree.current scene gets the topmost node (e.g. in the level1 scene, it would grab the Level1 node because that's the top-most node) 
		## scene file path is where you saved your scene 
		#print(current_scene_file)
		#var next_level_number = current_scene_file.to_int() + 1 # grab the current scene file (path) and convert it to an integer. it basically grabs the whole string (e.g. level_1) to a number (e.g. to "1"). it would convert this to an integer and adds 1 to it (so like... level_1 becomes level_2 because 1 + 1 = 2).
		## this would be flawed if your folder name was like "083720358level1_version2_version3" or something el oh el
		#var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn" # FILE_BEGIN = res://scenes/levels/level_
		## so the var next_level_number would output "2" or "3" and then this one ^ basically makes it levels/level_1 becoming level_2 (like the "1" in level_1 gets converted to "2" to make the file path level_2) 
		#print(next_level_path)



	
	# lowkey this entire next part is just asongaosgbauogsb it's baddddd
	#if body.is_in_group("player") and await SceneManager.load_level("Level1").finished:  #SceneManager.load_level("Level1"): 
		#print("Collided with player")
		#var current_scene_file = get_tree().current_scene.scene_file_path
		##var current_scene_file = get_tree().current_scene.scene_file_path # get_tree.current scene gets the topmost node (e.g. in the level1 scene, it would grab the Level1 node because that's the top-most node) 
		## note: you can't use "var current_scene_file = get_tree().current_scene.scene_file_path" because the current_scene part of it would just jump to game_menu_screen because that's set as the main scene
		#
		## scene file path is where you saved your scene 
		#print(current_scene_file)
		#var next_level_number = current_scene_file.to_int() + 1 # grab the current scene file (path) and convert it to an integer. it basically grabs the whole string (e.g. level_1) to a number (e.g. to "1"). it would convert this to an integer and adds 1 to it (so like... level_1 becomes level_2 because 1 + 1 = 2).
		## this would be flawed if your folder name was like "083720358level1_version2_version3" or something el oh el
		#var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn" # FILE_BEGIN = res://scenes/levels/level_
		## so the var next_level_number would output "2" or "3" and then this one ^ basically makes it levels/level_1 becoming level_2 (like the "1" in level_1 gets converted to "2" to make the file path level_2) 
		#print(next_level_path)
