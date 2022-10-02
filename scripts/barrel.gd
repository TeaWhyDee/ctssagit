extends StaticBody

onready var player = get_tree().get_nodes_in_group("player")[0]

func _input(event: InputEvent):
	if event.is_action_pressed("action"):
		if player in $Area.get_overlapping_bodies():
			player.hide_in_barrel()
			queue_free()
