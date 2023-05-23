extends Node

export(NodePath) onready var target = get_node(target)

func _ready():
	target.call_deferred('update_songs', SongLoader._songs)


func update_songs():
	target.call_deferred('update_songs', SongLoader._songs)


func _on_DownloadYoutube_song_downloaded(song_data):
	SongLoader._songs.append(song_data)
	update_songs()
