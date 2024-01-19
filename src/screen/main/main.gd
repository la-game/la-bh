extends MarginContainer


const LOBBY_SCENE: PackedScene = preload("res://src/screen/lobby/lobby.tscn")

@export var host_window: Window

@export var join_window: Window


func _on_host_pressed() -> void:
	host_window.popup_centered()


func _on_join_pressed() -> void:
	join_window.popup_centered()


func _on_host_window_hosting() -> void:
	get_tree().root.add_child(LOBBY_SCENE.instantiate())
	queue_free()


func _on_join_window_connected() -> void:
	get_tree().root.add_child(LOBBY_SCENE.instantiate())
	queue_free()
