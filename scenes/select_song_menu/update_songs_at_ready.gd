extends Node

export(NodePath) onready var target = get_node(target)

func _ready():
	target.call_deferred('update_songs', SongLoader._songs)
