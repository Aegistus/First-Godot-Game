extends Node

const DASH_SPEED = 230
const AIR_MOVE_SPEED = 130.0

var defaultState = false
var stateType = StateType.DASHING
var dashDirection

@onready var player = $"../.."
@onready var animated_sprite = $"../../AnimatedSprite2D"
@onready var dash_timer = $"../../DashTimer"
@onready var dash_sound = $"../../DashSound"
@onready var explosion = $"../../Explosion"

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter():
	animated_sprite.play("dash")
	dash_timer.start()
	dashDirection = Input.get_axis("Move Left", "Move Right")
	if dashDirection > 0:
		animated_sprite.flip_h = false
	elif dashDirection < 0:
		animated_sprite.flip_h = true
	dash_sound.play()
	explosion.emitting = true
	
func exit():
	pass
	
func process_state(delta):
	pass
	
func process_state_physics(delta):
	# gravity
	if not player.is_on_floor():
		player.velocity.y += gravity * delta
	# in-air movement
	var direction = Input.get_axis("Move Left", "Move Right")

	# Handle movement/deceleration
	if direction:
		player.velocity.x = direction * AIR_MOVE_SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, AIR_MOVE_SPEED)
	
	# Add dash speed
	player.velocity.x += dashDirection * DASH_SPEED
	player.move_and_slide()

	
func get_next_state():
	if player.is_on_floor():
		return StateType.IDLE
	elif dash_timer.is_stopped():
		return StateType.FALLING
	else:
		return null
	return null
