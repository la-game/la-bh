class_name Enemy
extends CharacterBody2D


@export var experience: float = 1.0

@export var health: StatusHealth

@export var speed: StatusSpeed

@export var attack: StatusAttack

@export var navigation: EnemyNavigation

@export var hitbox: Hitbox

@export var players_experience_bar: PlayersExperienceBar


func _ready() -> void:
	health.reached_zero.connect(_on_status_health_reached_zero)


func _on_status_health_reached_zero() -> void:
	health.immutable = true
	hitbox.monitorable = false
	players_experience_bar.value += experience
	
	# Calling "queue_free()" was making MultiplayerSynchonizer stop synchronizing,
	# which means that any last changes were ignored (like health = 0).
	var timer := get_tree().create_timer(0.0001)
	timer.timeout.connect(queue_free)
