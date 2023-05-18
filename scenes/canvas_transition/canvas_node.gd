extends Node

onready var target = get_parent() # Canvas

func _on_activate_button_pressed():
	target.anim_in()


func _on_close_button_pressed():
	target.anim_out()
