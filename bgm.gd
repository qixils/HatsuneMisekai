extends AudioStreamPlayer

func _ready():
	if OS.get_name() != "Web":
		play()

func _on_start_music_timer_timeout():
	if not playing:
		play()
