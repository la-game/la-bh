## Represent area which player or enemy can be hurt through (this is not for physic collision).
class_name Hitbox
extends Area2D


@export var health: StatusHealth


## Damage but this is only calculated on authority.
## [br][br]
## This means that the client could see a bullet hitting an enemy and
## the bullet disappearing but not doing damage.[br]
## In this case, exactly the same must happen in the host for the damage occurs.
## [br][br]
## Also, the host could se a enemy hitting the client but not doing damage.[br]
## Again, the same must happen in the client for the damage occurs.
func damage(value: float) -> void:
	if not is_multiplayer_authority():
		return
	
	health.damage(value)
