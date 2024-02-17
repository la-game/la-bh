extends Weapon


const Arrow := preload("res://src/game/weapons/arrow/arrow.gd")

@export var timer: Timer

var angle_index: int = 0

var angles: Array[float] = [PI/8, 0, -PI/8]


func _physics_process(_delta: float) -> void:
	# NOTE: We don't have to sync rotation because we already sync player.aim
	global_rotation = global_position.angle_to_point(player.aim.global_position)


func _on_timer_timeout() -> void:
	var arrow: Arrow = Weapons.ARROW.instantiate() as Arrow
	var angle: float = angles[angle_index]
	arrow.global_rotation = global_rotation + angle
	arrow.global_position = global_position
	arrow.speed.value = 500
	arrow.player = player
	arrow.timer.wait_time /= 2
	add_child(arrow)
	
	angle_index = wrapi(angle_index + 1, 0, angles.size())


func disable() -> void:
	set_physics_process(false)
	timer.paused = true


func enable() -> void:
	set_physics_process(true)
	timer.paused = false
