extends Node

#@onready var inventory_manager = get_node("/root/InventoryManager")
#signal inventory_check
#
##var inventory: Dictionary = Dictionary()
#var check: int = 0 
#
#func check_inventory() -> bool: 
	#var inv = inventory_manager.inventory
	#if inv.has("corn") and inv.has("tomato"): 
		#if inv["corn"] >= 20 and inv["tomato"] >= 20: 
			#return true 
			#inventory_check.emit()
	#return false 
