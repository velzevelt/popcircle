class_name SongData
extends Resource

export var stream: AudioStreamMP3
export var author: String
export var song_name: String
export var tags: PoolStringArray

export var _difficulty_preset: String
export var _player_statistics: String


func get_full_name():
	return author + " - " + song_name
