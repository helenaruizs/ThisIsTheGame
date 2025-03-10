extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	_transition_called = false
	playback.travel("falling")

func physics_update(delta: float) -> void:
	actor.velocity.y += actor.gravity * delta
	var input_direction_x := Input.get_axis("MoveLeft", "MoveRight")
	actor.velocity.x = actor.speed * input_direction_x
	actor.move_and_slide()

	if actor.is_on_floor():
		finish(LANDING)
