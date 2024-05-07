extends CharacterBody2D

const SPEED = 130.0
const DASH_SPEED = SPEED * 1.5
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var dashDirection

@onready var animated_sprite = $AnimatedSprite2D
@onready var jumpSound = $JumpSound
@onready var dash_timer = $DashTimer
@onready var dash_cooldown = $DashCooldown

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jumpSound.play()

	# Get the input direction
	var direction = Input.get_axis("Move Left", "Move Right")
	
	# Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")

	# Check for dash input
	if Input.is_action_just_pressed("Dash") and dash_cooldown.is_stopped():
		dash_timer.start()
		dash_cooldown.start()
		dashDirection = direction
		print("Dash start")
	
	# Handle movement/deceleration
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Add dash speed
	if not dash_timer.is_stopped() and not is_on_floor():
		velocity.x += dashDirection * DASH_SPEED
	
	move_and_slide()
