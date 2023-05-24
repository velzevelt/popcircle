extends Node

export(NodePath) onready var root = get_node(root)

func _on_LocalSearch_text_entered(new_text):
	root.visible = false
