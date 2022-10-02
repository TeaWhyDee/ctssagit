extends StaticBody

var active: bool

func _physics_process(delta: float):
	if active:
		global_translation = get_tree().get_nodes_in_group("player")[0].global_translation

func _input(event: InputEvent):
	if event.is_action_pressed("action"):
		if not active:
			if get_tree().get_nodes_in_group("player")[0] in $Area.get_overlapping_bodies():
				active = true
				$CollisionShape.disabled = true
				$ButtonSprite.hide()
		else:
			queue_free()
