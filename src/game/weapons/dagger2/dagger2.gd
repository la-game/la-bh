extends Weapon


@export var dagger1: Area2D

@export var dagger2: Area2D

@export var range: Area2D

var is_attacking: bool = false

var damage_done1: bool = false

var damage_done2: bool = false


func _ready() -> void:
	dagger1.visible = false
	dagger2.visible = false


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
	dagger1.visible = true
	is_attacking = true
	damage_done1 = false
	damage_done2 = false
	
	# Cut animation.
	var tween1: Tween = get_tree().create_tween()
	tween1.tween_property(dagger1, "rotation", -PI/2, 0.1)
	tween1.tween_property(dagger1, "rotation", 0, 0.1)
	tween1.tween_property(dagger1, "visible", false, 0.1)
	tween1.tween_property(self, "is_attacking", false, 0)
	
	var tween2: Tween = get_tree().create_tween()
	tween2.tween_property(dagger2, "visible", true, 0)
	tween2.tween_interval(0.1) # Waits dagger1 finish cut.
	tween2.tween_property(dagger2, "rotation", PI/2, 0.1)
	tween2.tween_property(dagger2, "rotation", 0, 0.1)
	tween2.tween_property(dagger2, "visible", false, 0)


func disable() -> void:
	set_physics_process(false)


func enable() -> void:
	set_physics_process(true)


func _on_dagger_1_area_entered(area: Area2D) -> void:
	if damage_done1:
		return
	
	if not area is Hitbox:
		return
	
	(area as Hitbox).damage(attack.value)
	
	damage_done1 = true
	dagger1.visible = false


func _on_dagger_2_area_entered(area: Area2D) -> void:
	if damage_done2:
		return
	
	if not area is Hitbox:
		return
	
	(area as Hitbox).damage(attack.value)
	
	damage_done2 = true
	dagger2.visible = false
