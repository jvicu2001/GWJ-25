extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var ball = get_node("../BallBody")
onready var ball_collision = ball.get_node("CollisionShape")

#var ball_offset = Vector3(0, 4, 5)
var ball_base_offset = Vector3(0, 4, 10)
var ball_offset = ball_base_offset

var mouse_mov = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseMotion && Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
#		ball_offset = rot_matrix_y(ball_offset, event.relative.x/40.0)
		ball.mov_angle = fmod(ball.mov_angle + event.relative.x/80.0, 2.0*PI)

		
		


func rot_matrix_y(vector, angle):
	return Vector3(vector.x*cos(angle) -vector.z*sin(angle), vector.y, vector.x*sin(angle) + vector.z*cos(angle))

func cam_mode_check():
	if Input.is_action_pressed("camera_mode"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		# camera rotation mode TODO
		pass
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func follow_ball():
	self.global_transform.origin = ball.global_transform.origin#\
	 #+ (ball_offset * ball.get_node("CollisionShape").scale.x)
	var camera_ray = get_world().direct_space_state.intersect_ray(
		self.global_transform.origin,
		self.global_transform.origin + ball_offset * ball_collision.scale.x,
		[self]
	)
	if !camera_ray.empty():
		$Camera.global_transform.origin = camera_ray.position
	else:
		$Camera.global_transform.origin = self.global_transform.origin \
		+ ball_offset * ball_collision.scale.x
	
	if $Camera.global_transform.origin.y < 0:
		$ColorRect.color = Color.white
	else:
		$ColorRect.color = Color(0.0,0.0,0.0,0.0)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cam_mode_check()
	if Input.is_action_pressed("player_camera_left") || Input.is_action_pressed("player_camera_right"):
		var cam_pan = Input.get_action_strength("player_camera_right") - Input.get_action_strength("player_camera_left")
		ball.mov_angle = fmod(ball.mov_angle + cam_pan/20.0, 2.0*PI)
	ball_offset = rot_matrix_y(ball_base_offset, ball.mov_angle)
	follow_ball()
	$Camera.look_at(ball.global_transform.origin, Vector3.UP)
	pass
