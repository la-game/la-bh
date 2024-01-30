## Base class for weapons.
class_name Weapon
extends Area2D

@export var player: Player

@export var speed: StatusSpeed

@export var attack: StatusAttack

@export var description: WeaponDescription

## Weapon which will replace this in case upgrade is desired.[br]
## Will hold null when no upgrade exists.
@export var upgrade: PackedScene


func disable() -> void:
	pass


func enable() -> void:
	pass
