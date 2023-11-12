extends Camera2D

func _ready() -> void:
	top_level = true
	global_position.y = 120
	limit_left = 0

func _process(delta: float) -> void:
	global_position.x = get_parent().global_position.x
