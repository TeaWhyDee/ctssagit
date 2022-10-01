extends Area

func _on_body_entered(body: Node):
	if body.is_in_group("player"):
		get_tree().quit()
