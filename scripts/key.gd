extends Area

onready var player = get_tree().get_nodes_in_group("player")[0]

func _input(event: InputEvent):
	if event.is_action_pressed("action"):
		if player in get_overlapping_bodies():
			player.keys += 1
			hide()
			$Sound.play()
			yield(get_tree().create_timer(0.2), "timeout")
			queue_free()
