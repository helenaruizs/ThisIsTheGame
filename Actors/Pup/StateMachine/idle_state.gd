extends CompanionState

func enter(previous_state_path: String, data := {}) -> void:
	_transition_called = false
	actor.velocity.x = 0.0
	actor.velocity.z = 0.0
	#playback.travel("move")

#In the physics_update() function, I apply gravity to make the character fall when the floor disappears
#from under them and check for input to transition to the running or jumping state.
func physics_update(_delta: float) -> void:
	playback.travel("idle")
	calculate_pathfinding_movement()
	apply_gravity(_delta)
	actor.move_and_slide()

	if not actor.is_on_floor():
		finish(FALLING)
	elif actor.velocity.x != 0:
		finish(RUNNING)
