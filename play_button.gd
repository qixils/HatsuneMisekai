extends Button


func _on_pressed():
	PlayerVariables.fade = 1.0
	get_tree().change_scene_to_file("res://game.tscn")
	pass # Replace with function body.
