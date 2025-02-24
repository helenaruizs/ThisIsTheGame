extends PlayerState

#The jumping state changes the player’s vertical velocity on entry to make them jump. It applies gravity each frame to make the player fall back down.
#The state checks if the player is on the floor to transition to the idle state and if the player is falling to transition to the falling state.

func enter(previous_state_path: String, data := {}) -> void:
	player.velocity.y = -player.jump_impulse
	playback.travel("jump")
	#player.animation_player.play("jump_start")

func physics_update(delta: float) -> void:
	#var input_direction_x := Input.get_axis("MoveLeft", "MoveRight")
	#player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * delta
	player.move_and_slide()

	if player.velocity.y <= 0:
		finished.emit(FALLING)

#class_name AirState
#
#@export var landing_state : State
#@export var landing_animation : String = "jump_land"
#
#func state_process(delta):
	#if(actor.is_on_floor()):
		#next_state = landing_state
#
#func on_exit():
	#if next_state == landing_state:
	#playback.travel(landing_animation)
