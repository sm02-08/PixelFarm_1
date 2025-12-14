class_name CollectibleComponent
extends Area2D

@export var collectable_name: String

# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass


func _on_body_entered(body: Node2D) -> void:
	if body is Player: 
		print("Collected") # when player collects the log, print "Collected"
		get_parent().queue_free() 
