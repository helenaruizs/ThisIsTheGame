extends CompanionState

func enter(previous_state_path: String, data := {}) -> void:
	_transition_called = false
	playback.travel("falling")

func physics_update(delta: float) -> void:
	apply_gravity(delta)
	actor.move_and_slide()
	
	if actor.is_on_floor():
		finish(LANDING)
