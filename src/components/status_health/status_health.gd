## Represent the health status, which players and enemies can have.
class_name StatusHealth
extends Node


signal reached_zero


@export var health_bar: TextureProgressBar

@export var shields: Array #

@export var max_value: float:
	set(v):
		if health_bar:
			health_bar.max_value = v
		
		max_value = v

@export var value: float:
	set(v):
		v = clamp(v, 0, max_value)
		
		if health_bar:
			health_bar.value = v
		
		if value > 0 and v <=0:
			reached_zero.emit()
		
		value = v


func _ready() -> void:
	if health_bar:
		health_bar.value = value
		health_bar.max_value = max_value


## Damage health but goes through shields before.
func damage(v: float) -> void:
	pass
