extends Node

export(NodePath) onready var popup = get_node(popup)

onready var target = get_parent() # Button


func _ready():
	target.connect('pressed', self, "_on_search_button_pressed")


func _on_search_button_pressed():
	popup.visible = true
