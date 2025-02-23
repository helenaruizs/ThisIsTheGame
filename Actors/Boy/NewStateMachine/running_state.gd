extends PlayerState

#The running state is similar but has extra logic to move the player horizontally.
#Actually, all of these simple states follow a similar pattern:
#they change the animation on enter, have some movement logic in physics_update(), and check for input to transition to another state.
#func enter(previous_state_path: String, data := {}) -> void:
	#player.animation_player.play("run-horizontal")

func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("MoveLeft", "MoveRight")
	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * delta
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("Jump"):
		finished.emit(JUMPING)
	elif is_equal_approx(input_direction_x, 0.0):
		finished.emit(IDLE)
