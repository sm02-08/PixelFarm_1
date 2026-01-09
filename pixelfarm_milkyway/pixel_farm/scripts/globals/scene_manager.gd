extends Node

# another global script, so this one was also added to the "Globals" in project -> project settings -> globals

var main_scene_path: String = "res://scenes/main_scene.tscn"
var main_scene_root_path: String = "/root/MainScene"
var main_scene_level_root_path: String = "/root/MainScene/GameRoot/LevelRoot"

var level_scenes: Dictionary = {
	"Level1": "res://scenes/levels/level_1.tscn"
}

func load_main_scene_container() -> void: 
	if get_tree().root.has_node(main_scene_root_path): 
		return 
	
	var node: Node = load(main_scene_path).instantiate() # a node which is a type of node, naturally
	
	if node != null: # if node is NOT equal to node 
		get_tree().root.add_child(node) # pass in the node in the child 
		
func load_level(level: String) -> void: # we need a function to load levels; pass in the level (a type string); return type is void
	var scene_path: String = level_scenes.get(level)
	
	if scene_path == null: 
		return # then just return from this method 
		
	var level_scene: Node = load(scene_path).instantiate() 
	var level_root: Node = get_node(main_scene_level_root_path) # pass in the main scene's level root path here
	
	if level_root != null: 
		var nodes = level_root.get_children() 
		
		if nodes != null: 
			for node: Node in nodes: # if node is in the nodes collection, then queue free anything registered underneath the level root node 
				node.queue_free() 
		
		await get_tree().process_frame
		
		level_root.add_child(level_scene)
