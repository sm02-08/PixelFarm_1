extends Node

@onready var inventory_manager = get_node("/root/InventoryManager")

signal give_crop_seeds
signal feed_the_animals
signal inventory_check

func action_give_crop_seeds() -> void: 
	give_crop_seeds.emit()

func action_feed_animals() -> void: 
	feed_the_animals.emit() # similar to the one before

#func check_inventory() -> bool: 
	#inventory_check.emit()


func check_inventory() -> bool: 
	var inv = inventory_manager.inventory
	if inv.has("corn") and inv.has("tomato"): 
		if inv["corn"] >= 20 and inv["tomato"] >= 20: 
			print("Check Inventory: True")
			inventory_check.emit()
			#spawn_next_level_portal()
			return true 
	print("Check Inventory: False")
	return false 
	
