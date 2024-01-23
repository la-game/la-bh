class_name EnemyAttackArea
extends Area2D


@export var attack: StatusAttack

@export var timer: Timer


func _on_timer_timeout() -> void:
	for hitbox: Hitbox in get_overlapping_areas():
		hitbox.damage(attack.value)
