extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var ball = get_node("../BallBody")
onready var ball_collision = ball.get_node("CollisionShape")

onready var underwater_mat = preload("res://Assets/Materials/Water/underwater_shader.tres")

#var ball_offset = Vector3(0, 4, 5)
var ball_base_offset = Vector3(0, 4, 10)
var ball_offset = ball_base_offset

var mouse_mov = Vector2()

var yaw_base_angle = -0.375		# Aprox. angle from offset
var yaw_angle = yaw_base_angle

var v_look = 0.0

var camera_distance = 1.0



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	v_look = (- Input.get_action_strength("player_camera_down") + Input.get_action_strength("player_camera_up"))/2
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED && event is InputEventMouseMotion:
		ball.mov_angle = fmod(ball.mov_angle + event.relative.x/80.0, 2.0*PI)
#		self.yaw_angle = lerp(self.yaw_angle, clamp(self.yaw_angle - event.relative.y/80.0, -1.4, 1.4), 0.2)
		self.yaw_angle = lerp(self.yaw_angle, clamp(self.yaw_angle - event.relative.y/80.0, -0.875, 0.125), 0.2)




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
	
	self.camera_distance = self.global_transform.origin.distance_to($Camera.global_transform.origin)
	
	if $Camera.global_transform.origin.y < 0 && self.owner.get_parent().name == "Level":
		$ColorRect.visible = true
	else:
		$ColorRect.visible = false


func get_yaw_angle():
	if v_look != 0.0:
		self.yaw_angle = lerp(self.yaw_angle, v_look + self.yaw_base_angle, 0.2)
	elif Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED && v_look == 0.0:
		self.yaw_angle = lerp(self.yaw_angle, self.yaw_base_angle, 0.2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	cam_mode_check()
	if Input.is_action_pressed("player_camera_left") || Input.is_action_pressed("player_camera_right"):
		var cam_pan = Input.get_action_strength("player_camera_right") - Input.get_action_strength("player_camera_left")
		ball.mov_angle = fmod(ball.mov_angle + cam_pan/20.0, 2.0*PI)
	ball_offset = rot_matrix_y(ball_base_offset, ball.mov_angle)
	follow_ball()
	get_yaw_angle()
	var front_of_camera = ball.global_transform.origin*Vector3(1,0,1) + Vector3(0, $Camera.global_transform.origin.y, 0)
#	$Camera.look_at(ball.global_transform.origin, Vector3.UP)
#	print((front_of_camera + tan(yaw_angle)*Vector3.UP).y - ball.global_transform.origin.y)
	$Camera.look_at(front_of_camera + tan(yaw_angle)*Vector3.UP*camera_distance, Vector3.UP)
	
	pass
