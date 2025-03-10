extends State
class_name CompanionState

#Functions to update pathfinding
func calculate_pathfinding_movement():
	var current_location = actor.global_transform.origin
	var next_location = actor.nav_agent.get_next_path_position()
	var distance_to_target = next_location - current_location
	var new_velocity = (distance_to_target).normalized() * actor.speed
	
	if actor.nav_agent.distance_to_target() <= actor.nav_agent.path_max_distance:
		actor.target_reached = true
	else:
		actor.target_reached = false
	
	actor.velocity = actor.velocity.move_toward(new_velocity, .25)
