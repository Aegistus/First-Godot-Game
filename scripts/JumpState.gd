extends Node

const JUMP_VELOCITY = -300.0
const AIR_MOVE_SPEED = 130.0

var defaultState = false
var stateType = StateType.JUMPING

@onready var player = $"../.."
@onready var animated_sprite = $"../../AnimatedSprite2D"
@onready var jumpSound = $"../../JumpSound"

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter():
	animated_sprite.play("jump")
	player.velocity.y = JUMP_VELOCITY
	jumpSound.play()
	
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
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	# Handle movement/deceleration
	if direction:
		player.velocity.x = direction * (AIR_MOVE_SPEED + GameManager.bonusSpeed)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, AIR_MOVE_SPEED)
	player.move_and_slide()

	
func get_next_state():
	if player.is_on_floor():
		return StateType.IDLE
	if Input.is_action_just_pressed("Dash"):
		return StateType.DASHING
	if Input.is_action_just_pressed("Jump"):
		return StateType.DOUBLEJUMPING
	return null
