## Represent the shield status, which players and enemies can have.
class_name StatusShield
extends Node


@export var max_value: float

@export var value: float:
	set(v):
		v = clamp(v, 0, max_value)
		
		if value > 0 and v <= 0:
			queue_free()
		
		value = v


## Damage shield and returns how much exceeded it, so you can damage others shield (or health).
func damage(v: float) -> float:
	var exceed = value - v
	value -= v
	
	if exceed < 0:
		return abs(exceed)
	return 0
