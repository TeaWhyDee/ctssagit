extends Spatial

var coins = 0
onready var player = get_tree().get_nodes_in_group("player")[0]


func _ready():
	Global.connect("timeout", self, "_on_timeout")
	pass

func add_coin():
	coins += 1
	if coins == 3:
		$barrier.queue_free()

func _on_timeout():
	# COUGH
	if not player.manholed and not player.barrel_mode:
		$CanvasLayer.visible = true
		get_tree().paused = true
