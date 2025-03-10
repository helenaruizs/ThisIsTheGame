extends CharacterBody3D

class_name Companion

@onready var nav_agent = $NavigationAgent3D

@export var sprite : Sprite3D

@export var speed : float = 1.0
@export var gravity := -4
@export var jump_impulse := -2

@export var animation_tree : AnimationTree

var blend_pos : String = "parameters/run/blend_position"

var target_reached : bool = false

func _physics_process(delta):
	print(nav_agent.target_position)
	print(nav_agent.get_next_path_position())
	#print(velocity)
	
		##Flip sprite horizontally
	if velocity.x > 0 :
		sprite.flip_h = false
	elif velocity.x < 0 :
		sprite.flip_h = true


func update_target_location(target_location):
	nav_agent.target_position = target_location
