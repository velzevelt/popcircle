extends Node2D

signal finished

var song_data: Resource = preload("res://scenes/game/game_song_data.tres")

export var main_menu: PackedScene
export var finish_wait_time := 0.4


func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		#get_tree().change_scene("res://scenes/menu/main_menu.tscn")
		get_tree().change_scene_to(main_menu)
		#get_tree().call_deferred("change_scene_to", main_menu)




func _on_MusicPlayer_finished():
	var spawners = get_tree().get_nodes_in_group('spawner')
	for spawner in spawners:
		spawner.stop()
	
	var remain_bubbles = get_tree().get_nodes_in_group('bubble')
	for bubble in remain_bubbles:
		bubble._handle_click()
	
	
	yield(get_tree().create_timer(finish_wait_time), "timeout")
	emit_signal('finished')
	get_tree().paused = true

