extends Node2D

var balloon_scene = preload("res://dialogue/game_dialogue_balloon.tscn")

var corn_harvest_scene = preload("res://scenes/objects/plants/corn_harvest.tscn")
var tomato_harvest_scene = preload("res://scenes/objects/plants/tomato_harvest.tscn")
# preload both corn and tomato harvest

@export var dialogue_start_command: String # a new export variable not taken from the chest scene nodes
@export var food_drop_height: int = 40 
@export var reward_output_radius: int = 20 
@export var output_reward_scenes: Array[PackedScene] = []

# all of these onready variables are from the nodes, and will be exported from this scene
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var interactable_component: InteractableComponent = $InteractableComponent
@onready var feed_component: FeedComponent = $FeedComponent
@onready var reward_marker: Marker2D = $RewardMarker
@onready var interactable_label_component: Control = $InteractableLabelComponent

var in_range: bool 
var is_chest_open: bool 

func _ready() -> void: # override the ready method
	interactable_component.interactable_activated.connect(on_interactable_activated) # connect on interactable activated using the function defined below
	interactable_component.interactable_deactivated.connect(on_interactable_deactivated) 
	interactable_label_component.hide() # hide interactable label component when the scene loads up 
	
	GameDialogueManager.feed_the_animals.connect(on_feed_the_animals) # we need an action to come after you agree to feed the cows and chickens, and here, we connect that action through signals. the feed_the_animals function is down below
	feed_component.food_received.connect(on_food_received) # connect the food received signal 
	# scroll down to the on_food_received signal
	
func on_interactable_activated() -> void: 
	# when players go into the interactable area, we want a label to show 
	# and show that the player is in range of the interactable area 
	interactable_label_component.show() 
	in_range = true
	
func on_interactable_deactivated() -> void: 
	# second: therefore, we set is_chest_open to default false and close the chest after the player is no longer interacting (within range) of the chest's collision shape
	if is_chest_open: 
		animated_sprite_2d.play("chest_close")
	is_chest_open = false 
	
	# first: with just this, if you walk away from the chest, the chest won't close. we need it to close if the player is out of range from the chest's collision shape 
	interactable_label_component.hide() 
	in_range = false 

# with just this, we see the "E" when we get within range of the chest, but nothing happens when we press "E"
# therefore, we need an input event whenever "E" is pressed 
func _unhandled_input(event: InputEvent) -> void: 
	if in_range: 
		if event.is_action_pressed("show_dialogue"): 
			interactable_label_component.hide() 
			animated_sprite_2d.play("chest_open")
			is_chest_open = true
			
			# need dialogue to be created
			var balloon: BaseGameDialogueBalloon = balloon_scene.instantiate() 
			get_tree().current_scene.add_child(balloon) # get the tree of the current scene, add child, and pass in the balloon instance
			
			balloon.start(load("res://dialogue/conversations/chest.dialogue"), dialogue_start_command) # load some dialogue script, and then pass in the parameter dialogue_start_command() which was already declared in line 9
			# we want to create diff dialogue scripts for cows and chickens

func on_feed_the_animals() -> void: 
	if in_range:
		trigger_feed_harvest("corn", corn_harvest_scene)
		# to solve the issue w/ adding tomatoes...
		trigger_feed_harvest("tomato", tomato_harvest_scene) # just do this, obv
		

func trigger_feed_harvest(inventory_item: String, scene: Resource) -> void: # pass in the inventory_item adn scene 
	var inventory: Dictionary = InventoryManager.inventory # first take a hold of the inventory
	
	# if the inventory does NOT have the item...
	if !inventory.has(inventory_item): 
		return # then just return from this method
		
	# if the inventory DOES have the item...
	var inventory_item_count = inventory[inventory_item]
	
	for index in inventory_item_count: 
		var harvest_instance = scene.instantiate() as Node2D  # it equals the scene of which we're passing into the function, instantiate the scene as Node2D
		harvest_instance.global_position = Vector2(global_position.x, global_position.y - food_drop_height) # vector2, which is a global position of the chest (for x and y), minus the food drop height declared in line 10 
		get_tree().root.add_child(harvest_instance)
		var target_position = global_position 
		
		var time_delay = randf_range(0.5, 2.0) # for the first parameter, set it to 0.5, and for the second parameter, set it to 2.0. the randf range function goes from 0.5 to 2.0
		await get_tree().create_timer(time_delay).timeout # call await, get tree, create a timer, pass in the time delay variable, dot the timeout signal 
		
		var tween = get_tree().create_tween()
		tween.tween_property(harvest_instance, "position", target_position, 1.0) # pass in harvest instance. the first property to interpolate will be the position, then passing target position, then the duration of 1.
		tween.tween_property(harvest_instance, "scale", Vector2(0.5, 0.5), 1.0) # a duration of 1 second 
		tween.tween_callback(harvest_instance.queue_free) # this queue frees our node from the scene 
		# the tweens here will interpolate the values, one after another, so they're not called in parallel 
		# these actions are called sequentially. 
		
		InventoryManager.remove_collectible(inventory_item)


func on_food_received(area: Area2D) -> void: 
	call_deferred("add_reward_scene") # we use call deferred to make sure the scene is added in the idle time 
	
func add_reward_scene() -> void: 
	for scene in output_reward_scenes: 
		var reward_scene: Node2D = scene.instantiate()  # reward_scene is a node 2d 
		# now, calculate the random position for the award with get_random_circle_position
		var reward_position: Vector2 = get_random_circle_position(reward_marker.global_position, reward_output_radius) # grab the reward marker's global position, pass in the reward output radius
		reward_scene.global_position = reward_position # the global position = reward position
		get_tree().root.add_child(reward_scene) 
		
func get_random_circle_position(center: Vector2, radius: int) -> Vector2i: # pass in centerpoint and radius for circle
	var angle = randf() * TAU # tau = 2 * pi
	var distance_from_center = sqrt(randf()) * radius 
	
	var x: int = center.x + distance_from_center * cos(angle) # get the x-value of the center point, add random distance from the center which is just calculated, * the cos of the angle 
	var y: int = center.y + distance_from_center * cos(angle)
	
	return Vector2i(x, y) 
	
