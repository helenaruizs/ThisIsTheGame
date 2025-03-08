extends Node
class_name ZZone

@export var collision_area : Area3D
@export var destination_up : Node3D
@export var destination_down : Node3D

var player : Player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().player
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if player.z_movement_up:
		player.global_position = player.global_position.move_toward(Vector3(player.global_position.x, player.global_position.y, destination_up.global_position.z), player.SPEED)
	if player.z_movement_down:
		player.global_position = player.global_position.move_toward(Vector3(player.global_position.x, player.global_position.y, destination_down.global_position.z), player.SPEED)

func _on_area_3d_body_entered(body):
	player.z_movement_unlocked = true
	print("Body is in the houuuuse")
	

func _on_area_3d_body_exited(body):
	player.z_movement_unlocked = false
	print("Body has left")
