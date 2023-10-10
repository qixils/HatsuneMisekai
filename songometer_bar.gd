extends ColorRect

var initial_size = size.x
var max_jump_power: float = 1.0

func _ready():
	set_size(Vector2(0, size.y))
	var player = get_node("/root/Game/Level/Contents/Player")
	max_jump_power = player.max_jump_power
	player.update_jump_power.connect(_on_player_update_jump_power)
	
func _on_player_update_jump_power(old_value: float, new_value: float):
	set_size(Vector2(initial_size * min(1, new_value / max_jump_power), size.y))
