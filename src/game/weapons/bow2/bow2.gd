extends Weapon


@export var timer: Timer


func _physics_process(_delta: float) -> void:
	# NOTE: We don't have to sync rotation because we already sync player.aim
	global_rotation = global_position.angle_to_point(player.aim.global_position)


func _on_timer_timeout() -> void:
	var arrow: Weapon = Weapons.ARROW.instantiate() as Weapon
	arrow.global_rotation = global_rotation
	arrow.global_position = global_position
	arrow.speed.value = speed.value
	arrow.player = player
	add_child(arrow)


func disable() -> void:
	set_physics_process(false)
	timer.paused = true


func enable() -> void:
	set_physics_process(true)
	timer.paused = false
