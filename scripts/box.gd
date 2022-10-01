extends KinematicBody

var velocity: Vector3

func _physics_process(delta):
	velocity.x /= 1.07
	velocity.z /= 1.07
	velocity = move_and_slide(velocity)

func add_velo(velo):
	velocity = velo * 0.98
