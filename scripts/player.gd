extends KinematicBody

const SPEED = 6
const INERTIA = 3
var direction: Vector2
var velocity: Vector3
var pushing: bool
var pushing_timer: float

func _ready():
	$Camera.set_as_toplevel(true)
	Global.connect("timeout", self, "_on_timeout")

func _physics_process(delta: float):
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction = input_vector
	if pushing:
		velocity = Vector3(direction.x, 0, direction.y) * INERTIA
	else:
		velocity = velocity.linear_interpolate(Vector3(direction.x, 0, direction.y) * SPEED, delta * 10)
	velocity = move_and_slide(velocity, Vector3.UP, false, 4, PI / 4, false)

	var pushed = false
	for i in get_slide_count():
		var col = get_slide_collision(i)
		if col.collider.is_in_group("box"):
			col.collider.add_velo(-col.normal * INERTIA)
			pushed = true

	if not pushed:
		pushing_timer += delta
		if pushing_timer > 0.1:
			pushing = false
			pushing_timer = 0
	else:
		pushing = true
		pushing_timer = 0
	
	$Camera.transform.origin = $Camera.transform.origin.linear_interpolate(transform.origin + Vector3(0, 10, 0), delta * 15)
	if direction:
		$Mesh.rotation.y = lerp_angle($Mesh.rotation.y, Vector2(direction.y, direction.x).angle(), delta * 10)

	if pushing:
		$Mesh/AnimationPlayer.play("idle")
	elif velocity.length() > 3:
		$Mesh/AnimationPlayer.play("walk", -1, 2)
	else:
		$Mesh/AnimationPlayer.play("idle")

func _on_timeout():
	if not Global.intro:
		var tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
		tween.tween_property($Camera, "fov", 110.0, 0.5)
		tween.tween_property($Camera, "fov", 70.0, 1)
