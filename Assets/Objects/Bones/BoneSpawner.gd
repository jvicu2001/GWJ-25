extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var def_height = 100
var to_spawn = 300
var safe_distance = 1
var ray_lenght = 800

var min_height = -5
var max_height = 80

var position_arr = []

onready var bone_scene = load("res://Actors/Pickups/BonePile1.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	place_objects()
#	if Engine.editor_hint:
#		place_objects()
	pass # Replace with function body.

func place_objects():
	randomize()
	var space = get_world().direct_space_state
	for bone in range(to_spawn):
		var bone_ins = bone_scene.instance()
		self.add_child(bone_ins)
		var valid = false
		while !valid:
			var too_near = false
			
			var rand_pos = Vector2(rand_range(-512, 512), rand_range(-512, 512))
			bone_ins.global_transform.origin = Vector3(rand_pos.x, def_height, rand_pos.y)
			var ray = space.intersect_ray(
				bone_ins.global_transform.origin,
				bone_ins.global_transform.origin + (Vector3.DOWN*ray_lenght),
				[self]
			)
			bone_ins.global_transform.origin = ray.position
			
			if bone_ins.global_transform.origin.y < min_height ||\
			bone_ins.global_transform.origin.y > max_height:
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
