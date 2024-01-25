## Represent a player in the game.
##
## Player have [b]full[/b] control over himself (they have the authority over
## his bodies), making player logic run locally without lag.
## 
## The downside is that a hacker will have full control over itself, he could
## make his player never dies. I'm counting that the players will be playing with
## friends and for fun, so this is an exchanging for running locally smoothly.
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
	hitbox.monitorable = false
	weapons.disable_all()
