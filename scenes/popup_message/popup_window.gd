extends Control

export var anim_duration := 0.6
onready var _init_position = rect_position

var _animation_playing := false

func _ready():
	connect("visibility_changed", self, "_on_visibility_changed")
	rect_pivot_offset = rect_size / 2


func _on_visibility_changed():
	if _animation_playing:
		return
	
	if visible:
		rect_position = _init_position
		anim_in()
	else:
		anim_out()


func anim_in():
	_animation_playing = true
	rect_scale = Vector2.ZERO
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self, 'rect_scale', Vector2.ONE, anim_duration)
		
	yield(tween, "finished")
	_animation_playing = false


func anim_out():
	_animation_playing = true
	visible = true
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self, 'rect_scale', Vector2.ZERO, anim_duration)
	
	yield(tween, "finished")
	visible = false
	_animation_playing = false
