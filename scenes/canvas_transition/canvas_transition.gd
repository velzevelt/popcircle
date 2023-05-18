extends CanvasLayer

export var anim_duration = 0.3
export var autostart := false

onready var init_offset = offset

func _ready():
	if autostart:
		anim_in()


func anim_in():
	var tween = create_tween()
	tween.tween_property(self, 'offset', Vector2.ZERO, anim_duration)


func anim_out():
	var tween = create_tween()
	tween.tween_property(self, 'offset', init_offset, anim_duration)
