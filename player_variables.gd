extends Node

signal death

var checkpoint = 0
var fade = 0

func _ready():
	death.connect(_on_death)

func _on_death():
	fade = 1.0
	get_tree().reload_current_scene()

func _process(delta):
	fade = max(0, fade - delta)
