extends Spatial

var player: Spatial
onready var ray1 = $Ray1
onready var ray2 = $Ray2
onready var ray3 = $Ray3
onready var rays = [ray1, ray2, ray3]

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	Global.connect("timeout", self, "_on_timeout")
	$Mesh/Camera.set_as_toplevel(true)
	for ray in rays:
		ray.set_as_toplevel(true)
		ray.global_rotation = Vector3()

func _physics_process(delta):
	if not Global.intro:
		var dir = global_translation.direction_to(player.transform.origin)
		var dir_l = global_translation.direction_to(player.transform.origin + dir.rotated(Vector3.UP, PI / 2) / 3)
		var dir_r = global_translation.direction_to(player.transform.origin + dir.rotated(Vector3.UP, -PI / 2) / 3)
		var dist = global_translation.distance_to(player.transform.origin)
		$Mesh/Camera.look_at(player.transform.origin, Vector3.UP)
		$Light.look_at(player.transform.origin, Vector3.UP)
		$SpotLight.look_at(player.transform.origin, Vector3.UP)
		ray1.cast_to = dir * dist
		ray2.cast_to = dir_l * dist
		ray3.cast_to = dir_r * dist
		$SpotLight.light_energy = Global.timer / 10 * 2
		#$Buzzing.unit_db = (Global.timer - Global.TIMEOUT) * 8 + 40

func _on_timeout():
	if not Global.intro:
		$Sound.play()
		var tween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN)
		tween.tween_property($Light, "light_energy", 5.0, 0.2)
		yield(get_tree().create_timer(0.5), "timeout")
		for ray in rays:
			if ray.is_colliding():
				if ray.get_collider().is_in_group("player"):
					Global.reset()
					get_tree().reload_current_scene()
		tween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
		tween.tween_property($Light, "light_energy", 0.0, 0.7)
