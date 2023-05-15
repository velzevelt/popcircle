class_name CalculateAccurancy
extends Node

signal accurancy_too_small
signal accurancy_updated(new_accurancy)

## Min accurancy player must keep
export var min_accurancy = 51

var accurancy: float = 100.0


var failed = 0

func update_accurancy():
	accurancy = calculate_accurancy()
	if accurancy < min_accurancy:
		emit_signal("accurancy_too_small")
	
	emit_signal("accurancy_updated", accurancy)

func calculate_accurancy() -> float:
	return calculate_true_accurancy(failed, 4*2) # 4 attempts before loose


func calculate_true_accurancy(missed: int, score: int) -> float:
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
	failed -= 1
	if failed < 0:
		failed = 0
	
	update_accurancy()


func _on_Spawner_task_failed():
	failed += 1
	update_accurancy()
