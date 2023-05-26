class_name ReplayButtonNode
extends Node

onready var target = get_parent() # Button

func _ready():
	target.connect("pressed", self, "_on_pressed")
	

func _on_pressed():
	SceneTransition.reload_current_scene()
