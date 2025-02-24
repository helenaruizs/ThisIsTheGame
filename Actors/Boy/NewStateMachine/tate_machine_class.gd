extends Node

class_name StateMachine

@export var starting_state: State = null ## Hook up to the initial state (usually idle)
@onready var current_state = starting_state

@export var actor : CharacterBody3D
var animation_tree : AnimationTree = null

var state_groups : Array[Node]
var states : Array[State]

func _ready():
	
	await owner.ready
	animation_tree = actor.animation_tree
	# Collect state group nodes (like "Ground", "Air", etc.)
	for child in get_children():
		# Assuming your groups are nodes that are not State
		if not (child is State):
			state_groups.append(child)
		else:
			# Optionally handle direct state nodes if needed
			states.append(child)
			child.actor = actor
			child.playback = animation_tree["parameters/playback"]

	# Iterate over each group and set up the states inside them
	for group in state_groups:
		for grandchild in group.get_children():
			if grandchild is State:
				states.append(grandchild)
				grandchild.actor = actor
				grandchild.playback = animation_tree["parameters/playback"]
				#We can use Godot’s find_children() function to get all the states and connect to their finished signal to transition to the next state
				grandchild.finished.connect(_transition_to_next_state)
			else:
				push_warning("Child " + grandchild.name + " is not a State for the Character State Machine")
	

	current_state.enter("")
	
func _unhandled_input(event: InputEvent) -> void:
	current_state.handle_input(event)


func _process(delta: float) -> void:
	current_state.update(delta)


func _physics_process(delta: float) -> void:
	print(current_state)
	print(actor.velocity.y)
	current_state.physics_update(delta)

#Here’s the _transition_to_next_state() function. It changes the active state when the state emits the signal.
func _transition_to_next_state(target_state: String, data: Dictionary = {}) -> void:
	var new_state: State = null
	
	# Loop through the states array to find a state with the matching name.
	for state in states:
		if state.name == target_state:
			new_state = state
			break
	
	# If no matching state was found, print an error and return.
	if new_state == null:
		printerr(owner.name + ": Trying to transition to state " + target_state + " but it does not exist.")
		return

	var previous_state_name: String = current_state.name
	current_state.exit()
	current_state = new_state
	current_state.enter(previous_state_name, data)
