extends Node

var score = 0
var runTime = 0
var isRunning = true
var bonusSpeed = 0
var speed_per_coin = 10

signal score_change(newScore)
signal on_game_end()

func _process(delta):
	if isRunning:
		runTime += delta

func add_point():
	score += 1
	bonusSpeed = score * speed_per_coin
	score_change.emit(score)
	print(score)

func reset_scene():
	score = 0
	runTime = 0
	isRunning = true
	get_tree().reload_current_scene()

func end_game():
	isRunning = false
	on_game_end.emit()
