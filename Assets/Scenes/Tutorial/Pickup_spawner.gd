extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var pickup_scene = preload("res://Actors/Pickup.tscn")

func spawn_pickups():
	for node in get_children():
		var pickup = pickup_scene.instance()
		self.add_child(pickup)
		pickup.global_transform.origin = node.global_transform.origin
		node.queue_free()

func pickups_depleted():
	if get_child_count() == 0:
		return true
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
