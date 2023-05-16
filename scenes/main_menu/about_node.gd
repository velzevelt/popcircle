extends Node

onready var target = get_parent() # Canvas

func _on_AboutButton_pressed():
	target.fade_in()


func _on_CloseMenuButton_pressed():
	target.fade_out()
