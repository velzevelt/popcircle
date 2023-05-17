extends Button

signal double_clicked

onready var target = get_parent()

var scale_factor := 1.03
var anim_duration := 0.2

func _on_SongContainer_song_data_changed(new_data):
	text = new_data.name


func _on_SongButton_mouse_entered():
	var new_scale = Vector2(scale_factor, scale_factor)
	var tween = create_tween()
	tween.tween_property(target, 'rect_scale', new_scale, anim_duration)


func _on_SongButton_mouse_exited():
	var tween = create_tween()
	tween.tween_property(target, 'rect_scale', Vector2.ONE, anim_duration)
	


func _gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.doubleclick:
			emit_signal("double_clicked")

