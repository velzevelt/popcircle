extends Node

signal search_started
signal search_failed
signal songs_updated(new_songs)

const API_KEY_PATH = "res://private/youtube_api_key.txt"
onready var api_key = get_api_key()

var search_data: Dictionary setget set_search_data, get_search_data
func set_search_data(value):
	search_data = value
	songs = update_songs()
	emit_signal("songs_updated", songs)
func get_search_data():
	return search_data

var songs: Array setget , update_songs


func update_songs() -> Array:
	var result = []
	if search_data.has('items'):
		for video in search_data['items']:
			var video_id = video['id']['videoId']
			var title = video['snippet']['title']
			var url = get_video_url(video_id)
			
			var song = Song.new()
			song.video_id = video_id
			song.title = title
			song.url = url
			
			result.append(song)
	else:
		push_error('Search data does not have "items", cannot parse...')
	
	return result


func get_api_key() -> String:
	var file = File.new()
	assert(file.file_exists(API_KEY_PATH), "Cant find %s" % API_KEY_PATH)
	
	file.open(API_KEY_PATH, File.READ)
	var key = file.get_as_text()
	file.close()
	return key


func search(song_name: String) -> void:
	assert(song_name != '', 'Empty search request')
	
	emit_signal('search_started')
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.use_threads = not OS.has_feature('JavaScript') # Multithreading does not work on web
	http_request.connect("request_completed", self, "_on_search_request_completed")
	var err = http_request.request(get_request_url(song_name))
	
	if err != OK:
		push_warning("Request Error")
		emit_signal('search_failed')
	
	# Cleanup
	yield(http_request, "request_completed")
	http_request.queue_free()


func _on_search_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray):
	if result != HTTPRequest.RESULT_SUCCESS:
		push_warning("Http error: result {0}, response_code {1}".format([result, response_code]))
		emit_signal('search_failed')
		return
	
	var data = body.get_string_from_utf8()
	var parsed = JSON.parse(data)
	
	if parsed.error == OK:
		self.search_data = parsed.result
	else:
		push_warning("JSON parse error")
		emit_signal('search_failed')
	


# https://youtube.googleapis.com/youtube/v3/search?part=snippet&q=hello%20world&type=video&key=[YOUR_API_KEY]
func get_request_url(song_name: String, max_results := 10, api_key: String = self.api_key) -> String:
	song_name = song_name.strip_edges()
	song_name = song_name.replace(" ", "%20")
	var url = "https://youtube.googleapis.com/youtube/v3/search?part=snippet&regionCode=US&maxResults={max_results}&q={song_name}&type=video&key={api_key}"
	url = url.format(
		{
			"max_results": max_results, 
			"song_name": song_name,
			"api_key": api_key
		})
	
	return url


# https://www.youtube.com/watch?v=${result.id.videoId}
func get_video_url(video_id: String) -> String:
	var url = "https://www.youtube.com/watch?v=%s" % video_id
	return url



