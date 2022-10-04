extends Control

var current = 0
onready var sounds = [$Clock1, $Clock2]

func _ready():
	Global.timer = 2
	if OS.has_feature("HTML5"):
		$MarginContainer/VBoxContainer2/Buttons/Quit.hide()

func play_clock():
	sounds[current].play()
	if current == 0:
		current = 1
	else:
		current = 0

func _on_quit_pressed():
	get_tree().quit()

func _on_play_pressed():
	get_tree().change_scene("res://scenes/level1.tscn")
	Global.reset()
	Overlay.get_node("HUD/C").show()

func _on_music_value_changed(value: float):
	AudioServer.set_bus_volume_db(3, linear2db(value))

func _on_sfx_value_changed(value:float):
	AudioServer.set_bus_volume_db(1, linear2db(value))

func _on_sfx_drag_ended(value_changed:bool):
	play_clock()

func _oncolors_toggled(button_pressed:bool):
	var val = 0
	if button_pressed:
		val = 2
	Overlay.get_node("HUD/CRT").material.set_shader_param("aberration_amount", val)
	play_clock()

func _on_scanlines_toggled(button_pressed:bool):
	Overlay.get_node("HUD/CRT").material.set_shader_param("scanlines_shown", button_pressed)
	play_clock()

func _on_play_button_down():
	play_clock()

func _on_quit_button_down():
	play_clock()

func _on_fullscreen_toggled(pressed: bool):
	OS.set_window_fullscreen(pressed)
