extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlayAgain_pressed():
	$"../../../../../../../AnimationPlayer".play("reset_level_anim")
	get_tree().get_root().get_node("Game Container").reset_level()
	pass # Replace with function body.
