extends Spatial

export(NodePath) var button

func _ready():
	get_node(button).connect("activated", self, "_on_activated")

func _on_activated():
	Global.timer = 0
	Global.intro = false
	var alarm = get_parent().get_node("Player/Camera/Alarm")
	alarm.play()
	get_parent().get_node("AudioStreamPlayer").play()
	var tween = create_tween()
	tween.tween_property(alarm, "unit_db", -50.0, 10).set_ease(Tween.EASE_IN_OUT)
