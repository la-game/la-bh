extends Weapon


@export var range: Area2D

var is_attacking: bool = false

var damage_done: bool = false


func _ready() -> void:
	visible = false


func _physics_process(delta: float) -> void:
	if is_attacking:
		return
	
	if not range.has_overlapping_areas():
		return
	
	var best_direction: Vector2 = Vector2.RIGHT
	var best_distance: float = INF
	
	for hitbox: Hitbox in range.get_overlapping_areas():
		var enemy_distance: float = global_position.distance_to(hitbox.global_position)
		
		if enemy_distance < best_distance:
			best_direction = global_position.direction_to(hitbox.global_position)
			best_distance = enemy_distance
	
	rotation = best_direction.angle()
	visible = true
	is_attacking = true
	damage_done = false
	
	# Stab animation.
	var final_position = position + best_direction * 20
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "position", final_position, 0.1)
	tween.tween_property(self, "position", position, 0.1)
	tween.tween_property(self, "is_attacking", false, 0)
	tween.tween_property(self, "visible", false, 0)


func disable() -> void:
	set_physics_process(false)


func enable() -> void:
	set_physics_process(true)


func _on_area_entered(area: Area2D) -> void:
	if damage_done:
		return
	
	if not area is Hitbox:
		return
	
	(area as Hitbox).damage(attack.value)
	
	damage_done = true
	visible = false
