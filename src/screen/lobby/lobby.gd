extends MarginContainer


const MAP_00: PackedScene = preload("res://src/game/map/map_00.tscn")


@rpc("authority", "call_local", "reliable")
func start_game() -> void:
	get_tree().root.add_child(MAP_00.instantiate())
	queue_free()


func _on_play_pressed() -> void:
	if is_multiplayer_authority():
		start_game.rpc()
