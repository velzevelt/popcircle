tool
extends TouchScreenButton

export var _update_shape = false setget _set_update_shape
func _set_update_shape(_value):
	print('Shape updated')
	
	var parent = get_parent()
	
	var circle_shape = CircleShape2D.new()
	circle_shape.radius = parent.radius
	shape = circle_shape
	
	position.x = -parent.radius
	position.y = -parent.radius
