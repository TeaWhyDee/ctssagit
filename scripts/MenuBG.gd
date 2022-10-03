extends Spatial


func _ready():
	$menu_hole/AnimationPlayer.get_animation("menu").set_loop(true)
	$menu_hole/AnimationPlayer.play("menu")
	$menu_cat/AnimationPlayer.get_animation("menu001").set_loop(true)
	$menu_cat/AnimationPlayer.play("menu001")
	
