class_name PlayerWeapons
extends Node2D


@export var player: Player


func _ready() -> void:
	# Spawn only your bow and do it later (when MultiplayerSpawner is ready).
	if is_multiplayer_authority():
		add_child.call_deferred(Weapons.BOW.instantiate(), true)


func disable_all() -> void:
	for weapon: Weapon in get_children():
		weapon.disable()


func enable_all() -> void:
	for weapon: Weapon in get_children():
		weapon.enable()


func _on_child_entered_tree(node: Node) -> void:
	(node as Weapon).player = player
