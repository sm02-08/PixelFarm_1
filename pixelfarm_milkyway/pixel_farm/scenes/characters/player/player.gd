class_name Player # the class name derives from characterbody2d
extends CharacterBody2D

@onready var hit_component: HitComponent = $HitComponent

@export var current_tool: DataTypes.Tools = DataTypes.Tools.None # default it to none 

var player_direction: Vector2 # player will now have variable player direction

func _ready() -> void: 
	ToolManager.tool_selected.connect(on_tool_selected) # signal from tools_panel and tools_manager
	
func on_tool_selected(tool: DataTypes.Tools) -> void: 
	current_tool = tool # set current tool to the tool being passed into our method 
	# make sure to update hit component too! 
	hit_component.current_tool = tool 
	# and also make sure that current tool for HitComponent is set to None so that 
	# the default will always be that there's no tool 
	print("Tool: ", tool)

#func _physics_process(_delta: float) -> void: #sm1.17.2026 
	#move_and_slide()

#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
#
#
#func _physics_process(delta):
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
