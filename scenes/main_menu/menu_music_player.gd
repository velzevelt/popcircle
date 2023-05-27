extends AudioStreamPlayer

var pause: Resource = preload("res://scenes/main_menu/music_pause.tres")


func _ready():
	connect('finished', self, "_on_playback_finished")
	SceneTransition.connect('scene_about_to_change', self, '_on_scene_about_to_change')
	play(pause.position)


func _on_scene_about_to_change():
	pause.position = get_playback_position()


func _on_playback_finished():
	pause.position = 0.0
	play()
