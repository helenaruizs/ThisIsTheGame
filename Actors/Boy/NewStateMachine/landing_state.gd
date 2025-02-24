extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.velocity.y = 0
	playback.travel("landing")

	#player.animation_player.play("jump_start")
	
#@export var landing_animation : String = "jump_land"
#@export var ground_state : State
#
func _on_animation_tree_animation_finished(anim_name):
	if player.velocity.x != 0 :
		finished.emit(RUNNING)
	else:
		finished.emit(IDLE)
