extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var def_height = 100
var to_spawn = 20
var safe_distance = 30
var ray_lenght = 800

var min_height = 5
var max_height = 50

var position_arr = []

onready var object_scene = load("res://Actors/Pickups/House_s_broken.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	place_objects()
#	if Engine.editor_hint:
#		place_objects()
	pass # Replace with function body.

func place_objects():
	randomize()
	var space = get_world().direct_space_state
	for _object in range(to_spawn):
		var object_ins = object_scene.instance()
		self.add_child(object_ins)
		object_ins.rotate_y(rand_range(0.0,6.2))
		var valid = false
		while !valid:
			var too_near = false
			
			var rand_pos = Vector2(rand_range(-512, 512), rand_range(-512, 512))
			object_ins.global_transform.origin = Vector3(rand_pos.x, def_height, rand_pos.y)
			var ray = space.intersect_ray(
				object_ins.global_transform.origin,
				object_ins.global_transform.origin + (Vector3.DOWN*ray_lenght),
				[self]
			)
			object_ins.global_transform.origin = ray.position
			
			if object_ins.global_transform.origin.y < min_height ||\
			object_ins.global_transform.origin.y > max_height:
				continue
			
			for pos in position_arr:
				if pos.distance_to(rand_pos) < safe_distance:
					too_near = true
					break
			
			if !too_near:
				position_arr.append(rand_pos)
				valid = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
