extends Node

export(NodePath) onready var root = get_node(root)
onready var menu_state = $"%MenuState"

func _on_CloseMenuButton_pressed():
	if menu_state.current_state != MenuState.FREE:
		push_warning('Cannot close, menu is busy')
		return
	
	root.visible = false
