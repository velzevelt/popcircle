extends Node2D


func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://scenes/menu/menu.tscn")
