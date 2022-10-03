extends Spatial

const AUDIO = {
	"footstep": "res://audio/sfx/footsteps/footstep_stone_%s.wav",
	"sneeze": "res://audio/sfx/sneeze/sneeze_%s.ogg",
}


func _ready():
	$menu_hole/AnimationPlayer.get_animation("menu").set_loop(true)
	$menu_hole/AnimationPlayer.play("menu")
	$menu_cat/AnimationPlayer.get_animation("menu001").set_loop(true)
	$menu_cat/AnimationPlayer.play("menu001")
	


func _on_AnimationPlayer_animation_finished(anim_name):
	print(1)
	$Timer.start()


func _on_Timer_timeout():
	$Timer.wait_time = 10
	$Timer.start()
	var audio_stream_array = []
	for i in range(2):
		audio_stream_array.append(load(AUDIO["sneeze"] % str(i).pad_zeros(2)))
	randomize()
	var clip_to_play = audio_stream_array[randi() % audio_stream_array.size()]
	$sneeze.set_stream(clip_to_play)
	$sneeze.play()
