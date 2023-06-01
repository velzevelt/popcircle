extends Node

export(NodePath) onready var line_edit = get_node(line_edit)
export var text_key = "WEB_UNSUPPORTED"

var popup_scene = preload("res://scenes/popup_message/popup_message.tscn")
var _popup

func _ready():
	# if not OS.has_feature('JavaScript'): free()
	
	line_edit.connect('focus_entered', self, "_on_LineEdit_focus_entered")


func _on_LineEdit_focus_entered():
	line_edit.editable = false
	
	if _popup == null:
		_popup = popup_scene.instance()
		_popup.rect_size.x += 10
		_popup.rect_size.y += 10
		add_child(_popup)
		_popup.text = tr(text_key)
	
	_popup.show()
