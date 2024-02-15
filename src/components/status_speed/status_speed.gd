## Represent the speed status, which players and enemies can have.
class_name StatusSpeed
extends Node


@export var max_value: float = 1000

@export var value: float = 250:
	set(v):
		value = clampf(v, 0, max_value)
