extends StaticBody

signal activated
var active: bool

func _on_input_event(camera: Node, event: InputEvent, position: Vector3, normal: Vector3, shape_idx: int):
	if not active:
		if event.is_action_pressed("action"):
			emit_signal("activated")
			$Sound.play()
			$Lever/AnimationPlayer.play("Cube001Action")
			active = true
			var tween = create_tween().set_parallel()
			#tween.tween_property(self, "global_translation", global_translation - Vector3(0, 3, 0), 1)
			tween.tween_property($OmniLight, "light_energy", 0.0, 0.5)
