## Responsible to draw the options which player can upgrade their character.
class_name UpgradeSelector
extends CanvasLayer


const OPTION_SCENE: PackedScene = preload("res://src/components/upgrade_option/upgrade_option.tscn")

const UPGRADE_ARSENAL: PackedScene = preload("res://src/components/upgrade_option/upgrade_arsenal/upgrade_arsenal.tscn")

const UPGRADE_STATUS: PackedScene = preload("res://src/components/upgrade_option/upgrade_status/upgrade_status.tscn")

const UPGRADE_WEAPON: PackedScene = preload("res://src/components/upgrade_option/upgrade_weapon/upgrade_weapon.tscn")

@export var player: Player

@export var container: Container

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

## All weapons which player can learn.
var arsenal_options: Array[PackedScene] = Weapons.get_basic_weapons()

## This options are reseted every roll.
var arsenal_current_options: Array[PackedScene] = arsenal_options.duplicate()

## This options are reseted every roll.
var status_current_options: Array[int] = []

## This options are reseted every roll.
var weapons_current_options: Array[PackedScene] = []

var points: int = 0:
	set(p):
		p = max(0, p)
		
		if p == 0:
			clear()
		elif p >= 1:
			# Only refresh if the user spent points,
			# or if there was no points.
			if p < points or points == 0:
				refresh()
		
		if is_empty():
			hide()
		else:
			show()
		
		points = p


## Refresh the 3 upgrade options.[br]
## This means removing old and adding new ones.[br][br]
func refresh() -> void:
	clear()
	refill()
	add_upgrade_weapon_option()
	add_upgrade_arsenal_option()
	add_upgrade_status_option()


## Remove all upgrade options.
func clear() -> void:
	for child in container.get_children():
		child.queue_free()


## Refill options for status, weapons and upgrades.
func refill() -> void:
	arsenal_current_options = arsenal_options.duplicate()
	status_current_options = [UpgradeStatus.HEALTH, UpgradeStatus.ATTACK, UpgradeStatus.SPEED]
	weapons_current_options = []
	
	for w: Weapon in player.weapons.get_children():
		if w.upgrade and not w.is_queued_for_deletion():
			weapons_current_options.append(w.upgrade)


## Return true if there is any upgrade option available.
func is_empty() -> bool:
	for child in container.get_children():
		if not child.is_queued_for_deletion():
			return false
	return true


## Add option to upgrade the arsenal with a new weapon.
## In case player doesn't have slot for new weapons, it will fall [method add_upgrade_status_option].
func add_upgrade_arsenal_option() -> void:
	if arsenal_current_options.is_empty():
		return add_upgrade_status_option()
	
	var upgrade_arsenal: UpgradeArsenal = UPGRADE_ARSENAL.instantiate()
	upgrade_arsenal.player = player
	arsenal_current_options = upgrade_arsenal.random_weapon(arsenal_current_options)
	
	upgrade_arsenal.button.pressed.connect(
		func():
			points -= 1
			arsenal_options.erase(upgrade_arsenal.weapon_scene)
	)
	
	container.add_child(upgrade_arsenal)


## Add option to upgrade a status.
func add_upgrade_status_option() -> void:
	var upgrade_status: UpgradeStatus = UPGRADE_STATUS.instantiate()
	upgrade_status.player = player
	status_current_options = upgrade_status.random_status(status_current_options)
	
	upgrade_status.button.pressed.connect(func(): points -= 1)
	container.add_child(upgrade_status)


## Add option to upgrade a weapon.[br]
## In case there is no weapon to choose from, it will fall to [method add_upgrade_arsenal_option].
func add_upgrade_weapon_option() -> void:
	if weapons_current_options.size() <= 0:
		return add_upgrade_arsenal_option()
	
	var upgrade_weapon: UpgradeWeapon = UPGRADE_WEAPON.instantiate()
	upgrade_weapon.player = player
	weapons_current_options = upgrade_weapon.random_weapon(weapons_current_options)
	
	upgrade_weapon.button.pressed.connect(func(): points -= 1)
	container.add_child(upgrade_weapon)
