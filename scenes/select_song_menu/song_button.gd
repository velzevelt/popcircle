extends Button

signal song_selected(data)

var song_data: Resource


func _ready():
	pass
#	text = song_data.get_full_name()
#	connect("pressed", self, "_on_song_selected")


func _on_song_selected():
	emit_signal("song_selected", song_data)
