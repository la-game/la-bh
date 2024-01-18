## Responsible to follow the player around.
class_name PlayerCamera
extends Camera2D


func _ready() -> void:
	enabled = is_multiplayer_authority()
