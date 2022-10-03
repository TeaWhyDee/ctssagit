extends Area

func _on_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene("res://scenes/EndSound.tscn")
