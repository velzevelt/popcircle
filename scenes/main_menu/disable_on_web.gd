extends Node

export(NodePath) onready var line_edit = get_node(line_edit)
export var text_key = "PLATFORM_UNSUPPORTED"

var popup_scene = preload("res://scenes/popup_message/popup_message.tscn")
var _popup

func _ready():
	# 2) Remote download does not work on web due to cors (To fix this need use working cors proxy)
	if not OS.has_feature('JavaScript'): 
		queue_free() 
		return
	
	line_edit.connect('focus_entered', self, "_on_LineEdit_focus_entered")


func _on_LineEdit_focus_entered():
	line_edit.editable = false
	
	if _popup == null:
		_popup = popup_scene.instance()
		_popup.rect_size.x += 10
		_popup.rect_size.y += 10
		add_child(_popup)
		var text = tr(text_key).format({"platform_name": OS.get_name()})
		_popup.text = text
	
	_popup.show()
