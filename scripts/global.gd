extends Node

signal timeout
const TIMEOUT = 10
var timer: float

func _process(delta: float):
	timer += delta
	if timer >= TIMEOUT:
		emit_signal("timeout")
		timer = 0
