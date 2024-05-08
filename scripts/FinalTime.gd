extends Label

func _ready():
	GameManager.on_game_end.connect(set_clock)

func set_clock():
	var minutes : int = GameManager.runTime / 60
	var seconds := fmod(GameManager.runTime, 60)
	var milliseconds := fmod(GameManager.runTime, 1) * 100
	var time_string := "%02d:%02d:%02d" % [minutes, seconds, milliseconds]
	text = time_string
