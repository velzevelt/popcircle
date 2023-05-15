extends AudioStreamPlayer

export var wait_time := 0.3

func _ready():
	stream = get_tree().current_scene.song_data.stream
	
	yield(get_tree().create_timer(wait_time), "timeout")
	play()
