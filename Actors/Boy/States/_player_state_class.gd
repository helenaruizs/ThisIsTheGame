extends State
class_name PlayerState

# States
const IDLE : String = "Idle"
const RUNNING : String = "Running"
const JUMPING : String = "Jumping"
const FALLING : String = "Falling"
const LANDING : String = "Landing"

# Animations
const IDLE_ANIM : String = "idle"
const RUNNING_ANIM : String = "run-horizontal"
const JUMPING_ANIM : String = "jump"
const FALLING_ANIM : String = "falling"
const LANDING_ANIM : String = "landing"


var player: Player

func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
	actor = player
