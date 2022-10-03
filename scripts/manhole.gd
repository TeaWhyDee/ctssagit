extends StaticBody

export var hidden: bool = false
onready var player = get_tree().get_nodes_in_group("player")[0]

func _input(event: InputEvent):
	if event.is_action_pressed("action"):
		if not $Mesh/AnimationPlayer.is_playing():
			if player in $Area.get_overlapping_bodies() and not hidden:
				enter()
			elif hidden:
				exit()

func enter():
	if player.hide_in_manhole(self):
		var dir = global_translation.direction_to(player.global_translation)
		$Mesh.rotation.y = atan2(-dir.z, dir.x) - PI / 2
		$open.play()
		$Mesh/AnimationPlayer.play("open")
		var tween = create_tween()
		tween.tween_property($Prompt, "modulate", Color("#44ffffff"), 0.5)
		hidden = true

func exit():
	$AudioStreamPlayer3D.play()
	player.unmanhole()
	$close.play()
	$Mesh/AnimationPlayer.play("open")
	var tween = create_tween()
	tween.tween_property($Prompt, "modulate", Color.white, 0.5)
	hidden = false
