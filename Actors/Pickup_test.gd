extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var size
var volume

var velocity = Vector3()



# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	size = rand_range(0.5, 2.0)
	volume = 4/3 * PI * pow(size, 3)
	self.scale = size * Vector3(1, 1, 1)
	pass # Replace with function body.


func _physics_process(delta):
	velocity.y -= 9.8*delta
	velocity = move_and_slide(velocity)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
