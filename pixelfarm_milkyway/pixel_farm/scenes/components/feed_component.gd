class_name FeedComponent
extends Area2D

signal food_received(area: Area2D)


func _on_area_entered(area): # this is connected to the area_entered signal node of FeedComponent
	food_received.emit(area)
