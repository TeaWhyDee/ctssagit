extends Spatial

onready var ap = get_node("AnimationPlayer")

func _ready():
	var list = ap.get_animation_list()
	var anims = ["ZAction", "ZAction003", "ZAction012"]
	var anim = ""
	for i in anims:
		if i in list:
			anim = i
	
	ap.get_animation(anim).set_loop(true)
	ap.play(anim)

	
