extends Spatial

var player: Spatial
onready var ray1 = $Ray1
onready var ray2 = $Ray2
onready var ray3 = $Ray3
onready var rays = [ray1, ray2, ray3]

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	Global.connect("timeout", self, "_on_timeout")

func _physics_process(delta):
	var dir = transform.origin.direction_to(player.transform.origin)
	var dir_l = transform.origin.direction_to(player.transform.origin + dir.rotated(Vector3.UP, PI / 2) / 3)
	var dir_r = transform.origin.direction_to(player.transform.origin + dir.rotated(Vector3.UP, -PI / 2) / 3)
	var dist = transform.origin.distance_to(player.transform.origin)
	$Mesh.look_at(player.transform.origin, Vector3.UP)
	$Light.look_at(player.transform.origin, Vector3.UP)
	$SpotLight.look_at(player.transform.origin, Vector3.UP)
	ray1.cast_to = dir * dist
	ray2.cast_to = dir_l * dist
	ray3.cast_to = dir_r * dist
	$SpotLight.light_energy = Global.timer / 10

func _on_timeout():
	var tween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN)
	tween.tween_property($Light, "light_energy", 5.0, 0.2)
	yield(get_tree().create_timer(0.5), "timeout")
	for ray in rays:
		if ray.is_colliding():
			if ray.get_collider() is KinematicBody:
				get_tree().quit()
				return
	tween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	tween.tween_property($Light, "light_energy", 0.0, 0.7)
