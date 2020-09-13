extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mov_input = Vector2()
var desired_size = 1

onready var volume = radius2volume($CollisionShape.scale.x)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func radius2volume(radius):
	return 4.0/3.0 * PI * pow(radius, 3)

func volume2radius(volume):
	return pow((3.0/(4.0*PI))*volume, 1/3.0)

func _input(event):
	mov_input = Vector2(Input.get_action_strength("player_right")
						- Input.get_action_strength("player_left"),
						Input.get_action_strength("player_backwards")
						- Input.get_action_strength("player_forward"))


func pickup(item):
	if item.size < $CollisionShape.scale.x:
		desired_size = volume2radius(item.volume + self.volume)
#		$CollisionShape.scale += item.size*Vector3.ONE
		item.queue_free()
		
	pass

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
		self.angular_damp = 0.0
		add_central_force(8*Vector3(mov_input.x, 0, mov_input.y))
	else:
		self.angular_damp = 0.999999
	pass
