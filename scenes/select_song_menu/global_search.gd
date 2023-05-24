extends Node

export(NodePath) onready var root = get_node(root)
export(NodePath) onready var request = get_node(request)

func _on_GlobalSearch_text_entered(new_text):
	request.search(new_text)
	root.visible = false


func _on_LocalSearch_text_entered(new_text):
	pass # Replace with function body.
