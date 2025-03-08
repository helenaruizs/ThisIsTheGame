extends Label

@export_enum("FPS") var info_type : int 
var current_FPS : float = 0.0

func _process(delta):
	if info_type == 0:
		text = "FPS: %s" % [Engine.get_frames_per_second()]
