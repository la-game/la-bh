class_name PlayerWeapons
extends Node2D


func disable_all() -> void:
	for weapon: Weapon in get_children():
		weapon.disable()


func enable_all() -> void:
	for weapon: Weapon in get_children():
		weapon.enable()
