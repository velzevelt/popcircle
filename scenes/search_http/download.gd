extends Node

onready var converter = MP3Converter.new()

func _ready():
	download("https://www.youtube.com/watch?v=hRsYu6i7XOk&list=RDPgY-Ixs97ic&index=27",
		ProjectSettings.globalize_path("user://songs/test.mp3")
	)

func download(url: String, path: String):
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.use_threads = true
	http_request.connect("request_completed", self, "_on_download_request_completed")
	http_request.download_file = path
	
	var err = http_request.request(converter.get_download_url(url))
	
	if err != OK:
		push_warning("Request error")
	
	# Cleanup
	yield(http_request, "request_completed")
	http_request.queue_free()


func _on_download_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray):
	if result != HTTPRequest.RESULT_SUCCESS:
		push_warning("Download request error")
		return
	


class Converter:
	func get_download_url(url: String) -> String:
		push_error("This method should be overriden")
		return ""


class MP3Converter extends Converter:
	func get_download_url(url) -> String:
		var converter_url = "https://convert2mp3s.com/api/single/{FTYPE}?url={VIDEO_URL}".format(
		{
			"FTYPE": "mp3",
			"VIDEO_URL": url
		})
		
		return converter_url
