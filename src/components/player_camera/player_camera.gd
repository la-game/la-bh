## Responsible to follow the player around.
class_name PlayerCamera
extends Camera2D


func _physics_process(_delta: float) -> void:
	enabled = is_multiplayer_authority()
