extends CanvasLayer

onready var effect = $TransitionEffectCircle

func change_scene_to(scene: PackedScene):
	effect.play()
	yield(effect, "animation_finished")
	effect.play_backwards()
	
	get_tree().change_scene_to(scene)
	get_tree().paused = false


func change_scene(path: String):
	effect.play()
	yield(effect, "animation_finished")
	effect.play_backwards()
	
	get_tree().change_scene(path)
	get_tree().paused = false


func reload_current_scene():
	effect.play()
	yield(effect, "animation_finished")
	effect.play_backwards()
	
	get_tree().reload_current_scene()
	get_tree().paused = false
	

