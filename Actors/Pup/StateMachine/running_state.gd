extends CompanionState

func enter(previous_state_path: String, data := {}) -> void:
	_transition_called = false
	playback.travel("run-horizontal")
#The running state is similar but has extra logic to move the player horizontally.
#Actually, all of these simple states follow a similar pattern:
#they change the animation on enter, have some movement logic in physics_update(), and check for input to transition to another state.
#func enter(previous_state_path: String, data := {}) -> void:
	#player.animation_player.play("run-horizontal")

func physics_update(delta: float) -> void:
	calculate_pathfinding_movement()
	actor.move_and_slide()
	
	if actor.target_reached == true:
		finish(IDLE)
	if not actor.is_on_floor():
		finish(FALLING)
	#elif Input.is_action_just_pressed("Jump"):
		#finish(JUMPING)
