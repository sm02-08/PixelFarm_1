extends CanvasLayer

@onready var save_game_button: Button = $MarginContainer/VBoxContainer/SaveGameButton 
signal finished 

func _ready() -> void: 
	save_game_button.disabled = !SaveGameManager.allow_save_game  
	save_game_button.focus_mode = SaveGameManager.allow_save_game if Control.FOCUS_ALL else Control.FOCUS_NONE # use the allow save game parameter
	# this sets the "save game" button to be grey and disabled by default 
	# if the control button has a brown texture, allow game save. if the control button has a white (disabled) texture, don't allow for saving.

func _on_start_game_button_pressed():
	GameManager.start_game() # when we start the game, we need to queue_free() the game menu screen
	# press start, load the main scene, load level 1, and come out of there (still with the game screen) and queue free that 
	emit_signal("finished")
	queue_free()


func _on_save_game_button_pressed():
	SaveGameManager.save_game()


func _on_exit_game_button_pressed():
	GameManager.exit_game()
