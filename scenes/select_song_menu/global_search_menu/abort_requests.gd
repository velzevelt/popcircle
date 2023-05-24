extends Node

signal requests_aborted

export(Array, NodePath) var request_handlers
onready var menu_state = $"%MenuState"


func _on_ConfirmPopup_yes_pressed():
	for request_handler in request_handlers:
		request_handler = get_node(request_handler)
		request_handler.cancel_request()
	
	menu_state.current_state = MenuState.FREE
	emit_signal("requests_aborted")
