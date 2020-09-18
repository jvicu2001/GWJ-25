extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mov_input = Vector2()
var desired_size = 1

var mov_angle = 0

var floor_ray_dist = 0.2

onready var volume = radius2volume($CollisionShape.scale.x)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Simple functions to get the volume of the ball from the radius and viceversa
func radius2volume(radius):
	return 4.0/3.0 * PI * pow(radius, 3)

func volume2radius(vol):
	return pow((3.0/(4.0*PI))*vol, 1/3.0)

# Function to orbit the camera around the center and to rotate the player
# camera accordingly
func rot_matrix_y(vector, angle):
	return Vector3(vector.x*cos(angle) -vector.z*sin(angle), vector.y, vector.x*sin(angle) + vector.z*cos(angle))

func _input(event):
	mov_input = Vector2(Input.get_action_strength("player_right")
						- Input.get_action_strength("player_left"),
						Input.get_action_strength("player_backwards")
						- Input.get_action_strength("player_forward"))

# Triggered by the item to be picked up
# If it's smaller than the ball, it's absorbed
func pickup(item):
	if item.volume < self.volume:
		self.volume += item.volume
		desired_size = volume2radius(self.volume)
		self.mass = self.volume
#		$CollisionShape.scale += item.size*Vector3.ONE
		item.queue_free()
	pass

# lerp the ball size between the actual one and the goal size
func resize():
	if abs($CollisionShape.scale.x - desired_size) > 0.01:
		$CollisionShape.scale = lerp($CollisionShape.scale, desired_size*Vector3.ONE, 0.2)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	resize()
	pass

func _physics_process(delta):
	if mov_input != Vector2():
		self.angular_damp = 0.1
		var rotated_mov = rot_matrix_y(Vector3(mov_input.x, 0, mov_input.y), mov_angle)
		add_central_force(8*rotated_mov*self.mass)
#		if !Input.is_action_pressed("camera_mode"):
#			print(Vector2(self.linear_velocity.x, self.linear_velocity.z).normalized().angle_to(Vector2(rotated_mov.x, rotated_mov.z)))
#			self.mov_angle = fmod(self.mov_angle + Vector2(self.linear_velocity.x, self.linear_velocity.z).normalized().angle_to(Vector2(rotated_mov.x, rotated_mov.z)), 2.0*PI)
	else:
		self.angular_damp = 0.999999
	var floor_ray = get_world().direct_space_state.intersect_ray(
		self.global_transform.origin,
		self.global_transform.origin + Vector3.DOWN*($CollisionShape.scale.x + floor_ray_dist),
		[self]
	)
	if Input.is_action_pressed("player_brake") && !floor_ray.empty():
		self.linear_damp = 1
	else:
		self.linear_damp = 0
	pass
