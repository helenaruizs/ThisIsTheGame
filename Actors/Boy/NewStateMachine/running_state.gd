extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	playback.travel("run")
#The running state is similar but has extra logic to move the player horizontally.
#Actually, all of these simple states follow a similar pattern:
#they change the animation on enter, have some movement logic in physics_update(), and check for input to transition to another state.
#func enter(previous_state_path: String, data := {}) -> void:
	#player.animation_player.play("run-horizontal")

func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("MoveLeft", "MoveRight")
	var input_direction_z := Input.get_axis("MoveUp", "MoveDown")
	player.velocity.x = player.speed * input_direction_x
	player.velocity.z = player.speed * input_direction_z
	player.velocity.y += player.gravity * delta
	player.animation_tree.set(player.blend_pos, Vector2(player.velocity.x, player.velocity.z))
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("Jump"):
		finished.emit(JUMPING)
	if player.velocity == Vector3.ZERO:
		finished.emit(IDLE)
