class_name CalculateAccurancy
extends Node

signal accurancy_too_small
signal accurancy_updated(new_accurancy)

## Min accurancy player shoud be to not lose
export var min_accurancy = 51

var accurancy: float = 100.0
var failed = 0
var completed = 0

func update_accurancy():
	accurancy = calculate_accurancy(failed, completed)
	if accurancy < min_accurancy:
		emit_signal("accurancy_too_small")
	
	emit_signal("accurancy_updated", accurancy)


func calculate_accurancy(missed: int, score: int) -> float:
	if missed == 0:
		return 100.0
	
	if missed >= score:
		return 0.0
	
	if score == 0:
		score = 1
	
	var result = float(missed) / float(score) * 100.0 - 100.0
	result = abs(result)
	return result


func _on_Spawner_task_completed():
	completed += 1
	update_accurancy()


func _on_Spawner_task_failed():
	failed += 1
	update_accurancy()
