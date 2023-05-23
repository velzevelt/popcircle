class_name SongData
extends Resource

var name: String
var extension: String
var path: String
var stream setget set_stream, get_stream

func set_stream(value):
	stream = value

func get_stream():
	if stream == null:
		push_warning('Cache missed or broken file %s' % path)
		
	return stream
	

func load_stream():
	var result = null
	
	if ResourceLoader.exists(path):
		result = load(path)
	else:
		var file = File.new()
		if not file.file_exists(path):
			push_warning('File not exists %s' % path)
			return null
		
		push_warning('Loading external song %s' % path)
		if extension.ends_with("mp3"):
			result = AudioStreamMP3.new()
		elif extension.ends_with("ogg"):
			result = AudioStreamOGGVorbis.new()
		elif extension.ends_with("wav"):
			result = AudioStreamSample.new()
		else:
			push_warning('Unknown extension %s' % extension)
			return null
		
		if file.open(path, File.READ) != OK:
			push_warning('Cannot open file')
			return null
		
		result.data = file.get_buffer(file.get_len())
		file.close()
	
	stream = result
