extends Node

const SPEED = 130.0

var defaultState = false
var stateType = StateType.WALKING
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $"../../AnimatedSprite2D"
@onready var player = $"../.."

func enter():
	animated_sprite.play("run")
	
func exit():
	pass
	
func process_state(delta):
	pass
	
func process_state_physics(delta):
	# add gravity
	if not player.is_on_floor():
		player.velocity.y += gravity * delta
	var direction = Input.get_axis("Move Left", "Move Right")
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	# Handle movement/deceleration
	if direction:
		player.velocity.x = direction * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
	player.move_and_slide()
	
func get_next_state():
	if player.is_on_floor():
		if Input.is_action_just_pressed("Jump"):
			return StateType.JUMPING
		if not Input.is_action_pressed("Move Left") and not Input.is_action_pressed("Move Right"):
			return StateType.IDLE
		return null
	else:
		return StateType.FALLING
