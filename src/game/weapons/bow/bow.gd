extends Weapon


const ARROW_SCENE = preload("res://src/game/weapons/arrow/arrow.tscn")


func _physics_process(_delta: float) -> void:
	# NOTE: We don't have to sync rotation because we already sync player.aim
	global_rotation = global_position.angle_to_point(player.aim.global_position)


func _on_timer_timeout() -> void:
	var arrow = ARROW_SCENE.instantiate()
	arrow.global_rotation = global_rotation
	arrow.global_position = global_position
	arrow.player = player
	add_child(arrow)
