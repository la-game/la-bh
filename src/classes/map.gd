class_name Map
extends Node2D


@export var player_spawn_position: Marker2D

@export var enemy_spawn_paths: Array[PathFollow2D] = []

@export var enemy_spawn_timer: Timer
 
@export var players: Node2D

@export var enemies: Node2D

@export var projectiles: Node2D


func _on_enemy_spawn_timer_timeout() -> void:
	var path_follow: PathFollow2D = PathPosition.get_random_path_follow(enemy_spawn_paths)
	PathPosition.get_random_position_in_path_follow(path_follow) # TODO
