extends CompanionState

func enter(previous_state_path: String, data := {}) -> void:
	_transition_called = false
	actor.velocity.y = 0
	playback.travel("landing")

func _on_animation_tree_animation_finished(anim_name):
	if actor.velocity.x != 0 :
		finish(RUNNING)
	else:
		finish(IDLE)
