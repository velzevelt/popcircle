extends Node2D

onready var root = get_tree().root


func _process(delta):
	if Input.is_action_just_pressed("click"):
		var mouse_pos = get_global_mouse_position()
		var event = InputEventScreenTouch.new()
		event.pressed = true
		event.position = mouse_pos
		#get_tree().input_event(event)
		root.input(event)
	
	if Input.is_action_just_released("click"):
		var mouse_pos = get_global_mouse_position()
		var event = InputEventScreenTouch.new()
		event.pressed = false
		event.position = mouse_pos
		#get_tree().input_event(event)
		root.input(event)
