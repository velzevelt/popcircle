extends Label

var prefix := "Spawn Rate: "
var rate = 0

func _update_text():
	text = prefix + str(rate)

func _ready():
	_update_text()


func _on_Spawner_spawn_rate_changed(new_rate):
	rate = new_rate
	_update_text()
