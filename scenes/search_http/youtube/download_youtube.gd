extends Node

signal download_started
signal download_error_occurred
signal download_done(path)

var http_request: HTTPRequest
var _file_token_info: Dictionary
var _download_path: String


func _ready():
	connect("download_error_occurred", self, '_clean_http_request')
	
#	download('https://www.youtube.com/watch?v=lhbA8f5Bf8E',
#		ProjectSettings.globalize_path("user://songs/test.mp3")
#	) # Gangsta paradise
	
#	download('1111',
#		ProjectSettings.globalize_path("user://songs/test.mp3")
#	) # Error test
	

func _clean_http_request():
	http_request.queue_free()
	#breakpoint


func download(url: String, path: String):
	if is_instance_valid(http_request):
		push_warning("Request is busy")
		return
	
	emit_signal("download_started")
	
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.use_threads = true
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
	
	if err != OK:
		push_warning("Request error")
		emit_signal("download_error_occurred")
		return
	
	
	yield(http_request, "request_completed")
	_clean_http_request()


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
	#breakpoint

