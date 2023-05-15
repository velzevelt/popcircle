extends Label

var prefix = "Bubbles: "
var count = 0

func _ready():
	_update_text()
	

func _update_text():
	text = prefix + str(count)



func _on_Spawner_object_spawned():
	count += 1
	_update_text()


func _on_Spawner_object_deleted():
	count -= 1
	if count < 0: # Unkown bug fix, have no time to fix it in properly
		count = 0
	
	_update_text()
