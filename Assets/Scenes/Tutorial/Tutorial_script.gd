extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var ball = get_node("../Ball/BallBody")
onready var pickups = get_parent().get_node("Pickups")

var conditions = {
	"moving": false,
	"looking": false,
	"collecting": false
}

var current_condition = ""
var buffer_angle = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$Tutorial_text.text = "Welcome, worker n°" + str(randi() % 16777216)
	$AnimationPlayer.play("intro_01")

func check_conditions_met(condition):
	match condition:
		"moving":
			if ball.mov_input != Vector2():
				conditions[condition] = true
				$AnimationPlayer.play("intro_03")
		"looking":
			if ball.mov_angle != buffer_angle:
				conditions[condition] = true
				$AnimationPlayer.play("intro_04")
		"collecting":
			if pickups.pickups_depleted():
				conditions[condition] = true
				$AnimationPlayer.play("intro_05")
				current_condition = ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_conditions_met(current_condition)


func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"intro_01":
			$AnimationPlayer.play("intro_02")
		"intro_02":
			current_condition = "moving"
		"intro_03":
			buffer_angle = ball.mov_angle
			current_condition = "looking"
		"intro_04":
			current_condition = "collecting"
		"intro_exit":
			get_parent().level_change()


func _on_Exit_Trigger_body_exited(body):
	if body.is_in_group("player"):
		$AnimationPlayer.play("intro_exit")
