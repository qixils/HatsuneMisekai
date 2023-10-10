extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if not (body is Player):
		return
	if PlayerVariables.fade > 0:
		return
	var _body = body as Player
	_body.position = Vector2(0, 0)
	PlayerVariables.checkpoint = 0
	get_tree().change_scene_to_file("res://ending.tscn")
