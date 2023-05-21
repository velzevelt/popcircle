extends Node

export(NodePath) onready var slider = get_node(slider)

export var music_bus_name := "Music"
onready var music_bus_id = AudioServer.get_bus_index(music_bus_name)


func _ready():
	slider.value = AudioServer.get_bus_volume_db(music_bus_id)
	slider.connect("value_changed", self, "_on_slider_value_changed")


func _on_slider_value_changed(value):
	AudioServer.set_bus_volume_db(music_bus_id, value)
