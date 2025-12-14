# copied too from node_state.gd
extends NodeState

@export var character: CharacterBody2D 
@export var animated_sprite_2d: AnimatedSprite2D # these two copied from chicken's idle script 
@export var navigation_agent_2d: NavigationAgent2D 
@export var min_speed: float = 5.0 # default to 5 
@export var max_speed: float = 10.0 # default to 10

var speed: float 

func _ready() -> void: 
	call_deferred("character_setup") # call deferred allows you to call other functions after the 
	# current frame has finished processing 
	# thus, call_deferred will call character setup during idle time 
	# when character set up is called, we will wait until after the first physics frame 
	# this allows for a smoother setup of our navigation agent before we start to move between 
	# different targets 
	
func character_setup() -> void: 
	await get_tree().physics_frame # wait for the first physics frame
	# when we use navigation region, the navigation agent has to wait for hte first physics frame 
	# and then starts to process the next target
	
	set_movement_target() 
	
func set_movement_target() -> void: 
	var target_position: Vector2 = NavigationServer2D.map_get_random_point(navigation_agent_2d.get_navigation_map(), navigation_agent_2d.navigation_layers, false)
	navigation_agent_2d.target_position = target_position 
	speed = randf_range(min_speed, max_speed) # what this does is set the default speed value, 
	# and choose a speed between 5 and 10 
	# this allows every chicken to get a different speed, allowing for character variation 

func _on_process(_delta : float) -> void:
	pass



func _on_physics_process(_delta : float) -> void:
	var target_position: Vector2 = navigation_agent_2d.get_next_path_position() 
	var target_direction: Vector2 = character.global_position.direction_to(target_position) # export var character
	# ^ this will get the facing direction that our character is facing towards 
	
	# next step: get our animated sprite 2d and use .flip(H) = target direction.x (which is the axis value)
	# if this is less than 0, flip the chicken 
	animated_sprite_2d.flip_h = target_direction. x < 0 
	character.velocity = target_direction * speed 
	character.move_and_slide() # process the movement of our character 
	# not using delta in our calculation because character will use delta calculation within the
	# move and slide 
	# so all we need to do is calculate direction * speed and assign that to velocity
	# internally, delta will be calculated for us 

# go to navigation agent 2d and go down to "Debug" and click "enabled" to see the line the chicken
# follows when it's walking 

func _on_next_transitions() -> void:
	pass


func _on_enter() -> void:
	animated_sprite_2d.play("walk") # play walk animation when entering walk state


func _on_exit() -> void:
	animated_sprite_2d.stop() # stop the walk animation on exit 

# we need to be able to get the chicken to walk to places, so we use a navigation region 2d 
# draw a navigation polygon that borders where the chicken can move 
