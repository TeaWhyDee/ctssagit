extends KinematicBody

var velocity: Vector3

func _physics_process(delta):
	velocity.x /= 1.07
	velocity.z /= 1.07
	velocity = move_and_slide(velocity)
	#$Sound.unit_db = lerp($Sound.unit_db, (velocity.length() - 2) / 4 * 80 + 10, delta * 30)
	#$Sound.unit_db = (velocity.length() - 2) / 5 * 80
	$Sound.unit_db = lerp($Sound.unit_db, (velocity.length() - 2) / 5 * 80, delta * 10)

func add_velo(velo):
	velocity = velo * 0.98
