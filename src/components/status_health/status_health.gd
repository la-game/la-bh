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
