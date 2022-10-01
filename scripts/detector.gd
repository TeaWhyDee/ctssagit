extends Spatial

var player: Spatial
onready var ray = $RayCast

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	Global.connect("timeout", self, "_on_timeout")

func _physics_process(delta):
	ray.cast_to = to_local(player.transform.origin)
	ray.force_raycast_update()

func _on_timeout():
	$Light.show()
	yield(get_tree().create_timer(0.5), "timeout")
	if ray.is_colliding():
		if ray.get_collider() is KinematicBody:
			get_tree().quit()
			return
	$Light.hide()
