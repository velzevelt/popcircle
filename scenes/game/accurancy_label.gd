extends Label

var accurancy := 100.0
var prefix := "Accurancy: "


func _update_text():
	text = prefix + str(accurancy)
	

func _ready():
	_update_text()


func _on_CalculateAccurancy_accurancy_updated(new_accurancy):
	accurancy = new_accurancy
	_update_text()
