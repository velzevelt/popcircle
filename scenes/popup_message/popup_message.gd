extends "res://scenes/popup_message/popup_window.gd"

onready var message = $"%Message"

var text: String setget set_text, get_text

func get_text():
	return text


func set_text(value):
	text = tr(value)
	message.text = text


func _on_OKButton_pressed():
	hide()


