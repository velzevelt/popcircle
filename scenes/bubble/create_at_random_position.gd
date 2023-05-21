extends Node

onready var target = get_parent()
var _screen_bounds: Vector2 = _get_screen_bounds()

func _get_screen_bounds() -> Vector2:
	var bounds = Vector2()
	bounds.x = ProjectSettings.get_setting('display/window/size/test_width')
	bounds.y = ProjectSettings.get_setting('display/window/size/test_height')
	
	if bounds.x > 0 and bounds.y > 0:
		return bounds
	else:
		bounds.x = ProjectSettings.get_setting('display/window/size/width')
		bounds.y = ProjectSettings.get_setting('display/window/size/height')
		return bounds


func get_random_position_on_screen() -> Vector2:
	var result = Vector2()
	result.x = randi() % int(_screen_bounds.x)
	result.y = randi() % int(_screen_bounds.y)
	
	return result

func apply_radius_to_bounds(position: Vector2, radius: float, bounds: Vector2 = _screen_bounds) -> Vector2:
	if position.x + radius > bounds.x:
		position.x -= radius
	elif position.x - radius < 0:
		position.x += radius
	
	if position.y + radius > bounds.y:
		position.y -= radius
	elif position.y - radius < 0:
		position.y += radius
	
	return position


func _ready():
	var position = get_random_position_on_screen()
	position = apply_radius_to_bounds(position, target.init_radius)
	
	target.global_position = position
