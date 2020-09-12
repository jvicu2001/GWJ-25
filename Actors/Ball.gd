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
#	ball_radius = clamp(ball_radius + (10*ball_size_change * delta), 0.2, 100)
#	var current_radius = ball_shape.scale.x
#	if ball_radius != current_radius:
#		var size_lerp = lerp(current_radius, ball_radius, 0.2)
#		ball_shape.scale = Vector3.ONE*size_lerp
	pass

func _physics_process(delta):
	pass
