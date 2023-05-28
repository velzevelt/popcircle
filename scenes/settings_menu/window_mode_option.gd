extends Node

onready var target = get_parent() # OptionButton

enum {
	FULLSCREEN,
	WINDOW
}


var mode_alias: Dictionary = {
	FULLSCREEN: "Fullscreen",
	WINDOW: "Window"
}


func _ready():
	target.add_separator()
	_add_options()
	target.add_separator()
	
	target.connect("item_selected", self, "_on_option_selected")


func _add_options():
	for mode in mode_alias:
		target.add_item(mode_alias[mode])


func _on_option_selected(id):
	if id == -1:
		return
	
	match id - 1:
		FULLSCREEN:
			OS.window_fullscreen = true
		WINDOW:
			OS.window_fullscreen = false
		_:
			OS.window_fullscreen = false

