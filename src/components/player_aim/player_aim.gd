## Responsible to know where the player is looking at.
class_name PlayerAim
extends Marker2D


func _physics_process(_delta: float) -> void:
	if is_multiplayer_authority():
		global_position = get_global_mouse_position()
