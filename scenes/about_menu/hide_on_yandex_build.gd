extends Node

onready var target = get_parent()

func _ready():
	if ProjectSettings.get_setting('global/build_for_yandex_games'):
		target.hide()
