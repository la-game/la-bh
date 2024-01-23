## Represent area which player or enemy can be hurt through (this is not for physic collision).
class_name Hitbox
extends Area2D


@export var health: StatusHealth


## Damage but this is only calculated on the host.
## [br][br]
## This means that the client could see a bullet hitting an enemy and
## disappearing but not doing damage.[br]
## Exactly the same must happen in the host for the damage occurs.
func damage(value: float) -> void:
	if not is_multiplayer_authority():
		return
	
	health.damage(value)
