extends Node2D
@onready var victory_sound = $VictorySound

func _on_area_2d_body_entered(body):
	victory_sound.play()
	GameManager.end_game()
