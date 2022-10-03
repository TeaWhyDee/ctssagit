extends Spatial

var opened: bool
onready var player = get_tree().get_nodes_in_group("player")[0]

var audioplayer
func _ready():
	audioplayer = AudioStreamPlayer.new()
	Overlay.get_node("cutscene1").connect("finished", self, "_on_finished")

func _input(event: InputEvent):
	if event.is_action_pressed("action"):
		if player in $Area.get_overlapping_bodies() and not opened:
			#audioplayer.set_stream("res://audio/sfx/lockpicking.ogg")
			#audioplayer.play()
			#enter()
			Global.timer = 0
			$Prompt.queue_free()
			get_parent().get_node("Music").stop()
			Overlay.get_node("cutscene1").visible = true
			Overlay.get_node("cutscene1").play()

func _on_finished():
	print(1)
	get_tree().change_scene("res://scenes/Main.tscn")
	Overlay.get_node("cutscene1").visible = false
