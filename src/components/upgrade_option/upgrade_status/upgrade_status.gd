class_name UpgradeStatus
extends UpgradeOption


enum {
	HEALTH,
	ATTACK,
	SPEED,
}

var health: float = 50

var attack: float = 0.5

var speed: float = 10


## Choose a random status from the list to upgrade.[br]
## Return remaining options.[br]
## NOTE: Maximized status are removed.
func random_status(options: Array[int]) -> Array[int]:
	if player.speed.value == player.speed.max_value:
		options.erase(SPEED)
	
	# If there is no option, free it so the user can't spend points.
	if options.is_empty():
		queue_free()
		return options
	
	var index: int = rng.randi_range(0, options.size() - 1)
	var status: int = options[index]
	
	match status:
		HEALTH:
			rich_text_label.text = "Increase maximum health by %s" % health
			button.pressed.connect(upgrade_health)
		ATTACK:
			rich_text_label.text = "Increase attack by %s" % attack
			button.pressed.connect(upgrade_attack)
		SPEED:
			rich_text_label.text = "Increase speed by %s" % speed
			button.pressed.connect(upgrade_speed)
	
	options.erase(status)
	
	return options


func upgrade_health() -> void:
	player.health.max_value += health


func upgrade_attack() -> void:
	player.attack.value += attack


func upgrade_speed() -> void:
	player.speed.value += speed
