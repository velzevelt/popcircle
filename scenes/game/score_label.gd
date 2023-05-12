extends Label


var prefix := "Score: "
var score := 0

func _ready():
	_update_text()

func _update_text():
	text = prefix + str(score)


func _on_Spawner_task_completed():
	score += 1
	_update_text()
