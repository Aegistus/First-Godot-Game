extends CharacterBody2D

const SPEED = 130.0
const DASH_SPEED = SPEED * 2.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var dashDirection
var canDash = true
var doubleJump = true
var hasCoyoteTime = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var jumpSound = $JumpSound
@onready var dash_timer = $DashTimer
@onready var coyote_time = $CoyoteTime

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump"):
		if is_on_floor() or not coyote_time.is_stopped():
			jump()
		elif coyote_time.is_stopped() and doubleJump:
			jump()
			doubleJump = false

	# Check for double jump reset
	if is_on_floor():
		doubleJump = true
		canDash = true
		hasCoyoteTime = true
	
	if not is_on_floor() and coyote_time.is_stopped() and not hasCoyoteTime:
		coyote_time.start()
		hasCoyoteTime = true
		
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
	if canDash and not is_on_floor() and Input.is_action_just_pressed("Dash"):
		dash_timer.start()
		dashDirection = direction
		canDash = false
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

func jump():
	velocity.y = JUMP_VELOCITY
	jumpSound.play()
