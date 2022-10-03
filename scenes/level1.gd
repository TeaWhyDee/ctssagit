extends Spatial

var coins = 0

func _ready():
	pass

func add_coin():
	coins += 1
	if coins == 3:
		$barrier.queue_free()
