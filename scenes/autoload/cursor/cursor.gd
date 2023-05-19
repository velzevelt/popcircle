extends Node2D

signal just_pressed
signal just_released

enum MouseMode {
	VISIBLE = Input.MOUSE_MODE_VISIBLE,
	HIDDEN = Input.MOUSE_MODE_HIDDEN,
	CAPTURED = Input.MOUSE_MODE_CAPTURED
}

export(MouseMode) var mouse_mode := MouseMode.VISIBLE
onready var press_particle = $PressParticle

var cursor_texture = preload("res://sprites/cursor_default.svg") # 128x128


func _ready():
	Input.mouse_mode = mouse_mode


func _process(delta):
	global_position = get_global_mouse_position()


func _input(event):
	if Input.is_action_just_pressed("click"):
		emit_signal("just_pressed")
	
	if Input.is_action_just_released("click"):
		emit_signal("just_released")
	
