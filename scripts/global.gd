extends Node

signal timeout
const TIMEOUT = 10
var timer: float
var counting: bool

func _process(delta: float):
	if counting:
		timer += delta
		if timer >= TIMEOUT:
			emit_signal("timeout")
			timer = 0
