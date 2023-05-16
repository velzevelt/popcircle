extends TextureButton

export var transition_duration := 0.2
export var pressed_color: Color = Color.aquamarine
export var use_global_modulate := false

onready var init_color = self_modulate



func _ready():
	connect("button_down", self, "_on_button_down")
	connect("button_up", self, "_on_button_up")
	
	if use_global_modulate:
		init_color = modulate
	

func _on_button_down():
	var property = 'self_modulate' if not use_global_modulate else 'modulate'
	var tween = create_tween()
	tween.tween_property(self, property, pressed_color, transition_duration)


func _on_button_up():
	var property = 'self_modulate' if not use_global_modulate else 'modulate'
	var tween = create_tween()
	tween.tween_property(self, property, init_color, transition_duration)
