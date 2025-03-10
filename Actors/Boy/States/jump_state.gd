extends PlayerState

#The jumping state changes the player’s vertical velocity on entry to make them jump. It applies gravity each frame to make the player fall back down.
#The state checks if the player is on the floor to transition to the idle state and if the player is falling to transition to the falling state.

func enter(previous_state_path: String, data := {}) -> void:
	_transition_called = false
	actor.velocity.y = -actor.jump_impulse
	actor.velocity.z = 0 # Should we be able to move on z when jumping? Not sure yet
	playback.travel("jump")
	#actor.animation_player.play("jump_start")

func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("MoveLeft", "MoveRight")
	actor.velocity.x = actor.speed * input_direction_x
	actor.velocity.y += actor.gravity * delta
	actor.move_and_slide()

	if abs(actor.velocity.y) < 0.1:
		finish(FALLING)
