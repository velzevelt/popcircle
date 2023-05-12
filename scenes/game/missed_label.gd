extends Label


var count := 0
var prefix := "Missed: "

func _update_text():
	text = prefix + str(count)
	
func _ready():
	_update_text()



func _on_Spawner_task_failed():
	count += 1
	_update_text()
