extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var def_height = 100
var trees_to_spawn = 400
var safe_distance = 10
var ray_lenght = 800

var min_height = 2
var max_height = 69

var position_arr = []

onready var tree_scene = load("res://Actors/Pickups/tree_01.tscn")

onready var tree_model_01 = preload("res://Assets/Objects/Trees/tree_base.obj")
onready var tree_model_02 = preload("res://Assets/Objects/Trees/tree_pine.obj")

var tree_models = [tree_model_01, tree_model_02]


# Called when the node enters the scene tree for the first time.
func _ready():
	place_objects()
#	if Engine.editor_hint:
#		place_objects()
	pass # Replace with function body.


func place_objects():
	randomize()
	var space = get_world().direct_space_state
	for _tree in range(trees_to_spawn):
		var tree_ins = tree_scene.instance()
		self.add_child(tree_ins)
#		tree_ins.get_node("Model").set_mesh(tree_models[randi()%(tree_models.size())])
		tree_ins.rotate_y(rand_range(0.0,6.2))
		var valid = false
		while !valid:
			var too_near = false
			
			var rand_pos = Vector2(rand_range(-512, 512), rand_range(-512, 512))
			tree_ins.global_transform.origin = Vector3(rand_pos.x, def_height, rand_pos.y)
			var ray = space.intersect_ray(
				tree_ins.global_transform.origin,
				tree_ins.global_transform.origin + (Vector3.DOWN*ray_lenght),
				[self]
			)
			tree_ins.global_transform.origin = ray.position
			
			if tree_ins.global_transform.origin.y < min_height ||\
			tree_ins.global_transform.origin.y > max_height:
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
