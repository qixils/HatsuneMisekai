class_name Blast
extends Area2D

var max_timer = 2.0
var timer = max_timer
var min_volume = 25.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(percent: float):
	apply_scale(Vector2(percent, percent))
	$SFX.volume_db = -min_volume + (min_volume * percent)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer == 0:
		return
	timer = max(0, timer - delta)
	modulate.a = timer / max_timer
	if timer == 0:
		queue_free()

func _on_body_entered(body):
	if not (body is Enemy):
		return
	var _body = body as Enemy
	_body.die()
