extends AudioStreamPlayer


func _on_OneTimePlayer_finished():
	queue_free()
