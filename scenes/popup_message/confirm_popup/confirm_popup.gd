extends "res://scenes/popup_message/popup_message.gd"

signal yes_pressed
signal no_pressed

func _on_YESButton_pressed():
	_on_OKButton_pressed()
	emit_signal('yes_pressed')


func _on_NOButton_pressed():
	_on_OKButton_pressed()
	emit_signal('no_pressed')

