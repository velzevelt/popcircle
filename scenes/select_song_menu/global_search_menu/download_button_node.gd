extends Node

export(NodePath) onready var request = get_node(request)
onready var target = get_parent() # Button
onready var menu_state = $"%MenuState"

var current_song_data

func _ready():
	target.connect('pressed', self, "download")


func _on_Songs_song_selected(song_data):
	current_song_data = song_data


func _on_Songs_double_clicked():
	download()


func download():
	if menu_state.current_state != MenuState.FREE:
		push_warning('Cannot download, menu busy')
		return
	
	if current_song_data == null:
		push_warning('Empty song data')
		return
	
	var path = "{0}/{1}.{2}".format([SongLoader._user_songs_path, format_title(current_song_data.name), 'mp3'])
	request.download(current_song_data.url, path)


func format_title(video_title: String) -> String:
	var result = video_title
	var forbidden_chars = [
		'/', '\\', '<', '>', '?', '|', '*', ':', "'", '%',
		'=', '#', '&', '{', '}', '$', '!', '@', '+', '`', ',', '.', ';'
	]
	
	for _char in forbidden_chars:
		result = result.replace(_char, ' ')
	
	result = result.strip_edges()
	
	if not result.is_valid_filename():
		result = "song" + str(Time.get_ticks_usec())
	
	assert(result.is_valid_filename())
	
	return result


func _on_DownloadYoutube_download_started():
	menu_state.current_state = MenuState.BUSY


func _on_DownloadYoutube_download_error_occurred():
	push_warning('Download error')
	menu_state.current_state = MenuState.FREE


func _on_DownloadYoutube_download_done(path):
	menu_state.current_state = MenuState.FREE


func _on_DownloadYoutube_song_downloaded(song_data):
	menu_state.current_state = MenuState.FREE
