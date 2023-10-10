extends Area2D

@export var index = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if PlayerVariables.checkpoint == index:
		$Animation.play("active")
	else:
		$Animation.play("default")

func _on_body_entered(body: Node2D):
	if not (body is Player):
		return
	PlayerVariables.checkpoint = index
