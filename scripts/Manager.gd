extends Node2D

func _input(event):
	if Input.is_action_just_pressed("toggle_fullscreen"):
		toggle_fullscreen()
		
func toggle_fullscreen():
	if !DisplayServer.window_get_mode():
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
