extends Area

func _ready():
	Global.connect("timeout", self, "_on_timeout")

func _on_body_entered(body: Node):
	if body.is_in_group("player"):
		Global.reset()
		get_tree().reload_current_scene()

func _on_timeout():
	monitoring = true
	yield(get_tree().create_timer(0.5), "timeout")
	monitoring = false
