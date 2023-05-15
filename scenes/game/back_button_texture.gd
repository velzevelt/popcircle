extends TextureButton

export var main_menu: PackedScene

func _ready():
	connect("pressed", self, "_on_pressed")


func _on_pressed():
	#get_tree().change_scene("res://scenes/main_menu/main_menu.tscn")
	#get_tree().call_deferred("change_scene_to", main_menu)
	get_tree().change_scene_to(main_menu)
	get_tree().paused = false


func _on_CalculateAccurancy_accurancy_too_small():
	pass
