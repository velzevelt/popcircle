extends Node2D

signal animation_started
signal animation_finished

export var anim_duration := 1.0
export var circle_color: Color = Color.lightslategray

var _playing := false
var _radius := 0.0
var _circle_position: Vector2 = Vector2.ZERO


func _draw():
	if _playing:
		draw_circle(_circle_position, _radius, circle_color)

func _process(delta):
	update()


func play():
	var mouse_position = get_global_mouse_position()
	var screen_size = get_tree().root.size
	_circle_position = mouse_position
	
	_radius = 0
	var tween = create_tween()
	tween.tween_property(self, '_radius', screen_size.x * 2, anim_duration)
	
	_playing = true
	emit_signal("animation_started")
	
	yield(tween, "finished")
	#_playing = false
	emit_signal("animation_finished")


func play_backwards():
	var tween = create_tween()
	tween.tween_property(self, '_radius', 0, anim_duration)
	
	_playing = true
	emit_signal("animation_started")
	
	yield(tween, "finished")
	_playing = false
	emit_signal("animation_finished")
