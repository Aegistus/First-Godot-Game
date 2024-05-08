extends Node

var states = []
var currentState

func _ready():
	states = get_children()
	for state in states:
		if state.defaultState:
			currentState = state
			currentState.enter()
	GameManager.on_game_end.connect(disable_player)

func _process(delta):
	currentState.process_state(delta)
	var nextStateType = currentState.get_next_state()
	if nextStateType != null:
		print(StateType.get_state_name(nextStateType))
		var nextState = get_state_of_type(nextStateType)
		currentState.exit()
		currentState = nextState
		currentState.enter()

func _physics_process(delta):
	currentState.process_state_physics(delta)

func get_state_of_type(stateType):
	for state in states:
		if state.stateType == stateType:
			return state

func disable_player():
	currentState.exit()
	var nextState = get_state_of_type(StateType.DISABLED)
	currentState = nextState
	currentState.enter()
