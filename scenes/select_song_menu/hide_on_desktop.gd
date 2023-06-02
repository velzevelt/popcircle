extends Node

func _ready():
	if not OS.has_virtual_keyboard():
		get_parent().hide()
