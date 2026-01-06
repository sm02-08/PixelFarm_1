extends Node

var inventory: Dictionary = Dictionary() # create a new variable that's type dictionary 

signal inventory_changed 

func add_collectible(collectible_name: String) -> void: # adding the collectible name to inv dictionary
	inventory.get_or_add(collectible_name)
	
	if inventory[collectible_name] == null: # if we have nothing in the inventory...
		inventory[collectible_name] = 1 # just add the value 1
		
	else: 
		inventory[collectible_name] += 1 
		
	inventory_changed.emit()

func remove_collectible(collectible_name: String) -> void: 
	if inventory[collectible_name] == null: # copy pasted from just above 
		inventory[collectible_name] = 0 # changed from 1 to 0
		
	else: 
		if inventory[collectible_name] > 0: # make sure you actually have items in the inventory before you remove an item, lest you end up with -1 items
			inventory[collectible_name] -= 1 # change from += 1 to -= 1, because we deduct it from the inventory
		
	inventory_changed.emit()

## Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
