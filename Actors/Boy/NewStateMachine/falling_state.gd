extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	playback.travel("falling")

func physics_update(delta: float) -> void:
	player.velocity.y += player.gravity * delta
	var input_direction_x := Input.get_axis("MoveLeft", "MoveRight")
	player.velocity.x = player.speed * input_direction_x
	player.move_and_slide()

	if player.is_on_floor():
		finished.emit(LANDING)
