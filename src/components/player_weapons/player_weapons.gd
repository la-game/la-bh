class_name PlayerWeapons
extends Node2D


@export var player: Player


func _ready() -> void:
	# Spawn only your initial weapon and do it later (when MultiplayerSpawner is ready).
	if is_multiplayer_authority():
		var basic_weapons: Array[PackedScene] = Weapons.get_basic_weapons()
		var weapon: Weapon = basic_weapons[Weapons.initial_weapon].instantiate() as Weapon
		add_child.call_deferred(weapon, true)


func disable_all() -> void:
	for weapon: Weapon in get_children():
		weapon.disable()


func enable_all() -> void:
	for weapon: Weapon in get_children():
		weapon.enable()


func _on_child_entered_tree(node: Node) -> void:
	(node as Weapon).player = player
