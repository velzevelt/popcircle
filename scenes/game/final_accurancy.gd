extends Node

onready var label = $"%AccurancyLabel"


func _on_CalculateAccurancy_final_accurancy_known(accurancy):
	label.text = str(accurancy) + "%"
