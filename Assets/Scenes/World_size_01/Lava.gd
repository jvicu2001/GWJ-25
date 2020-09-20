extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var level = $"../.."


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Lava_body_entered(body):
	if body.name == "BallBody":
		level.final_values()
		body.get_parent().get_node("AnimationPlayer").play("fail_anim")
