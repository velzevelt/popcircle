extends Node

var game_song_data: Resource = preload("res://scenes/game/game_song_data.tres")

var current_song_data: Resource

func play():
	if current_song_data == null:
		return
	
	
	print("PLAY SONG %s" % current_song_data.name)
	game_song_data.name = current_song_data.name
	game_song_data.path = current_song_data.path
	game_song_data.stream = current_song_data.stream
	
	
	get_tree().change_scene("res://scenes/game/game.tscn")
	

func _on_PlayButton_pressed():
	play()


func _on_Songs_double_clicked():
	play()


func _on_Songs_song_selected(song_data):
	current_song_data = song_data
