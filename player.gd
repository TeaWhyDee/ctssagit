extends KinematicBody

const SPEED = 15
const INERTIA = 0.1
var direction: Vector2
var velocity: Vector3

func _physics_process(delta: float):
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction = input_vector
	velocity = velocity.linear_interpolate(Vector3(direction.x, 0, direction.y) * SPEED, delta * 10)
	velocity = move_and_slide(velocity, Vector3.UP, false, 4, PI / 4, false)

	for i in get_slide_count():
		var col = get_slide_collision(i)
		if col.collider is RigidBody:
			col.collider.apply_central_impulse(-col.normal * INERTIA)
	
	var mouse_pos = get_viewport().get_mouse_position() - get_viewport().size / 2
	$SpotLight.look_at(to_global(Vector3(mouse_pos.x, 0, mouse_pos.y)), Vector3.UP)
