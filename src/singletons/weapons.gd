## Responsible to have some weapons scenes preloaded and ready to be instantiated.
##
## NOTE: Turning this in static will make other scenes failing loading on Godot, 
## this is probably a problem of recursion between static and preloaded scenes.
extends Node


const BOW: PackedScene = preload("res://src/game/weapons/bow/bow.tscn")

const ARROW: PackedScene = preload("res://src/game/weapons/arrow/arrow.tscn")


func get_basic_weapons() -> Array[PackedScene]:
	return [
		 #BOW # Removed because it's currently the initial weapon.
	]
