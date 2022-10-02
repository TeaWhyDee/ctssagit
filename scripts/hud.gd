extends Control

const SIZE = 60
const COLOR = Color.white
var rot_timer: float

func _draw():
	#draw_set_transform(get_viewport().size / 2, 0, Vector2.ONE)
	#draw_line(Vector2(), Vector2(0, -SIZE), COLOR, 3, true)
	var dir = Vector2(cos(-PI / 2 + rot_timer), sin(-PI / 2 + rot_timer))
	draw_line(Vector2(), dir * SIZE, COLOR, 3, true)
	#draw_arc(Vector2(), SIZE, 0, PI * 2, 32, COLOR, 2, true)

func _process(_delta):
	rot_timer = Global.timer / Global.TIMEOUT * PI * 2
	update()
