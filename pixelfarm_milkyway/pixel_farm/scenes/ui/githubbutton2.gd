extends Button

@export var link: String # no magic strings :sparkle: 

# this script enables a click of the github button to actual take you to the game's github page

func press_button(): 
	OS.shell_open(link) # link to an outside link 
