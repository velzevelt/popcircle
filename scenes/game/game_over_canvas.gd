extends CanvasLayer

export var anim_duration = 0.3

func fade_in():
	var tween = create_tween()
	tween.tween_property(self, 'offset', Vector2.ZERO, anim_duration)

func _on_CalculateAccurancy_accurancy_too_small():
	fade_in()


func _on_World_finished():
	fade_in()
