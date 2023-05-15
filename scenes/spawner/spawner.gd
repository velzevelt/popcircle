class_name Spawner
extends Node2D

signal object_spawned
signal object_deleted

signal spawn_rate_changed(new_rate)
signal task_completed
signal task_failed


export var bubble_scene: PackedScene
export var max_objects = 500

onready var spawn_timer = $SpawnTimer as Timer

var spawn_time := 1.0
var spawned_count = 0
var enabled := true

func _ready():
	set_spawn_time(spawn_time)


func spawn():
	if not enabled:
		push_warning('Spawner disabled')
		return
	
	if spawned_count >= max_objects:
		push_warning('Spawn limit reached')
		return
	
	var instance = bubble_scene.instance()
	instance.connect('tasks_completed', self, '_on_task_completed')
	instance.connect('tasks_failed', self, '_on_task_failed')

	spawned_count += 1
	emit_signal("object_spawned")
	call_deferred('add_child', instance)


func _on_task_failed():
	spawned_count -= 1
	emit_signal("object_deleted")
	emit_signal("task_failed")


func _on_task_completed():
	spawned_count -= 1
	emit_signal("object_deleted")
	emit_signal('task_completed')


func set_spawn_time(value: float):
	if value > 0.03: # Too small for timer, need use _process method
		spawn_time = value
		spawn_timer.wait_time = spawn_time
		emit_signal("spawn_rate_changed", spawn_time)
		
		if spawn_timer.paused:
			push_warning("Spawn timer was resumed")
			spawn_timer.start()
	else:
		spawn_timer.stop()


func _process(_delta):
	if spawn_timer.is_stopped() and enabled:
		call_deferred('spawn')


func stop():
	enabled = false
	spawn_timer.stop()


func _on_SpawnTimer_timeout():
	call_deferred('spawn')


func _on_DifficultyUpTimer_timeout():
	set_spawn_time(spawn_time - 0.05)
