extends Node

onready var target = get_parent()

func _on_MenuState_menu_state_changed(new_state):
	target.visible = new_state != MenuState.FREE
	target.text = ""


func _on_DownloadYoutube_chunk_downloaded(total_downloaded_size, total_size):
	var size = total_downloaded_size / 1024.0
	var info_unit = "kb"
	
	if size >= 1024:
		size /= 1024.0
		info_unit = "mb"
	
	size = stepify(size, 0.01)
	target.text = "%s %s" % [size, info_unit]
