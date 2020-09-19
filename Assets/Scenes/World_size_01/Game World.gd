extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const initial_ball_size = 0.1
onready var music = preload("res://Assets/Music/Game_base.wav")


# Called when the node enters the scene tree for the first time.
func _ready():
#	$"../MusicPlayer".set_stream(music)
#	$"../MusicPlayer".play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Ball_ready():
	$Ball.ball_radius = initial_ball_size
	$Ball/BallBody.desired_size = initial_ball_size
	$Ball/BallBody.volume = $Ball/BallBody.radius2volume(initial_ball_size)
	$Ball/BallBody/CollisionShape.scale = initial_ball_size * Vector3.ONE
