extends Node

const url = "https://www.youtube.com/watch?v=dQw4w9WgXcQ?autoplay=1"

var player = preload("res://scenes/one_time_audio_player/one_time_audio_player.tscn")
var thread: Thread


func _input(event):
	if Input.is_action_just_pressed("useful_action"):
		if thread == null:
			if not OS.has_feature("JavaScript"):
				#push_warning('Gen call')
				thread = Thread.new()
				thread.start(self, "_foo")
			else:
				#push_warning('Web call')
				_foo() # Multithreading does not work on web


func _process(delta):
	if is_instance_valid(thread):
		if not thread.is_alive():
			thread.wait_to_finish()
			thread = null


func _exit_tree():
	if is_instance_valid(thread):
		thread.wait_to_finish()


func _foo():
	#OS.shell_open(url)
	var instance = player.instance()
	add_child(instance)
