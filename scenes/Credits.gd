extends CanvasLayer


func _ready():
	$AnimationPlayer.set_current_animation("scroll")
	$AnimationPlayer.play()


func _on_VideoPlayer_finished():
	$VideoPlayer.play()


func _on_Quit_button_down():
	get_tree().quit()
