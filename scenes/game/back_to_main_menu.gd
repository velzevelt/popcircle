extends Node

var main_menu = preload("res://scenes/main_menu/main_menu.tscn")

func _on_ConfirmPopup_yes_pressed():
	get_tree().paused = false
	get_tree().change_scene_to(main_menu)

