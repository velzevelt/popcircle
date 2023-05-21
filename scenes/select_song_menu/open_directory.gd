extends Node

var thread: Thread

export(String, DIR) var dir_path: String
onready var target = get_parent() # Button

func _ready():
	target.connect("button_up", self, "open_dir")

func open_dir(path: String = self.dir_path):
	var dir = Directory.new()
	if dir.dir_exists(path):
		if thread == null:
			var global_path = ProjectSettings.globalize_path(path)
			thread = Thread.new()
			thread.start(self, "_foo", global_path)
	else:
		push_error("Songs directory does not exists")


func _foo(path):
	OS.shell_open(path)


func _process(delta):
	if is_instance_valid(thread):
		if not thread.is_alive():
			thread.wait_to_finish()
			thread = null
