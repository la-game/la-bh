class_name PlayerReviver
extends Area2D


## Emitted when the [PlayerReviver] finish it job.[br]
## NOTE: This doesn't mean that [member value] reached [member max_value].
signal finished

@export var player: Player

@export var revive_bar: TextureProgressBar

@export var max_value: float:
	set(v):
		if revive_bar:
			revive_bar.max_value = v
		
		max_value = v

@export var value: float:
	set(v):
		v = clampf(v, 0, max_value)
		
		if revive_bar:
			revive_bar.value = v
		
		# Only when reach the first time.
		if value != max_value and v == max_value:
			finish()
		
		value = v


func _ready() -> void:
	set_process(false)
	
	if revive_bar:
		revive_bar.value = value
		revive_bar.max_value = max_value
		revive_bar.visible = false


func _process(delta: float) -> void:
	if not monitoring:
		return
	
	var count: int = get_overlapping_bodies().filter(
		func(p: Player):
			return p != player and p.alive
	).size()
	
	value += count * delta


## Initiate the reviving process.
func initiate() -> void:
	set_process(true)
	
	monitoring = true
	revive_bar.visible = true
	value = 0


## Finish the reviving process and emit [signal finished].[br][br]
func finish() -> void:
	set_process(false)
	
	monitoring = false
	revive_bar.visible = false
	finished.emit()
