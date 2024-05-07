extends Node

const STOP_SPEED = 130.0

var defaultState = true
var stateType = StateType.IDLE
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var player = $"../.."
@onready var animated_sprite = $"../../AnimatedSprite2D"

func enter():
	animated_sprite.play("idle")
	
func exit():
	pass
	
func process_state(delta):
	pass
	
func process_state_physics(delta):
	if not player.is_on_floor():
		player.velocity.y += gravity * delta
	player.velocity.x = move_toward(player.velocity.x, 0, STOP_SPEED)
	player.move_and_slide()
	
func get_next_state():
	if player.is_on_floor():
		if Input.is_action_just_pressed("Jump"):
			return StateType.JUMPING
		if Input.is_action_pressed("Move Left") or Input.is_action_pressed("Move Right"):
			return StateType.WALKING
		return null
	else:
		return StateType.FALLING

