extends Control

signal song_selected(song_data)
signal double_clicked

export var song_button_scene: PackedScene
onready var songs_container = $"%Songs"


func update_songs(new_songs: Array):
	for c in songs_container.get_children():
		c.queue_free()
	
	for song in new_songs:
		var instance = song_button_scene.instance()
		
		instance.song_data = song
		
		instance.connect("song_selected", self, "_on_song_selected")
		instance.connect("double_clicked", self, "_on_double_clicked")
		
		songs_container.call_deferred("add_child", instance)


func _on_song_selected(song_data, sender):
	for c in get_children():
		if c == sender:
			continue
		else:
			c.exit_focus()
	
	
	emit_signal("song_selected", song_data)


func _on_double_clicked():
	emit_signal("double_clicked")


func _on_LocalSearch_text_entered(new_text):
	var text = new_text.to_lower()
	for c in get_children():
		c.visible = text in c.song_data.name.to_lower()


func _on_LocalSearch_text_changed(new_text):
	if new_text == "":
		for c in get_children():
			c.visible = true
		return

