extends VideoStreamPlayer

func _on_finished():
	get_tree().change_scene_to_file("res://menu.tscn")

func _on_timer_timeout():
	play()
