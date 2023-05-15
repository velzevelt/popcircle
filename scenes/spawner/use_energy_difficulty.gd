extends Node

export var min_rate = 1.2
export(NodePath) onready var spectrum = get_node(spectrum)

onready var target: Spawner = get_parent()

func _process(delta):
	target.set_spawn_time(min_rate - spectrum.get_energy())
