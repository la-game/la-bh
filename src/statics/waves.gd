class_name Waves
extends Node


const wave_00: Array[PackedScene] = [
	preload("res://src/game/enemies/enemy_00/enemy_00.tscn")
]

static var rng: RandomNumberGenerator = RandomNumberGenerator.new()


static func random_enemy(wave: Array[PackedScene]) -> PackedScene:
	return wave[randi_range(0, wave.size() - 1)]
