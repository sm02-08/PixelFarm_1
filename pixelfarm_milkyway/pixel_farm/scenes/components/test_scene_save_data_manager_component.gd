class_name TestSceneSaveDataManagerComponent
extends Node


func _ready() -> void: # the original ready function was overriden 
	call_deferred("load_test_scene") 

# we use call_deferred to make sure the save level data component and the save data components are being loaded in the scene tree first 

func load_test_scene():
	SaveGameManager.load_game()
	# this is a special component just for test scenes to allow loading game data that was saved only for test scenes 
