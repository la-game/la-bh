## Responsible to navigate the enemy to the closest player.
class_name EnemyNavigation
extends NavigationAgent2D


@export var enemy: CharacterBody2D

@export var player: CharacterBody2D


func _ready() -> void:
	set_physics_process(multiplayer.is_server())


func _physics_process(_delta: float) -> void:
	if not player:
		return
	
	target_position = player.global_position
	
	var direction = enemy.global_position.direction_to(get_next_path_position())
	enemy.velocity = direction # TODO: * enemy.speed.current
	enemy.move_and_slide()


## Attempt to target the player if is closer than previous player.
func target_it(player2: CharacterBody2D) -> void:
	if not player:
		player = player2
		return
	
	var player2_distance = enemy.global_position.distance_to(player2.global_position)
	var player_distance = enemy.global_position.distance_to(player.global_position)
	
	if player2_distance < player_distance:
		player = player2