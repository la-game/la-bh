class_name WaveRotation
extends Node


signal rotation_finished

signal enemy_created(enemy: Enemy)

@export var wave_timer: Timer

@export var spawn_timer: Timer


func _ready() -> void:
	if is_multiplayer_authority():
		start_first_wave()


func start_first_wave() -> void:
	for child in get_children():
		if child is Wave:
			wave_timer.start(child.duration)
			spawn_timer.start(child.spawn_frequency)
			return


func _on_wave_timer_timeout() -> void:
	var current_wave_removed: bool = false
	
	# We want to remove the current wave and start the next wave.
	for child in get_children():
		if child is Wave:
			
			if not current_wave_removed:
				child.queue_free()
				spawn_timer.stop()
				current_wave_removed = true
			else:
				wave_timer.start(child.duration)
				spawn_timer.start(child.spawn_frequency)
				return
	
	rotation_finished.emit()


func _on_spawn_timer_timeout() -> void:
	for child in get_children():
		if child is Wave:
			var enemy_scene: PackedScene = child.random_enemy()
			
			if enemy_scene:
				enemy_created.emit(enemy_scene.instantiate() as Enemy)
