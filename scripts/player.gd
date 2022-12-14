extends KinematicBody

signal barreled
signal unbarreled
const SPEED = 6
const BARREL_SPEED = 9
const INERTIA = 3
var direction: Vector2
var velocity: Vector3
var pushing: bool
var pushing_speed: float
var pushing_timer: float
var barrel_mode: bool
var barrel_timeout: float = 0.1
var sneeze_lock: float
var keys: int
export var manholed: bool
onready var camera_init_pos = $Camera.translation
onready var camera_init_fov = $Camera.fov

func _ready():
	if manholed:
		$Mesh/AnimationPlayer.play("cat_hide")
		var l = $Mesh/AnimationPlayer.get_current_animation_length()
		$Mesh/AnimationPlayer.advance(l-0.1)
		
	$Camera.set_as_toplevel(true)
	#$Mesh/AnimationPlayer.set_blend_time("idle", "walk", 0.2)
	#$Mesh/AnimationPlayer.set_blend_time("walk", "idle", 0.3)
	#$Mesh/AnimationPlayer.set_blend_time("walk", "push", 0.1)
	#$Mesh/AnimationPlayer.set_blend_time("push", "idle", 0.2)
	Global.connect("timeout", self, "_on_timeout")

func _physics_process(delta: float):
	if not manholed:
		var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		direction = input_vector
		if not barrel_mode:
			if pushing:
				pushing_speed = lerp(pushing_speed, INERTIA, delta * 5)
				velocity = Vector3(direction.x, 0, direction.y) * pushing_speed
			else:
				pushing_speed = lerp(pushing_speed, 0, delta * 10)
				velocity = velocity.linear_interpolate(Vector3(direction.x, 0, direction.y) * SPEED, delta * 10)
		else:
			velocity = velocity.linear_interpolate(Vector3(direction.x, 0, direction.y) * BARREL_SPEED, delta)
			if barrel_timeout > 0:
				barrel_timeout -= delta
			$BarrelMesh.rotate_x(-velocity.length() / 60)
		velocity.y -= 1
		velocity = move_and_slide(velocity, Vector3.UP, false, 4, PI / 4, false)

		var pushed = false
		for i in get_slide_count():
			var col = get_slide_collision(i)
			if col.collider.is_in_group("box"):
				col.collider.add_velo(-col.normal * pushing_speed)
				pushed = true

		if not pushed:
			pushing_timer += delta
			if pushing_timer > 0.1:
				pushing = false
				pushing_timer = 0
		else:
			pushing = true
			pushing_timer = 0
		
		$Camera.transform.origin = $Camera.transform.origin.linear_interpolate(transform.origin + camera_init_pos, delta * 15)
		if direction:
			rotation.y = lerp_angle(rotation.y, Vector2(-direction.y, -direction.x).angle(), delta * 10)

		if pushing and direction:
			$Mesh/AnimationPlayer.play("push")
		elif velocity.length() > 3:
			$Mesh/AnimationPlayer.play("walk", -1, 2)
		else:
			$Mesh/AnimationPlayer.play("idle")

func hide_in_barrel(barrel: Spatial):
	$Mesh.hide()
	$CollisionShape.disabled = true
	$BarrelMesh.show()
	$BarrelCollisionShape.disabled = false
	global_translation = barrel.global_translation
	barrel_mode = true
	barrel_timeout = 0.1
	emit_signal("barreled")

func unbarrel():
	$Mesh.show()
	$CollisionShape.disabled = false
	$BarrelMesh.hide()
	$BarrelCollisionShape.disabled = true
	var dir = Vector2(cos(rotation.y), sin(rotation.y))
	global_translation += Vector3(dir.y, 0, dir.x) * 0.5
	barrel_mode = false
	emit_signal("unbarreled")

func hide_in_manhole(manhole: Spatial):
	if not barrel_mode:
		$CollisionShape.disabled = true
		var dir = global_translation.direction_to(manhole.global_translation)
		rotation.y = atan2(-dir.z, dir.x) - PI / 2
		global_translation = manhole.global_translation - dir * 1.2
		$Mesh/AnimationPlayer.play("cat_hide")
		manholed = true
	return not barrel_mode

func unmanhole():
	$Mesh/AnimationPlayer.play_backwards("cat_hide")
	yield($Mesh/AnimationPlayer, "animation_finished")
	$CollisionShape.disabled = false
	manholed = false

func sneeze():
	$AudioPlayer.play_audio("sneeze", 2, 10)
	sneeze_lock = 0.3

func _on_timeout():
	if not Global.intro:
		var tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
		tween.tween_property($Camera, "fov", 130.0, 0.5)
		tween.tween_property($Camera, "fov", camera_init_fov, 1)
