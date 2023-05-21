extends Node2D

signal just_pressed
signal just_released

export var anim_duration := 0.3

var cursor_texture = preload("res://sprites/cursor_default.svg")
onready var _size_frames: Array = _create_frames()
onready var _current_frame := 0 setget set_current_frame

func set_current_frame(value: int):
	if value < 0:
		value = 0
	elif value > _size_frames.size() - 1:
		value = _size_frames.size() - 1
	
	_current_frame = value
	


func _create_frames() -> Array:
	var result = []
	var frames = 50
	var skipped_frames = 20
	var step = cursor_texture.get_size() / frames
	
	for i in range(1 + skipped_frames, frames + 1):
		var image = cursor_texture.get_data()
		image.resize(step.x * i, step.y * i, Image.INTERPOLATE_LANCZOS)
		
		#var init_size = cursor_texture.get_size()
		#image.resize(init_size.x, init_size.y)
		
		var texture = ImageTexture.new()
		texture.create_from_image(image)
		
		result.append(texture)
	
	return result


func _ready():
	_set_cursor_frame()
	connect("just_pressed", self, "_on_just_pressed")
	connect("just_released", self, "_on_just_released")


func _set_cursor_frame(frame: int = self._current_frame) -> void:
	Input.set_custom_mouse_cursor(_size_frames[frame], Input.CURSOR_ARROW, _size_frames[frame].get_size() / 2)


func _process(delta):
	_set_cursor_frame()


func _input(event):
	if Input.is_action_just_pressed("click"):
		emit_signal("just_pressed")
	
	if Input.is_action_just_released("click"):
		emit_signal("just_released")
	


func _on_just_pressed():
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_method(self, "set_current_frame", self._current_frame, _size_frames.size() - 1, anim_duration)

func _on_just_released():
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_method(self, "set_current_frame", self._current_frame, 0, anim_duration)
