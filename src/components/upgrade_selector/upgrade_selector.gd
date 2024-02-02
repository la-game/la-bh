## Responsible to draw the options which player can upgrade their character.
class_name UpgradeSelector
extends CanvasLayer


const OPTION_SCENE: PackedScene = preload("res://src/components/upgrade_option/upgrade_option.tscn")

@export var player: Player

@export var container: Container

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

var basic_weapons: Array[PackedScene] = Weapons.get_basic_weapons()

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
	add_forge_weapon_option()
	add_learn_weapon_option()
	add_improve_status_option()


## Remove all upgrade options.
func clear() -> void:
	for child in container.get_children():
		child.queue_free()


## Return true if there is any upgrade option available.
func is_empty() -> bool:
	for child in container.get_children():
		if not child.is_queued_for_deletion():
			return false
	return true


## Add option to forge a new weapon using previous weapon(s).[br]
## In case there is no weapon to choose from, it will fall to [method add_learn_weapon_option].
func add_forge_weapon_option() -> void:
	var weapons: Array[Weapon] = []
	
	# We only care about weapons that can be upgraded.
	for w: Weapon in player.weapons.get_children():
		if w.upgrade and not w.is_queued_for_deletion():
			weapons.append(w)
	
	if weapons.size() <= 0:
		return add_learn_weapon_option()
	
	var index: int = rng.randi_range(0, weapons.size() - 1)
	var weapon: Weapon = weapons[index]
	var upgrade_option: UpgradeOption = OPTION_SCENE.instantiate()
	
	upgrade_option.load_weapon_description(weapon.upgrade)
	upgrade_option.button.pressed.connect(forge_weapon.bind(weapon.upgrade))
	container.add_child(upgrade_option)


## Add option to learn a new weapon.
## In case player doesn't have slot for new weapons, it will fall [method add_improve_status_option].
func add_learn_weapon_option() -> void:
	if basic_weapons.is_empty():
		return add_improve_status_option()
	
	var index: int = rng.randi_range(0, basic_weapons.size() - 1)
	var weapon_scene: PackedScene = basic_weapons[index]
	var upgrade_option: UpgradeOption = OPTION_SCENE.instantiate()
	
	upgrade_option.load_weapon_description(weapon_scene)
	upgrade_option.button.pressed.connect(learn_weapon.bind(weapon_scene))
	container.add_child(upgrade_option)
	


## Add option to improve a status.
func add_improve_status_option() -> void:
	var upgrade_option: UpgradeOption = OPTION_SCENE.instantiate()
	var improve_health = func() -> void: player.health.max_value += 50; points -= 1
	var improve_attack = func() -> void: player.attack.value += 0.5; points -= 1
	var improve_speed = func() -> void: player.speed.value += 10; points -= 1
	var status: int
	
	# Don't give option to increase speed in this case.
	if player.speed.value == player.speed.max_value:
		status = rng.randi_range(0, 1)
	else:
		status = rng.randi_range(0, 2)
	
	match status:
		0:
			upgrade_option.label.text = "Improve maximum health by 50"
			upgrade_option.button.pressed.connect(improve_health)
		1:
			upgrade_option.label.text = "Improve attack by 0.5"
			upgrade_option.button.pressed.connect(improve_attack)
		2:
			upgrade_option.label.text = "Improve speed by 10"
			upgrade_option.button.pressed.connect(improve_speed)
	
	container.add_child(upgrade_option)


## Creates a new weapon and remove weapon responsible for forging it.
func forge_weapon(weapon_scene: PackedScene) -> void:
	for weapon: Weapon in player.weapons.get_children():
		if weapon.upgrade == weapon_scene:
			weapon.queue_free()
			break
	
	player.weapons.add_child(weapon_scene.instantiate(), true)
	points -= 1


## Creates a new weapon.
func learn_weapon(weapon_scene: PackedScene) -> void:
	player.weapons.add_child(weapon_scene.instantiate(), true)
	basic_weapons.erase(weapon_scene)
	points -= 1
