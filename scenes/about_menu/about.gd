extends Control

signal transition_started

func _on_AboutL_transition_started():
	emit_signal('transition_started')
