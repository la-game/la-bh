## Base for all maps.
class_name Map
extends Node2D


const PLAYER_SCENE: PackedScene = preload("res://src/game/player/player.tscn")

@export var player_spawn_position: Marker2D

@export var enemy_spawn_paths: Array[PathFollow2D] = []

@export var enemy_spawn_timer: Timer
 
@export var players: Node2D

@export var enemies: Node2D


func _ready() -> void:
	spawn_player(multiplayer.get_unique_id())
	
	for peer in multiplayer.get_peers():
		spawn_player(peer)
	
	if is_multiplayer_authority():
		enemy_spawn_timer.start()


func spawn_player(peer: int) -> void:
	var player: Player = PLAYER_SCENE.instantiate()
	player.name = "Player" + str(peer)
	players.add_child(player)
	player.set_multiplayer_authority(peer)
	player.global_position = player_spawn_position.global_position


func _on_enemy_spawn_timer_timeout() -> void:
	var path_follow: PathFollow2D = PathPosition.get_random_path_follow(enemy_spawn_paths)
	var spawn_position = PathPosition.get_random_position_in_path_follow(path_follow)
