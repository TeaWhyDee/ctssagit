extends StaticBody

signal activated
var active: bool
onready var player = get_tree().get_nodes_in_group("player")[0]

func _input(event: InputEvent):
	if event.is_action_pressed("action"):
		if not active:
			if player in $Area.get_overlapping_bodies():
				emit_signal("activated")
				$Sound.play()
				$Lever/AnimationPlayer.play("Cube001Action")
				active = true
				var tween = create_tween().set_parallel()
				tween.tween_property($OmniLight, "light_energy", 0.0, 0.5)
				tween.tween_property($Prompt, "modulate", Color.transparent, 0.5)
