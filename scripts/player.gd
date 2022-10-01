extends KinematicBody

const SPEED = 15
const INERTIA = 0.1
var direction: Vector2
var velocity: Vector3

func _ready():
	Global.connect("timeout", self, "_on_timeout")

func _physics_process(delta: float):
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction = input_vector
	velocity = velocity.linear_interpolate(Vector3(direction.x, 0, direction.y) * SPEED, delta * 10)
	velocity = move_and_slide(velocity, Vector3.UP, false, 4, PI / 4, false)

	for i in get_slide_count():
		var col = get_slide_collision(i)
		if col.collider is RigidBody:
			col.collider.apply_central_impulse(-col.normal * INERTIA)

func _on_timeout():
	var tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween.tween_property($Camera, "fov", 110.0, 0.5)
	tween.tween_property($Camera, "fov", 70.0, 1)
