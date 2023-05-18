class_name SongLoaderStatic
extends Node

var _songs_path: String = "res://songs"
var _user_songs_path: String = "user://songs"
var _songs: Array = []


func _ready():
	_check_user_songs_dir(_user_songs_path)
	_songs = load_songs(_songs_path)
	_songs.append_array(load_songs(_user_songs_path))


func _check_user_songs_dir(path: String) -> void:
	var dir = Directory.new()
	
	var err = dir.open(path)
	if err == OK:
		return
	
	push_warning("Cannot open user songs directory %s" % path)
	push_warning("Trying to create new user songs directory")
	err = dir.make_dir(path)
	
	if err == OK:
		push_warning("User songs directory was successfully created")
	else:
		push_error("Cannot create user songs directory %s" % path)



static func load_songs(path: String, extension: String = "mp3") -> Array:
	if not extension.left(0) == ".":
		extension = "." + extension
	
	
	# Godot add .remap on the end of exported files
	
	# WARN If it does not work with user:// path, add another check for that case
	if not OS.has_feature('editor') and not extension.ends_with('.remap') and "res://" in path:
		extension += '.remap'
	
	
	var result = []
	var dir = Directory.new()

	if dir.open(path) == OK:
		dir.list_dir_begin(true)
		var file_name = dir.get_next()
		
		while not file_name == "":
			var file_path = path + "/" + file_name
			
			if dir.current_is_dir():
				result.append_array(load_resources(file_path, extension))
			else:
				if file_name.ends_with(extension):
					
					# Godot add .remap on the end of exported files, but ResourceLoader cannot recognize those files
					# Need trim from .remap from end to fix it
					if not OS.has_feature('editor') and file_name.ends_with('.remap'):
						file_path = file_path.trim_suffix('.remap')
					
					if ResourceLoader.exists(file_path):
						var data = ResourceLoader.load(file_path)
						
						var song = SongData.new()
						song.path = file_path
						song.name = file_name.trim_suffix(extension)
						song.stream = data
						result.append(song)
					else:
						push_warning("%s external file" % file_path)
						
						var stream = null
						if file_path.ends_with("mp3"):
							stream = AudioStreamMP3.new()
						elif file_path.ends_with("ogg"):
							stream = AudioStreamOGGVorbis.new()
						else:
							push_error("%s extension does not recognised or not supported" % extension)
							continue
						
						var file = File.new()
						if file.open(file_path, File.READ) != OK:
							push_error("Cannot open file %s" % file_path)
							continue
						
						stream.data = file.get_buffer(file.get_len())
						file.close()
						
						var song = SongData.new()
						song.path = file_path
						song.name = file_name.trim_suffix(extension)
						song.stream = stream
						result.append(song)
			
			file_name = dir.get_next()
	else:
		push_error("Can't open songs at " + path)
	
	return result



static func load_resources(path: String, resource_name: String) -> Array:
	# Godot add .remap on the end of exported files
	if not OS.has_feature('editor') and not resource_name.ends_with('.remap'):
		resource_name += '.remap'
	
	var result = []
	var dir = Directory.new()

	if dir.open(path) == OK:
		dir.list_dir_begin(true)
		var file_name = dir.get_next()
		
		while not file_name == "":
			var file_path = path + "/" + file_name
			
			if dir.current_is_dir():
				result.append_array(load_resources(file_path, resource_name))
			else:
				if file_name == resource_name:
					
					# Godot add .remap on the end of exported files, but ResourceLoader cannot recognize those files
					# Need trim from .remap from end to fix it
					if not OS.has_feature('editor') and file_name.ends_with('.remap'):
						file_path = file_path.trim_suffix('.remap')
					
					if ResourceLoader.exists(file_path):
						var data = ResourceLoader.load(file_path)
						result.append(data)
					else:
						push_error("Can't load at %s file does't exist" % file_path)
			
			file_name = dir.get_next()
	else:
		push_error("Can't open scenes at " + path)
	
	return result


