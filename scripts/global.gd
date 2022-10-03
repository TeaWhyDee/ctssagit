extends Node

signal timeout
const TIMEOUT = 10
var timer: float
var intro: bool = true
var coins = 0

func _process(delta: float):
	timer += delta
	if timer >= TIMEOUT:
		emit_signal("timeout")
		timer = 0

func reset():
	intro = true
	timer = 0
	coins = 0
