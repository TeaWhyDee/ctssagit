extends Spatial

onready var player = get_tree().get_nodes_in_group("player")[0]


func _ready():
	Global.connect("timeout", self, "_on_timeout")
	sleep()


func sleep():
	$sleep/AnimationPlayer.get_animation("sleep-loop").set_loop(true)
	$sleep/AnimationPlayer.play("sleep-loop")

func wakeup():
	$wakeup/AnimationPlayer.play("wakeup")
	$sleep.visible = false


func _on_timeout():
	if not player.manholed and not player.barrel_mode:
		wakeup()
