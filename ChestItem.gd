extends Spatial

var opened: bool
onready var player = get_tree().get_nodes_in_group("player")[0]

var audioplayer
func _ready():
	audioplayer = AudioStreamPlayer.new()

func _input(event: InputEvent):
	if event.is_action_pressed("action"):
		if player in $Area.get_overlapping_bodies() and not opened:
			#audioplayer.set_stream("res://audio/sfx/lockpicking.ogg")
			#audioplayer.play()
			#enter()
			get_parent().get_parent().add_coin()
			$Prompt.queue_free()
			opened = true
			$chest/AnimationPlayer.play("chestopen")
			$AudioStreamPlayer3D.play()

