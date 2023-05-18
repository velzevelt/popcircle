extends Node

onready var watcher = get_parent() as DirectoryWatcher
onready var dir_path = $"%OpenDirectory".dir_path

func _ready():
	watcher.add_scan_directory(dir_path)


func _on_SongsDirWatcher_files_created(files):
	print()
