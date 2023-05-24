extends CanvasLayer

var cursor_texture = preload("res://sprites/cursor_default.svg")
onready var size: Vector2 = cursor_texture.get_size() setget set_size, get_size


func set_size(value):
	if value.x <= 0 or value.y <= 0 or value.x > 64 or value.y > 64:
		push_warning('Invalid cursor size, using standart size')
		value = cursor_texture.get_size()
	
	size = value
	_resize_cursor(size)


func get_size():
	return size


func _ready():
	_resize_cursor(Vector2(32, 32))


func _resize_cursor(size: Vector2):
	var cursor = cursor_texture.get_data()
	cursor.resize(size.x, size.y, Image.INTERPOLATE_LANCZOS)
	
	var texture = ImageTexture.new()
	texture.create_from_image(cursor)
	
	_set_cursor(texture)


func _set_cursor(texture):
	Input.set_custom_mouse_cursor(texture, Input.CURSOR_ARROW, texture.get_size() / 2)
