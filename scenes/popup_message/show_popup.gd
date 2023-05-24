extends Node

export(NodePath) onready var target = get_node(target)

func _on_ExitButton_pressed():
	target.visible = true

