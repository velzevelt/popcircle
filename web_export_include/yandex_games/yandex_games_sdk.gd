extends Node

func _ready():
	if not ProjectSettings.get_setting('global/build_for_yandex_games'):
		queue_free()
