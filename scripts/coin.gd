extends Area2D

@onready var animation_player = $AnimationPlayer

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("+1 coin")
	GameManager.add_point()
	animation_player.play("pickup")
