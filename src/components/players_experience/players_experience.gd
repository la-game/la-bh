class_name PlayersExperienceBar
extends CanvasLayer


signal level_up

@export var max_value: float:
	set(v):
		if experience_bar:
			experience_bar.max_value = v
		
		max_value = v

@export var value: float:
	set(v):
		v = clamp(v, 0, max_value)
		
		if v == max_value:
			level_up.emit()
			v = 0
			max_value *= 1.2
		
		value = v
		
		if experience_bar:
			experience_bar.value = v

@export var experience_bar: TextureProgressBar
