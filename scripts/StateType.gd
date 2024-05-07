class_name StateType
enum { IDLE, WALKING, JUMPING, DASHING, FALLING, DOUBLEJUMPING }

static func get_state_name(stateType):
	match stateType:
		IDLE: return "IDLE"
		WALKING: return "WALKING"
		JUMPING: return "JUMPING"
		DASHING: return "DASHING"
		FALLING: return "FALLING"
		DOUBLEJUMPING: return "DOUBLE JUMPING"
		_: return "UNKNOWN STATE"
