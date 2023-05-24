extends Node

export(NodePath) onready var root = get_node(root)
onready var menu_state = $"%MenuState"
onready var confirm_close_popup = $"%ConfirmExit"

func _on_CloseMenuButton_pressed():
	if menu_state.current_state == MenuState.FREE:
		close()
	else:
		confirm_close()

func close():
	root.visible = false

func confirm_close():
	confirm_close_popup.visible = true

