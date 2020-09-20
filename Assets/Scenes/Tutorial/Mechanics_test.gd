extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector3()

var level = false

const initial_ball_size = 0.2
onready var music = preload("res://Assets/Music/Loop_Bajos_Tutorial.ogg")

onready var env = preload("res://Assets/Scenes/Tutorial/Space_WEnv.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	$"../WorldEnvironment".set_environment(env)
	$Ball/AnimationPlayer.play("reset_default")
	$"../MusicPlayer".set_stream(music)
	$"../MusicPlayer".play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = $Ball/BallBody.get_linear_velocity()
	$Label.text = 	"x: " + str(velocity.x) +\
					"\ny: " + str(velocity.y) +\
					"\nz: " + str(velocity.z) +\
					"\nvelocity: " + str(velocity.length()) +\
					"\n\nBall radius: " + str($Ball/BallBody/CollisionShape.scale.x) +\
					"\nBall volume: " + str($Ball/BallBody.volume) +\
					"\nBall desired radius: " + str($Ball/BallBody.desired_size) +\
					"\n\nCamera angle: " + str($Ball/BallBody.mov_angle)
	pass

func remove_barrier():
	$Magic_Barrier.queue_free()


func level_change():
	get_parent().change_to_game()


func _on_Ball_ready():
	$Ball.ball_radius = initial_ball_size
	$Ball/BallBody.desired_size = initial_ball_size
	$Ball/BallBody.volume = $Ball/BallBody.radius2volume(initial_ball_size)
	$Ball/BallBody.mass = $Ball/BallBody.volume
	$Ball/BallBody/CollisionShape.scale = initial_ball_size * Vector3.ONE
