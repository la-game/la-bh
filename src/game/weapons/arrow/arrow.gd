extends Weapon


@export var damage: float = 1

var hits_left: int = 1


func _physics_process(delta: float) -> void:
	position += transform.x * 500 * delta


func _on_body_entered(body: Node2D) -> void:
	# In case hit two or more enemies at same time.
	if hits_left <= 0:
		return
	
	# Better safe than sorry.
	if not body is Enemy:
		return
	
	var enemy: Enemy = body as Enemy
	enemy.damage(damage)
	hits_left -= 1
	
	if hits_left <= 0:
		return queue_free()


func _on_timer_timeout() -> void:
	queue_free()
