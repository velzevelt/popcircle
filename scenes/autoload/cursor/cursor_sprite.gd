extends Sprite

export var pressed_scale := Vector2(1.4, 1.4)
export var anim_duration := 0.3
onready var init_scale = scale


func _on_just_pressed():
	var tween = create_tween()
	tween.tween_property(self, "scale", pressed_scale, anim_duration)

func _on_just_released():
	var tween = create_tween()
	tween.tween_property(self, "scale", init_scale, anim_duration)


func _on_Cursor_just_pressed():
	_on_just_pressed()


func _on_Cursor_just_released():
	_on_just_released()
