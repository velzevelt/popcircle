extends Label

export(NodePath) onready var target = get_node(target)


func _ready():
	target.connect("value_changed", self, "_on_slider_value_changed")
	_on_slider_value_changed(target.value)

func _on_slider_value_changed(value):
	value = round(100 - value / target.min_value * 100.0)
	text = str(value)
