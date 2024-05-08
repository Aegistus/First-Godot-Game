extends Area2D

@onready var timer = $Timer
@onready var hurt_sound = $"Hurt Sound"

func _on_body_entered(body):
	print("You died")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	body.get_node("StateMachine").kill_player()
	hurt_sound.play()
	timer.start()

func _on_timer_timeout():
	Engine.time_scale = 1
	GameManager.reset_scene()
