extends Area

func _on_body_entered(body: Node):
	if body is KinematicBody:
		get_tree().quit()
