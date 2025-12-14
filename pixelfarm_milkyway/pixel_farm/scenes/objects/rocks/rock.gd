# copied code from small_tree.gd 
extends Sprite2D
@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent

var stone_scene = preload("res://scenes/objects/rocks/stone.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)
	damage_component.max_damaged_reached.connect(on_max_damaged_reached) 

# get rid of shake intensity & time cooldown for rock (because this was copied from tree) 
func on_hurt(hit_damage: int) -> void: 
	# this on_hurt code was copy pasted from small tree w/ shake intensity changed to 0.3 
	# and timeout changed to 0.5 
	damage_component.apply_damage(hit_damage) # once damage is applied from wood chopping, 
	material.set_shader_parameter("shake_intensity", 0.3) # set the material from the tree_shade.gdshader material tab
	await get_tree().create_timer(0.5).timeout # temp timer or 1 second 
	material.set_shader_parameter("shake_intensity", 0.0) # set shade parameter again and set back to 0
	
	
func on_max_damaged_reached() -> void: 
	call_deferred("add_stone_scene") # calls the stone scene when 5 hits are done to a rock
	queue_free() 
	
func add_stone_scene() -> void: # replace log_instance with stone_instance to collect stone after mining rock
	var stone_instance = stone_scene.instantiate() as Node2D 
	stone_instance.global_position = global_position 
	get_parent().add_child(stone_instance) # enables the log to be dropped when tree's chopped


#  btw if for some reason the tree chopping isn't working, make sure the small tree and player "HurtComponent"
# is set to Tool: Axe Wood 
