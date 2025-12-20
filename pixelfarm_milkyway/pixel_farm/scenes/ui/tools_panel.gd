extends PanelContainer

@onready var tool_axe = $MarginContainer/HBoxContainer/ToolAxe
@onready var tool_tilling = $MarginContainer/HBoxContainer/ToolTilling
@onready var tool_watering_can = $MarginContainer/HBoxContainer/ToolWateringCan
@onready var tool_corn = $MarginContainer/HBoxContainer/ToolCorn
@onready var tool_tomato = $MarginContainer/HBoxContainer/ToolTomato


## Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
"""
to do this function below (ontoolaxepressed and all the other ontool___pressed), go to ToolAxe, 
then "Node," then "pressed()", then click "pressed()" and "Connect"
we basically want to set this tool so that when you click the axe UI, you switch item to axe
"""
# to do this function 
func _on_tool_axe_pressed(): 
	ToolManager.select_tool(DataTypes.Tools.AxeWood) # use select_tool function from tool_manager
	# when axe selected, axe is assigned to player 

func _on_tool_tilling_pressed():
	ToolManager.select_tool(DataTypes.Tools.TillGround) # copied from on_tool_axe_pressed

func _on_tool_watering_can_pressed():
	ToolManager.select_tool(DataTypes.Tools.WaterCrops) # copied from on_tool_axe_pressed

func _on_tool_corn_pressed():
	ToolManager.select_tool(DataTypes.Tools.PlantCorn) # copied from on_tool_axe_pressed

func _on_tool_tomato_pressed():
	ToolManager.select_tool(DataTypes.Tools.PlantTomato) # copied from on_tool_axe_pressed

# but right now we can't deselect tools 
# so we added a release tool on the project -> project settings -> input map 
# and will have a new function below 

func _unhandled_input(event: InputEvent) -> void: 
	if event.is_action_pressed("release_tool"): 
		ToolManager.select_tool(DataTypes.Tools.None)
		tool_axe.release_focus()
		tool_tilling.release_focus()
		tool_watering_can.release_focus() 
		tool_corn.release_focus() 
		tool_tomato.release_focus() 
		# these will allow us to release the button when we reclick 
