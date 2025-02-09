extends CharacterBody3D
class_name Player

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var animated_sprite = $AnimatedSprite3D
@onready var player = $"."
@onready var ray_cast_top = %RayCastTop
@onready var ray_cast_bottom = %RayCastBottom

var z_target: Vector3 = Vector3.ZERO  # Target position
var is_moving_vertically: bool = false  # Whether the character is moving to the target

func _physics_process(delta):
	if ray_cast_top.is_colliding():
		print("Colliding")
		# Set the target when "MoveUp" is pressed
		if Input.is_action_just_pressed("MoveUp"):
			z_target = ray_cast_top.get_collider().global_position
			is_moving_vertically = true

# Move towards the target if is_moving is true
		if is_moving_vertically:
			var direction = global_position.direction_to(z_target)
			var distance = global_position.distance_to(z_target)

# Stop moving if close to the target
			if distance < 0.1:  # Adjust threshold as needed
				velocity = Vector3.ZERO
				is_moving_vertically = false
			else:
				velocity = direction * SPEED

			move_and_slide()
	else:
		is_moving_vertically = false  # Stop moving if no collision
	
	if ray_cast_bottom.is_colliding():
		print("Colliding bottom")
		if Input.is_action_just_pressed("MoveDown"):
			z_target = ray_cast_bottom.get_collider().global_position
			is_moving_vertically = true

# Move towards the target if is_moving is true
		if is_moving_vertically:
			var direction = global_position.direction_to(z_target)
			var distance = global_position.distance_to(z_target)

# Stop moving if close to the target
			if distance < 0.1:  # Adjust threshold as needed
				velocity = Vector3.ZERO
				is_moving_vertically = false
			else:
				velocity = direction * SPEED

			move_and_slide()
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var horizontal_dir = Input.get_axis("MoveLeft", "MoveRight")
	#var direction = (transform.basis * Vector3(horizontal_dir.x, 0, horizontal_dir.y)).normalized()
	
	#Flip sprite horizontally
	if horizontal_dir > 0 :
		animated_sprite.flip_h = false
	elif horizontal_dir < 0 :
		animated_sprite.flip_h = true
	
	
	
	if horizontal_dir:
		velocity.x = horizontal_dir * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	if is_on_floor():
		if horizontal_dir:
			animated_sprite.play("walk")
		if !horizontal_dir:
			animated_sprite.play("idle")
	else:
		animated_sprite.play("jump")
	
	#if velocity.x and velocity.z == 0 :
		#animated_sprite.play("idle")
	#elif velocity.x or velocity.z != 0 :
		#animated_sprite.play("walk")
	
	move_and_slide()
