extends Weapon


@export var timer: Timer

var hits_left: int = 1


func _physics_process(delta: float) -> void:
	position += transform.x * speed.value * delta


func _on_area_entered(area: Area2D) -> void:
	# In case hit two or more enemies at same time.
	if hits_left <= 0:
		return
	
	# Better safe than sorry.
	if not area is Hitbox:
		return
	
	var enemy: Hitbox = area as Hitbox
	enemy.damage(attack.value)
	hits_left -= 1
	
	if hits_left <= 0:
		return queue_free()


func _on_timer_timeout() -> void:
	queue_free()
