extends VBoxContainer

signal text_entered(new_text)
signal text_changed(new_text)

onready var line_edit = $LineEdit
onready var root = owner

func _on_LineEdit_text_entered(new_text):
	emit_signal("text_entered", line_edit.text)
	owner.hide()


func _on_Submit_pressed():
	if line_edit.text != "":
		_on_LineEdit_text_entered(line_edit.text)


func _on_LineEdit_text_changed(new_text):
	emit_signal("text_changed", new_text)
