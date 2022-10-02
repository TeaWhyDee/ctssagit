extends StaticBody

export var interactive: bool = true
export(NodePath) var activator

func _ready():
	$OmniLight.set_as_toplevel(true)
	if interactive:
		get_node(activator).connect("activated", self, "_on_activated")

func _on_activated():
	$Sound.play()
	var tween = create_tween().set_parallel()
	tween.tween_property(self, "global_translation", global_translation - Vector3(0, 5, 0), 0.9).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween.tween_property($OmniLight, "light_energy", 0.0, 1).set_trans(Tween.TRANS_EXPO)
