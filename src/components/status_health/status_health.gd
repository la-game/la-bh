## Represent the health status, which players and enemies can have.
class_name StatusHealth
extends Node


signal reached_zero

@export var health_bar: TextureProgressBar

@export var shield_bar: TextureProgressBar

@export var max_value: float:
	set(v):
		if health_bar:
			health_bar.max_value = v
		
		max_value = v

@export var value: float:
	set(v):
		if immutable:
			return
		
		v = clamp(v, 0, max_value)
		
		if health_bar:
			health_bar.value = v
		
		if value > 0 and v <= 0:
			reached_zero.emit()
		
		value = v

## Block changes to health and shields value.[br]
## This can be used to avoid changing health when the player is dead.
var immutable: bool = false


func _ready() -> void:
	if health_bar:
		health_bar.value = value
		health_bar.max_value = max_value


## Damage health but goes through shields before.
func damage(v: float) -> void:
	if immutable:
		return
	
	# Damaging shields.
	for shield: StatusShield in get_children():
		var exceed = shield.damage(v)
		update_shield_bar()
		
		if exceed == 0:
			return
		
		v = exceed
	
	# Damaging health.
	value -= v


## Add shield to be processed before health.
func add_shield(shield: StatusShield) -> void:
	shield.tree_exited.connect(update_shield_bar)
	
	add_child(shield)
	update_shield_bar()


## Update shield bar visual.
func update_shield_bar() -> void:
	if not shield_bar:
		return
	
	var shield_max_value = 0
	var shield_value = 0
	
	for shield in get_children():
		if shield is StatusShield:
			shield_max_value += shield.max_value
			shield_value += shield.value
	
	shield_bar.max_value = shield_max_value
	shield_bar.value = shield_value
