extends Node2D

@export var flipped = false

const SPEED = 60

@onready var raycast_right = $Raycast_Right
@onready var raycast_left = $Raycast_Left
@onready var animated_sprite = $AnimatedSprite2D

var direction = 1

func _process(delta):
	if not flipped:
		if raycast_right.is_colliding():
			direction = -1
			animated_sprite.flip_h = true
		if raycast_left.is_colliding():
			direction = 1
			animated_sprite.flip_h = false	
	else:
		if raycast_left.is_colliding():
			direction = -1
			animated_sprite.flip_h = true
		if raycast_right.is_colliding():
			direction = 1
			animated_sprite.flip_h = false	
	
	position.x += direction * SPEED * delta
