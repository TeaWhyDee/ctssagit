extends Sprite3D

export var appear_distance: float = 4
onready var player = get_tree().get_nodes_in_group("player")[0]

func _process(_delta):
	opacity = clamp(appear_distance - global_translation.distance_to(player.global_translation), 0, 1)
