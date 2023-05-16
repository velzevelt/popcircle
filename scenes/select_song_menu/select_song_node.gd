extends Node

onready var target = get_parent() # Canvas

func _on_PlayButton_pressed():
	target.fade_in()


func _on_CloseButton_pressed():
	target.fade_out()
