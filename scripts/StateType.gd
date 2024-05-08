class_name StateType
enum { IDLE, WALKING, JUMPING, DASHING, FALLING, DOUBLEJUMPING, DISABLED, DEAD }

static func get_state_name(stateType):
	match stateType:
		IDLE: return "IDLE"
		WALKING: return "WALKING"
		JUMPING: return "JUMPING"
		DASHING: return "DASHING"
		FALLING: return "FALLING"
		DOUBLEJUMPING: return "DOUBLE JUMPING"
		DISABLED: return "DISABLED"
		DEAD: return "DEAD"
		_: return "UNKNOWN STATE"
