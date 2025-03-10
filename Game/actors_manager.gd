extends Node

@export var main_actor : Player = null
@export var companion : Companion = null

func _physics_process(delta):
	companion.update_target_location(main_actor.global_transform.origin)
