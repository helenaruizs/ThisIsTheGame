extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.velocity.x = 0.0

#In the physics_update() function, I apply gravity to make the character fall when the floor disappears
#from under them and check for input to transition to the running or jumping state.
func physics_update(_delta: float) -> void:
	player.velocity.y += player.gravity * _delta
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("Jump"):
		finished.emit(JUMPING)
	elif Input.is_action_pressed("MoveLeft") or Input.is_action_pressed("MoveRight"):
		finished.emit(RUNNING)
