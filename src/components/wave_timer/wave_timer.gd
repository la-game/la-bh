class_name WaveTimer
extends CanvasLayer


@export var wave_rotation: WaveRotation

@export var wave_label: Label

@export var timer_label: Label


func _process(delta: float) -> void:
	var time_left: int = wave_rotation.wave_timer.time_left
	var datetime: Dictionary = Time.get_datetime_dict_from_unix_time(time_left)
	
	wave_label.text = "Wave %s - " % wave_rotation.current
	timer_label.text = "%s:%s" % [datetime["minute"], datetime["second"]]
