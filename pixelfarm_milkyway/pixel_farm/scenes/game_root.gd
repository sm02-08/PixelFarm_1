extends Node2D

#func _setup_level() -> void: 
	#var exit: $LevelRoot

#func _load_level() -> void: 
	## upon receiving the signal, do these: 
	#get_tree().change_scene_to_file("res://scenes/levels/level_2.tscn")
	#get_node("LevelRoot/Level1").queue_free() # get rid of level 1 entirely 
