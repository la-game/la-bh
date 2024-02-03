class_name UpgradeWeapon
extends UpgradeOption


var weapon_scene: PackedScene


## Choose a random weapon from the list to upgrade.[br]
## Return remaining options.[br]
func random_weapon(options: Array[PackedScene]) -> Array[PackedScene]:
	var index: int = rng.randi_range(0, options.size() - 1)
	weapon_scene = options[index]
	
	load_description_from_weapon(weapon_scene)
	button.pressed.connect(upgrade_arsenal)
	
	return options


func upgrade_arsenal() -> void:
	# Find weapon that is being upgraded and remove it.
	for weapon: Weapon in player.weapons.get_children():
		if weapon.upgrade == weapon_scene:
			weapon.queue_free()
			break
	
	player.weapons.add_child(weapon_scene.instantiate(), true)
