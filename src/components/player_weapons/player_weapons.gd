class_name PlayerWeapons
extends Node2D


@export var player: Player


func disable_all() -> void:
	for weapon: Weapon in get_children():
		weapon.disable()


func enable_all() -> void:
	for weapon: Weapon in get_children():
		weapon.enable()


## Creates a new weapon and remove all weapons responsible for forging it.
@rpc("authority", "call_local", "reliable")
func forge_upgrade(weapon_path: NodePath) -> void:
	var weapon: Weapon = get_node(weapon_path) as Weapon
	
	add_child(weapon.upgrade.instantiate())
	
	for w: Weapon in get_children():
		if w.upgrade == weapon.upgrade:
			w.queue_free()


func _on_child_entered_tree(node: Node) -> void:
	(node as Weapon).player = player
