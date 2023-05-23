extends VBoxContainer

signal text_entered(new_text)

onready var line_edit = $LineEdit

func _on_LineEdit_text_entered(new_text):
	emit_signal("text_entered", line_edit.text)
