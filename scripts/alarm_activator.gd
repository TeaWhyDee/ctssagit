extends Spatial

export(NodePath) var button

func _ready():
	get_node(button).connect("activated", self, "_on_activated")

func _on_activated():
	Global.timer = 0
	Global.intro = false
	var alarm = get_parent().get_node("Player/Camera/Alarm")
	alarm.play()
	get_parent().get_node("Music").play()
	var tween = create_tween()
	tween.tween_property(alarm, "unit_db", -2.0, 0.7).set_ease(Tween.EASE_OUT)
	tween.tween_property(alarm, "unit_db", -70.0, 20).set_ease(Tween.EASE_IN_OUT)
