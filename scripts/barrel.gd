extends StaticBody

const APPEAR_DIST = 4
onready var player = get_tree().get_nodes_in_group("player")[0]

func _process(delta: float):
	$ButtonSprite.opacity = clamp(APPEAR_DIST - global_translation.distance_to(player.global_translation), 0, 1)

func _input(event: InputEvent):
	if event.is_action_pressed("action"):
		if player in $Area.get_overlapping_bodies():
			player.hide_in_barrel()
			queue_free()
