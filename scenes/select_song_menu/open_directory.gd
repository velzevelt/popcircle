extends Node

export(String, DIR) var dir_path: String
onready var target = get_parent() # Button

func _ready():
	target.connect("button_up", self, "open_dir")

func open_dir(path: String = self.dir_path):
	var dir = Directory.new()
	
	if dir.dir_exists(path):
		OS.shell_open(ProjectSettings.globalize_path(path))
