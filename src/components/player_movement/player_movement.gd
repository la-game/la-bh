## Responsible to control the player movements.
class_name PlayerMovement
extends Node


@export var player: Player

@export var speed: StatusSpeed


func _physics_process(_delta: float) -> void:
	if not player:
		return
	
	if not is_multiplayer_authority():
		return
	
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# While keyboard always give 0 or 1 for the axis, joysticks can give any value between 0 and 1.
	# Joysticks doesn't have to go FULL speed left/right/up/down, they can give a gentle touch to go slower.
	if direction.length() > 1.0:
		direction = direction.normalized()
	
	player.velocity = direction * speed.value
	player.move_and_slide()
