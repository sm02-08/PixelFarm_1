extends Sprite2D
@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent

var log_scene = preload("res://scenes/objects/trees/log.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)
	damage_component.max_damaged_reached.connect(on_max_damaged_reached) 

func on_hurt(hit_damage: int) -> void: 
	damage_component.apply_damage(hit_damage) # once damage is applied from wood chopping, 
	material.set_shader_parameter("shake_intensity", 0.5) # set the material from the tree_shade.gdshader material tab
	await get_tree().create_timer(1.0).timeout # temp timer or 1 second 
	material.set_shader_parameter("shake_intensity", 0.0) # set shade parameter again and set back to 0
	
func on_max_damaged_reached() -> void: 
	call_deferred("add_log_scene") # calls the log scene when 3 hits are done to a tree
	print("max damaged reached")
	queue_free() 
	
func add_log_scene() -> void: 
	var log_instance = log_scene.instantiate() as Node2D 
	log_instance.global_position = global_position 
	get_parent().add_child(log_instance) # enables the log to be dropped when tree's chopped
