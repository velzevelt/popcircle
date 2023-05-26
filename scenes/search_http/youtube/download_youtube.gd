extends Node

signal download_started
signal download_error_occurred
signal download_done(path)
signal song_downloaded(song_data)
signal chunk_downloaded(total_downloaded_size, total_size)

var http_request: HTTPRequest
var _file_token_info: Dictionary
var _download_path: String
var _can_get_downloaded_size := false


func _ready():
	connect("download_error_occurred", self, '_clean_http_request')


func _clean_http_request():
	http_request.queue_free()


func cancel_request():
	if is_instance_valid(http_request):
		http_request.cancel_request()
		_clean_http_request()
	


func download(url: String, path: String):
	if is_instance_valid(http_request):
		push_warning("Request is busy")
		return
	
	emit_signal("download_started")
	
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.use_threads = not OS.has_feature('JavaScript') # Multithreading does not work on web
	http_request.connect("request_completed", self, "_on_file_token_info_requested")
	
	# First step get file token and some info
	var headers = ['Content-Type: application/x-www-form-urlencoded; charset=UTF-8']
	var post_body = "url=%s&format=mp3&lang=ru" % url
	var err = http_request.request("https://s61.notube.net/recover_weight.php", headers, true, HTTPClient.METHOD_POST,
	post_body
	)
	
	if err != OK:
		push_warning("Request error")
		emit_signal("download_error_occurred")
		return
	
	yield(http_request, "request_completed")
	http_request.disconnect("request_completed", self, "_on_file_token_info_requested")
	http_request.connect("request_completed", self, "_on_file_conversion_requested")
	
	# Second step send file conversion command to server
	headers = ['Content-Type: application/x-www-form-urlencoded; charset=UTF-8']
	post_body = "token=%s" % _file_token_info['token']
	err = http_request.request("https://s61.notube.net/recover_weight.php", headers, true, HTTPClient.METHOD_POST,
	post_body
	)
	
	if err != OK:
		push_warning("Request error")
		emit_signal("download_error_occurred")
		return
	
	yield(http_request, "request_completed")
	http_request.disconnect("request_completed", self, "_on_file_conversion_requested")
	http_request.connect("request_completed", self, "_on_download_request_completed")
	
	# Third step download file
	headers = []
	_download_path = path
	var get_url = "https://s61.notube.net/download.php?token=%s" % _file_token_info['token']
	err = http_request.request(get_url, headers, true, HTTPClient.METHOD_GET)
	
	# Try to get downloaded size
	_can_get_downloaded_size = true
	
	if err != OK:
		push_warning("Request error")
		emit_signal("download_error_occurred")
		_can_get_downloaded_size = false
		return
	
	
	yield(http_request, "request_completed")
	_can_get_downloaded_size = false
	_clean_http_request()

func _physics_process(delta):
	if _can_get_downloaded_size and is_instance_valid(http_request):
		emit_signal("chunk_downloaded", http_request.get_downloaded_bytes(), http_request.get_body_size())
		

# Get token and some info
func _on_file_token_info_requested(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray):
	if result != HTTPRequest.RESULT_SUCCESS:
		push_warning("Request error DOWNLOAD FILE TOKEN")
		emit_signal("download_error_occurred")
		return
	
	var response_data = body.get_string_from_utf8()
	response_data = JSON.parse(response_data)
	
	if response_data.error == OK:
		_file_token_info = response_data.result
		#breakpoint


# Send file convesion command to server
func _on_file_conversion_requested(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray):
	if result != HTTPRequest.RESULT_SUCCESS:
		push_warning("Request error CONVERSION")
		emit_signal("download_error_occurred")
		return
	


# Download file
func _on_download_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray):
	if result != HTTPRequest.RESULT_SUCCESS:
		push_warning("Download request error")
		emit_signal("download_error_occurred")
		return
	
	for header in headers:
		if header.begins_with('Content-Type'):
			if not 'application/octet-stream' in header:
				emit_signal("download_error_occurred")
				return
	
	var file = File.new()
	file.open(_download_path, File.WRITE)
	file.store_buffer(body)
	file.close()
	
	emit_signal("download_done", _download_path)
	
	var song = SongData.new()
	song.path = _download_path
	song.extension = _download_path.get_extension()
	song.name = _download_path.get_file().trim_suffix("." + song.extension)
	
	song.load_stream()
	emit_signal("song_downloaded", song)
	#breakpoint

