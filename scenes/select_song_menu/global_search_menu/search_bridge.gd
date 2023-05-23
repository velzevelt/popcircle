extends Node

export(NodePath) onready var target = get_node(target)
export(NodePath) onready var root = get_node(root)

onready var menu_state = $"%MenuState"

func update_songs(new_songs):
	target.update_songs(new_songs)


func _on_SearchYoutube_search_started():
	menu_state.current_state = MenuState.BUSY
	root.visible = true


func _on_SearchYoutube_search_failed():
	menu_state.current_state = MenuState.FREE


func _on_SearchYoutube_songs_updated(new_songs):
	update_songs(new_songs)
	menu_state.current_state = MenuState.FREE
