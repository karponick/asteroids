extends CanvasLayer

var playing = true

func _input(event):
	if event.is_action_pressed("pause") and playing:
		get_tree().paused = not get_tree().paused
		$Pause.visible = get_tree().paused
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()
		get_tree().paused = false

func set_playing_false():
	playing = false
