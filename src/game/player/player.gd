## Represent a player in the game.
class_name Player
extends CharacterBody2D


@export var health: StatusHealth

@export var speed: StatusSpeed

@export var attack: StatusAttack

@export var movement: PlayerMovement

@export var aim: PlayerAim

@export var hitbox: Hitbox

@export var weapons: PlayerWeapons

var alive: bool = true


func _on_status_health_reached_zero() -> void:
	alive = false
	movement.disabled = true
	health.immutable = true
	weapons.disable_all()
