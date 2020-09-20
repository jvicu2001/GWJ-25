extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ball_radius = 1
var goal_size = 5

onready var ball = $BallBody
onready var ball_shape = $BallBody/CollisionShape

onready var is_level = get_parent().level

var items_picked_up = 0


var ball_size_change = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	if !is_level:
		$UI.visible = false
	else:
		$UI.visible = true

func _input(_event):
	ball_size_change = 	Input.get_action_strength("debug_ball_go_big")\
						- Input.get_action_strength("debug_ball_go_smol")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_level:
		$Particles.global_transform.origin = $BallBody.global_transform.origin
		
		var minutes = floor(self.owner.time_left / 60)
		var seconds = floor(self.owner.time_left - minutes*60)
		if seconds < 10:
			seconds = "0" + str(seconds)
		if self.owner.time_left >= 0.0:
			$UI/Timer/time_left.text = str(minutes) +\
			":" + str(seconds)
		
		$UI/size_Label.text = "Goal size: " + str(goal_size*2) + "m" +\
		"\nCurrent size: " + str($BallBody.desired_size*2) + "m"
