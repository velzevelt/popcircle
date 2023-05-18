extends Node

onready var target = get_parent() # Button
onready var search_input = $"%Title"

func _ready():
	target.connect("pressed", self, "_on_button_pressed")

func _on_button_pressed():
	search_input.editable = !search_input.editable


