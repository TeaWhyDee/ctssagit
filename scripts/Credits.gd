extends CanvasLayer


func _ready():
	$AnimationPlayer.set_current_animation("scroll")
	$AnimationPlayer.play()
	$RichTextLabel.show()

func _on_VideoPlayer_finished():
	$Control/VideoPlayer.play()

func _on_Quit_button_down():
	get_tree().quit()
