extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var ball = get_node("../BallBody")

var ball_offset = Vector3(0, 4, 5)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func follow_ball():
	self.global_transform.origin = ball.global_transform.origin\
	 + (ball_offset * ball.get_node("CollisionShape").scale.x)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.look_at(ball.global_transform.origin, Vector3.UP)
	follow_ball()
	pass
