extends Control

func _on_Sound_finished():
	get_tree().change_scene("res://scenes/Credits.tscn")
