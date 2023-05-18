extends Control

signal double_clicked
signal song_selected(song_data, sender)
signal song_data_changed(new_data)

onready var song_button = $SongButton

var song_data: Resource setget set_song_data, get_song_data

func get_song_data():
	return song_data

func set_song_data(value: Resource):
	assert(value is SongData, "Expected SongData")
	
	song_data = value
	emit_signal("song_data_changed", song_data)


func exit_focus():
	song_button.pressed = false

func _on_SongButton_toggled(button_pressed):
	if button_pressed:
		emit_signal("song_selected", song_data, self)


func _on_SongButton_double_clicked():
	emit_signal("song_selected", song_data, self)
	emit_signal("double_clicked")


func _ready():
	rect_pivot_offset = rect_size / 2
