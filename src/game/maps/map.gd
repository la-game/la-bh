## Base class for maps.
class_name Map
extends Node2D


const PLAYER_SCENE: PackedScene = preload("res://src/game/player/player.tscn")

@export var player_spawn_position: Marker2D

@export var enemy_spawn_paths: Array[PathFollow2D] = []

@export var players: Node2D

@export var enemies: Node2D

@export var players_experience_bar: PlayersExperienceBar


func _ready() -> void:
	spawn_player(multiplayer.get_unique_id())
	
	for peer in multiplayer.get_peers():
		spawn_player(peer)


func _physics_process(_delta: float) -> void:
	if is_multiplayer_authority():
		update_enemies_target()


## Spawn a player for each connection in game.
func spawn_player(peer: int) -> void:
	var player: Player = PLAYER_SCENE.instantiate()
	player.name = "Player" + str(peer)
	player.set_multiplayer_authority(peer)
	players.add_child(player)
	player.global_position = player_spawn_position.global_position


## Update enemies navigation target.[br][br]
## NOTE: This may bring performance problems, explore others ideas
## (using a timer, or update part of enemies, or update randomly, etc).
func update_enemies_target() -> void:
	for enemy: Enemy in enemies.get_children():
		for player: Player in players.get_children():
			if player.alive:
				enemy.navigation.target_it(player)


func _on_wave_rotation_enemy_created(enemy: Enemy) -> void:
	var path_follow: PathFollow2D = PathPosition.get_random_path_follow(enemy_spawn_paths)
	var spawn_position = PathPosition.get_random_position_in_path_follow(path_follow)
	
	enemies.add_child(enemy, true)
	enemy.global_position = spawn_position
	enemy.players_experience_bar = players_experience_bar


func _on_enemy_spawner_spawned(node: Node) -> void:
	var enemy: Enemy = node as Enemy
	enemy.players_experience_bar = players_experience_bar


func _on_players_experience_bar_level_up() -> void:
	for player: Player in players.get_children():
		# Only give point to your player.
		if player.is_multiplayer_authority():
			player.upgrade_selector.points += 1


func _on_wave_rotation_rest_started() -> void:
	for player: Player in players.get_children():
		# Only open upgrades of your player.
		if player.is_multiplayer_authority():
			player.upgrade_selector.open()
