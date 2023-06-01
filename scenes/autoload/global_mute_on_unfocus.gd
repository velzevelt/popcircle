extends Node

func _ready():
	if not OS.has_feature("JavaScript") and ProjectSettings.get_setting('global/build_for_yandex_games'):
		queue_free()


func _notification(what):
	match what:
		NOTIFICATION_WM_MOUSE_ENTER:
			global_unmute()
		NOTIFICATION_WM_MOUSE_EXIT:
			global_mute()


func global_mute():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)


func global_unmute():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
