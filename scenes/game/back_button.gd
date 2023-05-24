class_name BackButtonNode
extends Node

export var back_scene = preload("res://scenes/main_menu/main_menu.tscn")
onready var target = get_parent() # Button

func _ready():
	target.connect("pressed", self, "_on_pressed")


func _on_pressed():
	get_tree().paused = false
	SceneTransition.change_scene_to(back_scene)
