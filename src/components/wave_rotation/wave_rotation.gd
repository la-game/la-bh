## Responsible for rotate between waves.
##
## Every children of this node should be a [Wave], except the first one which are nodes to help this scene.
class_name WaveRotation
extends Node


signal rotation_finished

signal enemy_created(enemy: Enemy)

@export var wave_timer: Timer

@export var spawn_timer: Timer

var current: int = 1


func _ready() -> void:
	if is_multiplayer_authority():
		start_current_wave()


func start_current_wave() -> void:
	var wave: Wave = get_child(current) as Wave
	
	# Rotation ended.
	if not wave:
		return rotation_finished.emit()
	
	wave_timer.start(wave.duration)
	spawn_timer.start(wave.spawn_frequency)


func _on_wave_timer_timeout() -> void:
	current += 1
	start_current_wave()


func _on_spawn_timer_timeout() -> void:
	var wave: Wave = get_child(current) as Wave
	
	if not wave:
		return spawn_timer.stop()
	
	var enemy_scene: PackedScene = wave.random_enemy()
	
	if enemy_scene:
		enemy_created.emit(enemy_scene.instantiate() as Enemy)
