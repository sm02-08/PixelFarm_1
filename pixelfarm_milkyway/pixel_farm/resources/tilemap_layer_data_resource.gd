class_name TileMapLayerDataResource # continued from save_level_data_component.gd: we can see that the first resource its found is the TileMapLayer.
extends NodeDataResource

@export var tilemap_layer_used_cells: Array[Vector2i]
@export var terrain_set: int = 0 # default value of integer 0 
@export var terrain: int = 3 

# explanation continued from save_data_component.gd
# so now in this instance, we got the save data component here which is TileMapLayerDataResource. we then set those variables and get the cells from the tilemaplayer and set them on the resource. once they've been set on the resource, we return them on the resource and add it to the game data resource, save data nodes collection 
# as we go to the next save data component in save_data_component.gd, we save the data, then go into the resource of that component. go to scene_data_resource.gd for continued explanation 

func _save_data(node: Node2D) -> void: 
	super._save_data(node) # this will call the save data method of node_data_resource 
	
	var tilemap_layer: TileMapLayer = node as TileMapLayer # cast the node as a tilemaplayer 
	var cells: Array[Vector2i] = tilemap_layer.get_used_cells() 
	
	tilemap_layer_used_cells = cells 
	
func _load_data(window: Window) -> void: # continued from the first line: 
	var scene_node = window.get_node_or_null(node_path) # we see that the load data will then find the tilemaplayer that's associated with it... 
	
	if scene_node != null: 
		var tilemap_layer: TileMapLayer = scene_node as TileMapLayer 
		tilemap_layer.set_cells_terrain_connect(tilemap_layer_used_cells, terrain_set, terrain, true) # and then start to rebuild and attach the specific properties for that specific node
		# this grabs the tilemaplayer and sets the terrains again 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
