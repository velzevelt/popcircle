class_name SongLoaderStatic
extends Node

var _songs_path: String = "res://songs"
var _songs: Array = []

func _ready():
	#_songs = load_resources(_songs_path, SONG_DATA_FILE_NAME)
	_songs = load_songs(_songs_path, "mp3")
	


static func load_songs(path: String, extension: String = "mp3") -> Array:
	if not extension.left(0) == ".":
		extension = "." + extension
	
	
	# Godot add .remap on the end of exported files
	if not OS.has_feature('editor') and not extension.ends_with('.remap'):
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
						push_error("Can't load at %s file does't exist" % file_path)
			
			file_name = dir.get_next()
	else:
		push_error("Can't open scenes at " + path)
	
	return result


static func load_resources_by_extension(path: String, extension: String) -> Array:
	# Godot add .remap on the end of exported files
	if not OS.has_feature('editor') and not extension.ends_with('.remap'):
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
						result.append(data)
					else:
						push_error("Can't load at %s file does't exist" % file_path)
			
			file_name = dir.get_next()
	else:
		push_error("Can't open scenes at " + path)
	
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


func reload_scene():
	#Logger.debug_log('Reloading current scene...')
	get_tree().reload_current_scene()
