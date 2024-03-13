## Responsible for rotate between waves.
##
## Every children of this node should be a [Wave], except the first one which are nodes to help this scene.
class_name WaveRotation
extends Node


signal rotation_finished

signal rest_started

signal enemy_created(enemy: Enemy)

@export var wave_timer: Timer

@export var spawn_timer: Timer

var current: int = 1


func _ready() -> void:
	if is_multiplayer_authority():
		start_current_wave()


func start_current_wave() -> void:
	# Rotation ended.
	if get_child_count() == current:
		rotation_finished.emit()
		return
	
	var wave: Wave = get_child(current) as Wave
	wave_timer.start(wave.duration)
	
	if wave.enemies:
		spawn_timer.start(wave.spawn_frequency)
	else:
		rest_started.emit()

func _on_wave_timer_timeout() -> void:
	current += 1
	start_current_wave()


func _on_spawn_timer_timeout() -> void:
	# Rotation ended.
	if get_child_count() == current:
		spawn_timer.stop()
		return
		
	var wave: Wave = get_child(current) as Wave
	var enemy_scene: PackedScene = wave.random_enemy()
	
	if enemy_scene:
		enemy_created.emit(enemy_scene.instantiate() as Enemy)
