extends Spatial

export(NodePath) var button

func _ready():
	get_node(button).connect("activated", self, "_on_activated")

func _on_activated():
	Global.counting = true
	get_parent().get_node("AudioStreamPlayer").play()
