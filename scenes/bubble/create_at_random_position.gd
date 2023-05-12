extends Node

onready var target = get_parent()


func get_random_position_on_screen():
	var bounds = get_tree().root.get_size()
	var result = Vector2()
	result.x = randi() % int(bounds.x)
	result.y = randi() % int(bounds.y)
	
	return result

func apply_radius_to_bounds(position: Vector2, radius: float, bounds: Vector2 = get_tree().root.get_size()):
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
