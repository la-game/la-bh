class_name EnemiesGroups
extends Node


const group_00: Array[PackedScene] = [
	preload("res://src/game/enemies/enemy_00/enemy_00.tscn")
]

static var rng: RandomNumberGenerator = RandomNumberGenerator.new()


static func random_enemy(group: Array[PackedScene]) -> PackedScene:
	return group[randi_range(0, group.size() - 1)]
