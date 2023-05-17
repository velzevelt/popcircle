class_name PressColorTintNode
extends Node


export var transition_duration := 0.2
export var pressed_color: Color = Color.aquamarine
export var use_global_modulate := false

onready var target = get_parent() # Button
onready var init_color = target.self_modulate



func _ready():
	target.connect("button_down", self, "_on_button_down")
	target.connect("button_up", self, "_on_button_up")
	
	if use_global_modulate:
		init_color = target.modulate
	

func _on_button_down():
	var property = 'self_modulate' if not use_global_modulate else 'modulate'
	var tween = create_tween()
	tween.tween_property(target, property, pressed_color, transition_duration)


func _on_button_up():
	var property = 'self_modulate' if not use_global_modulate else 'modulate'
	var tween = create_tween()
	tween.tween_property(target, property, init_color, transition_duration)
