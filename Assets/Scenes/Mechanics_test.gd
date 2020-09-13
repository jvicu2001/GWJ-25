extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector3()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = $Ball/BallBody.get_linear_velocity()
	$Label.text = 	"x: " + str(velocity.x) +\
					"\ny: " + str(velocity.y) +\
					"\nz: " + str(velocity.z) +\
					"\n\nFPS:" + str(1/delta) +\
					"\n\nBall radius: " + str($Ball/BallBody/CollisionShape.scale.x)
	pass
