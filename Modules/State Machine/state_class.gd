extends Node
class_name State

@export var can_move: bool = true

var actor: CharacterBody3D = null
var next_state: State = null
var playback: AnimationNodeStateMachinePlayback

# Emitted when the state finishes and wants to transition to another state.
signal finished(next_state_path: String, data: Dictionary)

# Internal guard to ensure we only emit finished once per activation.
var _transition_called: bool = false

# This base enter() resets the transition guard.
func enter(previous_state_path: String, data := {}) -> void:
	_transition_called = false
	# Subclasses should call .enter() (e.g., via "._enter_impl()") or explicitly reset _transition_called

func exit() -> void:
	# Optional: clear any state-specific variables
	pass

# Use this helper to finish the state. It will only emit the finished signal once.
func finish(next_state_path: String, data: Dictionary = {}) -> void:
	if _transition_called:
		return
	_transition_called = true
	emit_signal("finished", next_state_path, data)

# Called on unhandled input events.
func handle_input(_event: InputEvent) -> void:
	pass

# Called on every main loop tick.
func update(_delta: float) -> void:
	pass

# Called on every physics update tick.
func physics_update(_delta: float) -> void:
	pass
