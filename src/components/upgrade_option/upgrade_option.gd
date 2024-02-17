## Responsible to show the user the upgrade which will receive on selecting this option.
class_name UpgradeOption
extends HBoxContainer


@export var button: Button

@export var rich_text_label: RichTextLabel

var player: Player

var rng: RandomNumberGenerator = RandomNumberGenerator.new()


## Instiante a temporary weapon to extract information from it.
## NOTE: We need to manually free because it's not inside tree and it's not reference counted.
func load_description_from_weapon(weapon_scene: PackedScene) -> void:
		var weapon: Weapon = weapon_scene.instantiate() as Weapon
		button.icon = weapon.description.icon
		rich_text_label.text = weapon.description.text
		weapon.free()
