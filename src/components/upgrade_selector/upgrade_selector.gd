## Responsible to draw the options which player can upgrade their character.
class_name UpgradeSelector
extends CanvasLayer


const OPTION_SCENE: PackedScene = preload("res://src/components/upgrade_option/upgrade_option.tscn")

@export var player: Player

@export var container: Container

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

var points: int = 0:
	set(p):
		p = max(0, p)
		
		if p == 0:
			clear()
			hide()
		elif p >= 1:
			# Only refresh if the user spent points,
			# or if there was no points.
			if p < points or points == 0:
				refresh()
			show()
		
		points = p


## Refresh the 3 upgrade options.[br]
## This means removing old and adding new ones.[br][br]
func refresh() -> void:
	clear()
	add_old_weapon_upgrade()
	add_new_weapon_upgrade()
	add_status_upgrade()


## Remove all upgrade options.
func clear() -> void:
	for child in container.get_children():
		child.queue_free()


## Add an upgrade that will replace a previous weapon.[br]
## In case there is no weapon to choose from, it will fall to [method add_new_weapon_upgrade].
func add_old_weapon_upgrade() -> void:
	var weapons: Array[Weapon] = []
	
	# We only care about weapons that can be upgraded.
	for w: Weapon in player.weapons.get_children():
		if w.upgrade and not w.is_queued_for_deletion():
			weapons.append(w)
	
	if weapons.size() <= 0:
		return add_new_weapon_upgrade()
	
	var index: int = rng.randi_range(0, weapons.size() - 1)
	var weapon: Weapon = weapons[index]
	
	if weapon.upgrade == null:
		return add_new_weapon_upgrade()
	
	add_option(weapon.upgrade)


## Add an upgrade that will insert itself as new weapon.
## In case player doesn't have slot for new weapons, it will fall [method add_status_upgrade].
func add_new_weapon_upgrade() -> void:
	pass


## Add an upgrade that will improve player status.
func add_status_upgrade() -> void:
	pass


## Add an [UpgradeOption] about the weapon.
func add_option(weapon_scene: PackedScene) -> void:
	var upgrade_option: UpgradeOption = OPTION_SCENE.instantiate()
	upgrade_option.weapon_scene = weapon_scene
	upgrade_option.pressed.connect(apply_upgrade)
	container.add_child(upgrade_option)


func apply_upgrade(weapon_scene: PackedScene) -> void:
	# Find the weapon locally and make only one RPC to others.
	for weapon: Weapon in player.weapons.get_children():
		if weapon.upgrade == weapon_scene:
			player.weapons.forge_upgrade.rpc(weapon.get_path())
			break
	
	points -= 1
