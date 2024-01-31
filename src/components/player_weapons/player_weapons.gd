class_name PlayerWeapons
extends Node2D


const BOW: PackedScene = preload("res://src/game/weapons/bow/bow.tscn")

@export var player: Player


func _ready() -> void:
	# Spawn only your bow and do it later (when MultiplayerSpawner is ready).
	if is_multiplayer_authority():
		add_child.call_deferred(BOW.instantiate(), true)


func disable_all() -> void:
	for weapon: Weapon in get_children():
		weapon.disable()


func enable_all() -> void:
	for weapon: Weapon in get_children():
		weapon.enable()


func _on_child_entered_tree(node: Node) -> void:
	(node as Weapon).player = player
