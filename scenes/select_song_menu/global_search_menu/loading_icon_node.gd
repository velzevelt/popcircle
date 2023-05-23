extends Node

onready var target = get_parent()

func _on_MenuState_menu_state_changed(new_state):
	target.visible = new_state != MenuState.FREE
