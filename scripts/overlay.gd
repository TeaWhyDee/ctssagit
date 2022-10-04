extends CanvasLayer

func _process(delta):
	$HUD/QuitText.modulate.a = $Timer.time_left

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if $Timer.is_stopped():
			$Timer.start(1)
		else:
			get_tree().quit()
