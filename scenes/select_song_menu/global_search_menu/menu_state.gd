class_name MenuState
extends Node

signal menu_state_changed(new_state)

enum {
	BUSY,
	FREE,
}

var current_state = BUSY setget set_current_state, get_current_state

func set_current_state(value):
	current_state = value
	emit_signal("menu_state_changed", current_state)

func get_current_state():
	return current_state
