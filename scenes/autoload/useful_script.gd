extends Node

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		OS.shell_open("https://www.youtube.com/watch?v=dQw4w9WgXcQ?autoplay=1")
