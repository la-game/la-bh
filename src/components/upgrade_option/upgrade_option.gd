## Responsible to show the user the upgrade which will receive on selecting this option.
class_name UpgradeOption
extends HBoxContainer


signal pressed(weapon_scene: PackedScene)

@export var button: Button

@export var label: RichTextLabel

var weapon_scene: PackedScene:
	set(scene):
		weapon_scene = scene
		
		# Instiante a temporary weapon to extract information from it.
		# NOTE: We need to manually free because it's not inside tree and it's not reference counted.
		var weapon: Weapon = weapon_scene.instantiate() as Weapon
		button.icon = weapon.description.icon
		label.text = weapon.description.text
		weapon.free()


func _on_button_pressed() -> void:
	pressed.emit(weapon_scene)
