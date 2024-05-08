extends Node

var score = 0
var runTime = 0
signal score_change(newScore)

func _process(delta):
	runTime += delta


func add_point():
	score += 1
	score_change.emit(score)
	print(score)

func reset_scene():
	score = 0
	runTime = 0
	get_tree().reload_current_scene()
