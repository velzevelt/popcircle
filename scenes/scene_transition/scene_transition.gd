extends CanvasLayer

export var anim_duration = 0.3
export var autostart := false

onready var init_offset = offset

func _ready():
	if autostart:
		fade_in()


func fade_in():
	var tween = create_tween()
	tween.tween_property(self, 'offset', Vector2.ZERO, anim_duration)


func fade_out():
	var tween = create_tween()
	tween.tween_property(self, 'offset', init_offset, anim_duration)
