## Represent area which player or enemy can be hurt through (this is not for physic collision).
class_name Hitbox
extends Area2D


@export var health: StatusHealth


func damage(value: float) -> void:
	health.damage(value)
