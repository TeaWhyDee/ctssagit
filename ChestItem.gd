extends Spatial

var opened: bool
var coins = []
onready var player = get_tree().get_nodes_in_group("player")[0]

var audioplayer
func _ready():
	coins = $chest.get_node("coins").get_children()
	audioplayer = AudioStreamPlayer.new()


func _input(event: InputEvent):
	if event.is_action_pressed("action"):
		if player in $Area.get_overlapping_bodies() and not opened:
			#audioplayer.set_stream("res://audio/sfx/lockpicking.ogg")
			#audioplayer.play()O
			#enter()
			get_parent().get_parent().add_coin()
			$Prompt.queue_free()
			opened = true
			$chest/AnimationPlayer.play("chestopen")
			$AudioStreamPlayer3D.play()
			$Timer.start()


func _on_Timer_timeout():
	var coin = coins[0]
	coins.remove(0)
	coin.visible = false
	if coins.size() == 0:
		$Timer.stop()
