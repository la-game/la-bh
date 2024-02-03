class_name UpgradeArsenal
extends UpgradeOption


var weapon_scene: PackedScene


## Choose a random weapon from the list to add to arsenal.[br]
## Return remaining options.[br]
func random_weapon(options: Array[PackedScene]) -> Array[PackedScene]:
	var index: int = rng.randi_range(0, options.size() - 1)
	weapon_scene = options[index]
	
	load_description_from_weapon(weapon_scene)
	button.pressed.connect(upgrade_arsenal)
	
	return options


func upgrade_arsenal() -> void:
	player.weapons.add_child(weapon_scene.instantiate(), true)
