extends StaticBody

onready var player = get_tree().get_nodes_in_group("player")[0]

func enter():
	$Mesh/AnimationPlayer.play("open")
