extends Node2D
# ohh so to get rid of the constant issue of having the func _ready(): pass already loaded in and stuff, just disable template... why did i never try this before.

# to make the "e" actually interact with the player, put an input map 
var balloon_scene = preload("res://dialogue/game_dialogue_balloon.tscn")

@onready var interactable_component: InteractableComponent = $InteractableComponent
@onready var interactable_label_component: Control = $InteractableLabelComponent

var in_range: bool 

func _ready() -> void: 
	interactable_component.interactable_activated.connect(on_interactable_activated)
	interactable_component.interactable_deactivated.connect(on_interactable_deactivated)
	interactable_label_component.hide() 
	
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
			get_tree().current_scene.add_child(balloon) 
			balloon.start(load("res://dialogue/conversations/guide.dialogue"), "start")
		 
