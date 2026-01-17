extends Node2D
#extends Node 
# ohh so to get rid of the constant issue of having the func _ready(): pass already loaded in and stuff, just disable template... why did i never try this before.

# to make the "e" actually interact with the player, put an input map 

#signal dialogue_function_called 
signal inventory_check_passed 

var balloon_scene = preload("res://dialogue/game_dialogue_balloon.tscn")

@onready var interactable_component: InteractableComponent = $InteractableComponent
@onready var interactable_label_component: Control = $InteractableLabelComponent

var in_range: bool 

func _ready() -> void: 
	interactable_component.interactable_activated.connect(on_interactable_activated)
	interactable_component.interactable_deactivated.connect(on_interactable_deactivated)
	interactable_label_component.hide() 
	print("GameDialogueManager autoload loaded as: ", self.name)
	#NPC_3.inventory_check_passed.connect(_on_inventory_check_passed)
	GameDialogueManager.inventory_check.connect(_on_inventory_check_passed)
	
	#GameDialogueManager.give_crop_seeds.connect(on_give_crop_seeds)
	
func on_interactable_activated() -> void:
	interactable_label_component.show()
	in_range = true 
	
func on_interactable_deactivated() -> void: 
	interactable_label_component.hide() 
	in_range = false 

func _unhandled_input(event: InputEvent) -> void: 
	if in_range: 
		if event.is_action_pressed("show_dialogue"): 
			var balloon: BaseGameDialogueBalloon = balloon_scene.instantiate() 
			get_tree().root.add_child(balloon) 
			balloon.start(load("res://dialogue/conversations/npc_3.dialogue"), "start")
		

#func _on_dialogue_option_selected(option: String) -> void:
	#if option == "I have 20 corn and 20 tomatoes.":
		#if GameDialogueManager.check_inventory():
			#spawn_next_level_portal()
			##get_tree().change_scene_to_file("res://level_2.tscn")
		#else:
			#$DialogueBox.show_message("You need at least 20 corn and 20 tomatoes!")

#func _on_dialogue_function_called(function_name: String, result):
	#if function_name == "check_inventory":
		#if result == true:
			#print("Function called: ", function_name, "Result: ", result)
			##dialogue_function_called.emit()
			#spawn_next_level_portal()
		#else:
			##$DialogueBox.show_message("Sorry, you haven't fulfilled the requirements yet.")
			#print("Function called: ", function_name, "Result: ", result)

#@export function 
	
func _on_inventory_check_passed():
	spawn_next_level_portal()

func spawn_next_level_portal(): 
	var portal_scene = load("res://scenes/components/next_level.tscn") # load the portal scene (next_level.tscn is the portal) 
	var portal = portal_scene.instantiate() 
	#get_tree().current_scene.add_child(portal)
	add_child(portal)
	portal.global_position = global_position + Vector2(32, 0)


#var inventory: Dictionary = Dictionary() # create a new variable that's type dictionary 
#
#signal inventory_changed 
#
#func add_collectible(collectible_name: String) -> void: # adding the collectible name to inv dictionary
	#inventory.get_or_add(collectible_name)
	#
	#if inventory[collectible_name] == null: # if we have nothing in the inventory...
		#inventory[collectible_name] = 1 # just add the value 1
		#
	#else: 
		#inventory[collectible_name] += 1 
		#
	#inventory_changed.emit()
	
#
#
#func move_level_2() -> void: 
	


	
	
