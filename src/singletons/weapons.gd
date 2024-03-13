## Responsible to have some weapons scenes preloaded and ready to be instantiated.
##
## NOTE: Turning this in static will make other scenes failing loading on Godot, 
## this is probably a problem of recursion between static and preloaded scenes.
extends Node


const ARROW: PackedScene = preload("res://src/game/weapons/arrow/arrow.tscn")

const BOW: PackedScene = preload("res://src/game/weapons/bow/bow.tscn")

const DAGGER: PackedScene = preload("res://src/game/weapons/dagger/dagger.tscn")

## Initial weapon of this player, selected on lobby.
static var initial_weapon: int = 0

func get_basic_weapons() -> Array[PackedScene]:
	return [
		BOW,
		DAGGER,
	]
