extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var tutorial_scene = preload("res://Assets/Scenes/Tutorial/Mechanics_test.tscn")
onready var game_world = preload("res://Assets/Scenes/World_size_01/Game World.tscn")
onready var menu_scene = preload("res://Assets/Scenes/Main Menu/Menu.tscn")

var menu_instance
var tutorial_instance
var game_world_instance


# Called when the node enters the scene tree for the first time.
func _ready():
	menu_instance = menu_scene.instance()
	add_child(menu_instance)

func change_to_game():
	$Transition.color = Color(1.0,1.0,1.0,1.0)
	tutorial_instance.queue_free()
	game_world_instance = game_world.instance()
	add_child(game_world_instance)
	$Transition/AnimationPlayer.play("fade_out")

func reset_level():
	$Transition/AnimationPlayer.play("fade_in")

func play_game():
	game_world_instance = game_world.instance()
	add_child(game_world_instance)
	$Transition/AnimationPlayer.play("fade_out")
	menu_instance.queue_free()

func play_tutorial():
	tutorial_instance = tutorial_scene.instance()
	add_child(tutorial_instance)
	menu_instance.queue_free()

func go_to_menu():
	game_world_instance.queue_free()
	menu_instance = menu_scene.instance()
	add_child(menu_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_in":	# reset_level() continuation
		game_world_instance.queue_free()
		game_world_instance = game_world.instance()
		add_child(game_world_instance)
		$Transition/AnimationPlayer.play("fade_out")
