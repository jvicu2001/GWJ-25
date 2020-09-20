extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var level = false

onready var music = preload("res://Assets/Music/Loop_melodia_menu.ogg")

onready var env = preload("res://Assets/Scenes/Tutorial/Space_WEnv.tres")


# Called when the node enters the scene tree for the first time.
func _ready():
	$"../WorldEnvironment".set_environment(env)
	$"VBoxContainer/MarginContainer/HBoxContainer/Play Game".grab_focus()
	$"../MusicPlayer".set_stream(music)
	$"../MusicPlayer".play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
