extends Panel


func _ready():
	visible = false

func _on_CalculateAccurancy_accurancy_too_small():
	get_tree().paused = true
	visible = true


