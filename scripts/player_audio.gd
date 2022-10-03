extends Spatial

const AUDIO = {
	"footstep": "res://audio/sfx/footsteps/footstep_stone_%s.wav",
	"sneeze": "res://audio/sfx/sneeze/sneeze_%s.ogg",
}
var footstep_timer: float
var barrel_player: AudioStreamPlayer3D

func _ready():
	get_parent().connect("barreled", self, "_on_barreled")
	get_parent().connect("unbarreled", self, "_on_unbarreled")
	Global.connect("timeout", self, "_on_timeout")

func _process(delta: float):
	if not get_parent().manholed:
		if not get_parent().barrel_mode:
			if get_parent().velocity.length() > 3.5:
				footstep_timer -= delta
				if footstep_timer <= 0:
					footstep_timer = 0.42
					play_audio("footstep", 6)
			else:
				footstep_timer = 0
		else:
			barrel_player.unit_db = lerp(barrel_player.unit_db, linear2db(get_parent().velocity.length() / get_parent().BARREL_SPEED), delta * 10)

func play_audio(key: String, amount: int, volume: float = 0):
	var player = AudioStreamPlayer3D.new()
	var audio_stream_array = []
	for i in range(amount):
		audio_stream_array.append(load(AUDIO[key] % str(i).pad_zeros(2)))
	randomize()
	var clip_to_play = audio_stream_array[randi() % audio_stream_array.size()]
	player.set_stream(clip_to_play)
	player.unit_db = volume
	player.bus = "SFX"
	player.autoplay = true
	player.pause_mode = PAUSE_MODE_PROCESS
	add_child(player)
	yield(player, "finished")
	player.queue_free()

func _on_barreled():
	barrel_player = AudioStreamPlayer3D.new()
	barrel_player.set_stream(load("res://audio/sfx/wooden_box_loop_00.wav"))
	barrel_player.bus = "SFX"
	barrel_player.autoplay = true
	add_child(barrel_player)

func _on_unbarreled():
	barrel_player.queue_free()
