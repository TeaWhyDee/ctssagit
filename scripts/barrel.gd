extends StaticBody

var entered: bool
onready var player = get_tree().get_nodes_in_group("player")[0]

func _input(event: InputEvent):
	if event.is_action_pressed("action"):
		if player in $Area.get_overlapping_bodies() and not entered:
			enter()
		elif entered:
			exit()

func enter():
	player.hide_in_barrel(self)
	$CollisionShape.disabled = true
	$Prompt.hide()
	$barrel.hide()
	entered = true

func exit():
	global_translation = player.global_translation
	global_rotation.y = player.global_rotation.y + PI / 2
	$CollisionShape.disabled = false
	$Prompt.show()
	$barrel.show()
	player.unbarrel()
	entered = false
