extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const initial_ball_size = 1

var time_limit = 5.0*60.0
var time_left = time_limit

var goal_size = 5
onready var target_volume = $Ball/BallBody.radius2volume(goal_size)

var level = true

var win = false
var lose = false

onready var music = preload("res://Assets/Music/Tema_Final.ogg")

onready var env = preload("res://Assets/Scenes/World_size_01/game_environment.tres")


# Called when the node enters the scene tree for the first time.
func _ready():
	$"../WorldEnvironment".set_environment(env)
	$"../MusicPlayer".set_stream(music)
	$"../MusicPlayer".play()
	$Ball/BallBody.mov_angle = 3.66519
	$Ball/AnimationPlayer.play("reset_default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !win && !lose:
		if time_left > 0.0:
			time_left -= delta
		else:
			lose = true
			$Ball/AnimationPlayer.play("fail_anim")
		if ($Ball/BallBody.volume >= target_volume) && time_left >= 0:
			win = true
			$Ball/AnimationPlayer.play("win_anim")
	else:
		final_values()

func final_values():
	$Ball/UI/ResultContainer/Panel/Results/VBoxContainer/HBoxContainer/TimeLeft.text\
	= $Ball/UI/Timer/time_left.text
	$Ball/UI/ResultContainer/Panel/Results/VBoxContainer/HBoxContainer2/ItemsCollected.text\
	= str($Ball.items_picked_up)
	$Ball/UI/ResultContainer/Panel/Results/VBoxContainer/HBoxContainer5/FinalSize.text\
	= str($Ball/BallBody.desired_size) + "m"

func _on_Ball_ready():
	$Ball.ball_radius = initial_ball_size
	$Ball.goal_size = self.goal_size
	$Ball/BallBody.desired_size = initial_ball_size
	$Ball/BallBody.volume = $Ball/BallBody.radius2volume(initial_ball_size)
	$Ball/BallBody/CollisionShape.scale = initial_ball_size * Vector3.ONE
