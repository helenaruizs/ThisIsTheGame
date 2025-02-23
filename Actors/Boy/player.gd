extends CharacterBody3D

class_name Player

@export var speed := 5
@export var gravity := -4
@export var jump_impulse := -2

#const SPEED = 5.0
#const JUMP_VELOCITY = 4.5
#
## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
#@onready var sprite : Sprite3D = $Sprite3D
#@onready var animation_tree : AnimationTree = $AnimationTree
#@export var state_machine : StateMachine
#
#var z_target: Vector3 = Vector3.ZERO  # Target position
#var is_moving_on_z: bool = false  # Whether the character is moving on the Z-axis
#
#func _ready():
	#animation_tree.active = true
#
#func _physics_process(delta):
#
	#
	## Add the gravity.
	#if not is_on_floor():
		#velocity.y -= gravity * delta
		#
	## Handle jump.
	#if Input.is_action_just_pressed("Jump") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
		#
#
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var horizontal_dir = Input.get_axis("MoveLeft", "MoveRight")
	##var direction = (transform.basis * Vector3(horizontal_dir.x, 0, horizontal_dir.y)).normalized()
	#var vertical_dir = Input.get_axis("MoveUp", "MoveDown")
	#
	##Flip sprite horizontally
	#if horizontal_dir > 0 :
		#sprite.flip_h = false
	#elif horizontal_dir < 0 :
		#sprite.flip_h = true
	#
	#
	#
	#if horizontal_dir:
		#velocity.x = horizontal_dir * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#
	#if vertical_dir:
		#velocity.z = vertical_dir * SPEED
	#else:
		#velocity.z = move_toward(velocity.z, 0, SPEED)
	#
	#
	#animation_tree.set("parameters/Move/blend_position", horizontal_dir)
	#
	##if velocity.x and velocity.z == 0 :
		##animated_sprite.play("idle")
	##elif velocity.x or velocity.z != 0 :
		##animated_sprite.play("walk")
	#
	#move_and_slide()
