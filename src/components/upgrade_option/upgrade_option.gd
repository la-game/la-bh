## Responsible to show the user the upgrade which will receive on selecting this option.
class_name UpgradeOption
extends HBoxContainer


@export var button: Button

@export var label: RichTextLabel


func init(weapon: Weapon) -> UpgradeOption:
	button.icon = weapon.description.icon
	label.text = weapon.description.text
	
	return self
