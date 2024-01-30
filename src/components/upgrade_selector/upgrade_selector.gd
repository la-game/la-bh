## Responsible to draw the options which player can upgrade their character.
class_name UpgradeSelector
extends CanvasLayer


const OPTION_SCENE: PackedScene = preload("res://src/components/upgrade_option/upgrade_option.tscn")

@export var player_weapons: Node

@export var container: Container

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

var points: int = 0:
	set(p):
		if p == 1:
			fill()
			show()
		elif p <= 0:
			clear()
			hide()


func fill() -> void:
	clear()
	add_old_weapon_upgrade()
	add_new_weapon_upgrade()
	add_status_upgrade()


func clear() -> void:
	for child in container.get_children():
		child.queue_free()


## Add an upgrade that will replace a previous weapon.[br]
## In case there is no weapon to choose from, it will fall to [method add_new_weapon_upgrade].
func add_old_weapon_upgrade() -> void:
	var weapons_count: int = player_weapons.get_child_count()
	
	if weapons_count <= 0:
		return add_new_weapon_upgrade()
	
	var index: int = rng.randi_range(0, weapons_count - 1)
	var weapon: Weapon = player_weapons.get_child(index) as Weapon
	
	if not weapon.upgrade:
		return add_new_weapon_upgrade()
	
	add_option(weapon.upgrade)


## Add an upgrade that will insert itself as new weapon.
## In case player doesn't have slot for new weapons, it will fall [method add_status_upgrade].
func add_new_weapon_upgrade() -> void:
	pass


## Add an upgrade that will improve player status.
func add_status_upgrade() -> void:
	pass


func add_option(weapon_scene: PackedScene) -> void:
	var weapon: Weapon = weapon_scene.instantiate() as Weapon
	container.add_child(OPTION_SCENE.instantiate().init(weapon))
	
	# We need to manually free because it's not inside tree and it's not reference counted.
	weapon.free()
