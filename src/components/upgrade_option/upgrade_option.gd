## Responsible to show the user the upgrade which will receive on selecting this option.
class_name UpgradeOption
extends HBoxContainer


@export var button: Button

@export var rich_text_label: RichTextLabel


func load_weapon_description(weapon_scene: PackedScene) -> void:
		# Instiante a temporary weapon to extract information from it.
		# NOTE: We need to manually free because it's not inside tree and it's not reference counted.
		var weapon: Weapon = weapon_scene.instantiate() as Weapon
		button.icon = weapon.description.icon
		rich_text_label.text = weapon.description.text
		weapon.free()
