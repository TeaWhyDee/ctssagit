extends Spatial

const AUDIO = {
	"footstep": "res://audio/sfx/footsteps/footstep_stone_%s.wav"
}
var footstep_timer: float

func _process(delta: float):
	if get_parent().direction:
		footstep_timer -= delta
		if footstep_timer <= 0:
			footstep_timer = 0.4
			play_audio("footstep", 6)
	else:
		footstep_timer = 0

func play_audio(key: String, amount: int):
	var player = AudioStreamPlayer3D.new()
	var audio_stream_array = []
	for i in range(amount):
		audio_stream_array.append(load(AUDIO[key] % str(i).pad_zeros(2)))
	randomize()
	var clip_to_play = audio_stream_array[randi() % audio_stream_array.size()]
	player.set_stream(clip_to_play)
	player.bus = "SFX"
	player.autoplay = true
	add_child(player)
	yield(player, "finished")
	player.queue_free()
