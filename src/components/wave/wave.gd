## Represent a group of enemies that will spawn for a while.
class_name Wave
extends Node


@export var duration: float = 300

@export var spawn_frequency: float = 1

@export var enemies: Array[PackedScene] = []

var rng: RandomNumberGenerator = RandomNumberGenerator.new()


## Returns a random enemy from wave or null if there is no enemy.[br]
## Waves without enemy could be seeing as interval for the player relax.
func random_enemy() -> PackedScene:
	if not enemies:
		return null
	return enemies[randi_range(0, enemies.size() - 1)]
