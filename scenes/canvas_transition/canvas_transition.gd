extends CanvasLayer

signal transition_started

export var anim_duration = 0.3
export var autostart := false

onready var init_offset = offset

func _ready():
	if autostart:
		anim_in()


func anim_in():
	emit_signal("transition_started")
	var tween = create_tween()
	tween.tween_property(self, 'offset', Vector2.ZERO, anim_duration)


func anim_out():
	emit_signal("transition_started")
	var tween = create_tween()
	tween.tween_property(self, 'offset', init_offset, anim_duration)
