class_name Enemy
extends CharacterBody2D


@export var health: StatusHealth

@export var speed: StatusSpeed

@export var attack: StatusAttack

@export var navigation: EnemyNavigation

@export var hitbox: Hitbox


func _ready() -> void:
	health.reached_zero.connect(queue_free)
