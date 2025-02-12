extends CharacterBody3D

# === Exported properties ===
@export var movement_speed: int = 250
@export var jump_strength: int = 10
@export var planet_path : NodePath

var gravity: Vector3
var gravity_strength: float = 7
var planet_direction: Vector3 = Vector3.ZERO
var gravity_velocity: Vector3 = Vector3.ZERO
var move_dir: Vector3 = Vector3.ZERO
var rotation_direction: float
var input_direction: Vector2 = Vector2.ZERO

var previously_floored: bool = false

var projected_position: Vector3 = Vector3.ZERO

var jump_single: bool = true
var jump_double: bool = true
var jump_deceleration: float = 10.0
var is_jumping: bool = false

# Variable declared in global scope just to vizualise vectors
# Handle rotation function
var up_dir: Vector3
var current_forward: Vector3
var forward_dir: Vector3
var right_dir: Vector3
var orientation: Basis

# Functions
func _physics_process(delta) -> void:
	
	# Handle functions
	handle_controls(delta)
	apply_gravity(delta)
	#handle_orientation(delta)
	_align_with_gravity()
	
	velocity += gravity_velocity
	
	up_direction = -gravity.normalized()
	move_and_slide()

	planet_direction = gravity.normalized()

# Apply gravity
func apply_gravity(delta) -> void:
	var sphere_node = get_node_or_null(planet_path)
	if sphere_node:
		var dir_to_planet_center: Vector3 = sphere_node.global_transform.origin - global_transform.origin
		gravity = dir_to_planet_center.normalized() * gravity_strength
		gravity_velocity += gravity * delta
		
	# Taking jump into account
	if is_jumping and gravity_velocity.dot(-gravity.normalized()) > 0:
		gravity_velocity += gravity.normalized() * jump_deceleration * delta  # Upward deceleration to get a smooth jump
	else:
		is_jumping = false
		gravity_velocity += gravity * delta

	if is_on_floor():
		gravity_velocity = gravity_velocity.lerp(Vector3.ZERO, 10 * delta)
		jump_single = true
		jump_double = true

# Handle movement input
func handle_controls(delta) -> void:
	input_direction = Vector2.ZERO
	input_direction.x = Input.get_axis("MoveRight", "MoveLeft")
	input_direction.y = Input.get_axis("MoveDown", "MoveUp")
	input_direction = input_direction.normalized()
	

	right_dir = -transform.basis.x
	forward_dir = -transform.basis.z

	move_dir = (forward_dir * input_direction.y + right_dir * input_direction.x).normalized()
	velocity = move_dir * movement_speed * delta
	
	if Input.is_action_just_pressed("jump"):
		if jump_single:
			jump_single = false
			jump_action()
		elif jump_double:
			jump_double = false
			jump_action()

# Jumping
func jump() -> void:
	
	jump_action()
	
	jump_single = false;
	jump_double = true;
	
func jump_action() -> void:
	if is_on_floor() or jump_double:
		gravity_velocity = -gravity.normalized() * jump_strength
		is_jumping = true

#func handle_orientation(delta) -> void:
#
	## Step 1: Align the player with the planet
	#up_dir = -gravity.normalized()
	#current_forward = global_transform.basis.z # This might cause the resetting while leaving keys
#
	## Ensure move_dir is orthogonal to up_dir
	#move_dir = (move_dir - up_dir * move_dir.dot(up_dir)).normalized()
#
	## Calculate a forward direction. If the current forward direction 
	## is almost parallel to up_dir, choose a different reference axis for stability.
	#if abs(current_forward.dot(up_dir)) > 0.98:  # nearly parallel
		#current_forward = global_transform.basis.x  # Use the side vector as a reference
#
	## Make sure the new forward direction is orthogonal to up_dir
	#forward_dir = (current_forward - up_dir * current_forward.dot(up_dir)).normalized()
#
	## Calculate the right direction based on the new forward and up directions
	#right_dir = up_dir.cross(forward_dir).normalized()
#
	## Build the orientation matrix
	#orientation = Basis(right_dir, up_dir, forward_dir)
	#global_transform.basis = orientation
	#
	## Step 2: Build face quaternion so the player always face where it goes
	#var target_transform: Transform3D = Transform3D()
	#
	#if velocity.length() > 0.1:
		#
		#if move_dir != up_dir:
			#target_transform = target_transform.looking_at(move_dir, up_dir, true)
		#
			#var target_quaternion = Quaternion(target_transform.basis)
			#quaternion = quaternion.slerp(target_quaternion, delta * 10)
			#
func _align_with_gravity():
	# Step 1: Align the character's y-axis with the gravity direction
	var new_basis = Basis()
	new_basis.y = -gravity.normalized()  # Align y-axis with gravity

	# Step 2: Preserve the x-axis (parallel to the cylinder's x direction)
	# Project the current x direction onto the horizontal plane
	new_basis.x = transform.basis.x.slide(Vector3(0, 1, 0)).normalized()  # Keep x parallel to cylinder's axis

	# Step 3: Calculate the z-axis as the cross product of y and x to maintain orthogonality
	new_basis.z = new_basis.x.cross(new_basis.y).normalized()

	# Step 4: Apply the new basis to the transform
	transform.basis = new_basis
