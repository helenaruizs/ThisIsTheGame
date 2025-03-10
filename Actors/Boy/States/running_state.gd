extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	_transition_called = false
	playback.travel("run")
#The running state is similar but has extra logic to move the player horizontally.
#Actually, all of these simple states follow a similar pattern:
#they change the animation on enter, have some movement logic in physics_update(), and check for input to transition to another state.
#func enter(previous_state_path: String, data := {}) -> void:
	#player.animation_player.play("run-horizontal")

func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("MoveLeft", "MoveRight")
	var input_direction_z := Input.get_axis("MoveUp", "MoveDown")
	actor.velocity.x = actor.speed * input_direction_x
	actor.velocity.z = actor.speed * input_direction_z
	actor.velocity.y += actor.gravity * delta
	actor.animation_tree.set(actor.blend_pos, Vector2(actor.velocity.x, actor.velocity.z))
	actor.move_and_slide()

	if not actor.is_on_floor():
		finish(FALLING)
	elif Input.is_action_just_pressed("Jump"):
		finish(JUMPING)
	if actor.velocity == Vector3.ZERO:
		finish(IDLE)
