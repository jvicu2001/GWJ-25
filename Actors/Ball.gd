extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ball_radius = 1

onready var ball = get_node("BallBody")

onready var ball_shape = get_node("BallBody/CollisionShape")

var ball_size_change = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	ball_size_change = 	Input.get_action_strength("debug_ball_go_big")\
						- Input.get_action_strength("debug_ball_go_smol")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	pass
