extends StaticBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var volume = 2


# Called when the node enters the scene tree for the first time.
func _ready():
	
#	place_on_floor()
	pass # Replace with function body.

func place_on_floor():
	global_transform.origin = get_world().direct_space_state.intersect_ray(
	global_transform.origin,
	global_transform.origin + 500*Vector3.DOWN,
	[self]
	).position

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
