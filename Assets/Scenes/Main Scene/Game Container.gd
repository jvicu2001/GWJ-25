extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var tutorial_scene = preload("res://Assets/Scenes/Tutorial/Mechanics_test.tscn")
onready var game_world = preload("res://Assets/Scenes/World_size_01/Game World.tscn")

var tutorial_instance
var game_world_instance


# Called when the node enters the scene tree for the first time.
func _ready():
	tutorial_instance = tutorial_scene.instance()
	add_child(tutorial_instance)

func change_to_game():
	$Transition.color = Color(1.0,1.0,1.0,1.0)
	tutorial_instance.queue_free()
	game_world_instance = game_world.instance()
	add_child(game_world_instance)
	$Transition/AnimationPlayer.play("fade_out")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
