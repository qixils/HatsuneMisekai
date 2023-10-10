extends Node2D

var player_position: float = 0.0

func _ready():
	$Player.update_position.connect(_on_player_update_position)

func _on_player_update_position(old_value: Vector2, new_value: Vector2):
	player_position = new_value.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x = min(0, -player_position + (DisplayServer.window_get_size().x / 2))
