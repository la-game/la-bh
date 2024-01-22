class_name Enemy
extends CharacterBody2D


## Damage the enemy but this is only calculated on the host.
## [br][br]
## This means that the client could see a bullet hitting the enemy and
## disappearing but not doing damage. Exactly the same must happen in the
## host for the damage occurs.
func damage(v: float) -> void:
	if not is_multiplayer_authority():
		return
