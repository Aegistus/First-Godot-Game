extends Node

@onready var animated_sprite_2d = $"../../AnimatedSprite2D"

var defaultState = false
var stateType = StateType.DISABLED

func enter():
	animated_sprite_2d.play("idle")
	
func exit():
	pass
	
func process_state(delta):
	pass
	
func process_state_physics(delta):
	pass

func get_next_state():
	return null
