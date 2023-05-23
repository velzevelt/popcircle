class_name SongLoaderStatic
extends Node

var _songs_path: String = "res://songs"
var _user_songs_path: String = "user://songs"
var _path_to_readme_file: String = "res://songs/readme.txt"
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
		print("User songs directory was successfully created")
		
		# Add readme to user songs dir
		if dir.copy(_path_to_readme_file, path.plus_file(_path_to_readme_file.get_file())) != OK:
			push_warning("Readme file for user songs was not added")
		
	else:
		push_error("Cannot create user songs directory %s" % path)



static func load_songs(path: String, extension: String = "mp3") -> Array:
	if not extension.left(0) == ".":
		extension = "." + extension
	
	
	# Godot3 add .import on the end of exported files
	if not OS.has_feature('editor') and not extension.ends_with('.import') and "res://" in path:
		extension += '.import'
	
	
	var result = []
	var dir = Directory.new()

	if dir.open(path) == OK:
		dir.list_dir_begin(true)
		var file_name = dir.get_next()
		
		while not file_name == "":
			var file_path = path + "/" + file_name
			print(file_path)
			
			if dir.current_is_dir():
				result.append_array(load_songs(file_path, extension))
			else:
				if file_name.ends_with(extension):
					
					# Godot3 add .import on the end of exported files, but ResourceLoader cannot recognize those files
					# Need trim from .import from end to fix it
					if not OS.has_feature('editor') and file_name.ends_with('.import'):
						file_path = file_path.trim_suffix('.import')
					
					var song = SongData.new()
					song.path = file_path
					song.name = file_name.trim_suffix(extension)
					song.extension = extension
					song.load_stream()
					
					print(song.stream)
					
					result.append(song)
			
			file_name = dir.get_next()
	else:
		push_error("Can't open songs at " + path)
	
	return result

