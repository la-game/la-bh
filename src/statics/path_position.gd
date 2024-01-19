## Responsible to decide a position in the path(s).
class_name PathPosition
extends RefCounted


static var rng: RandomNumberGenerator = RandomNumberGenerator.new()


static func get_random_path_follow(paths: Array[PathFollow2D]) -> PathFollow2D:
	if not paths:
		return null
	
	var index: int = rng.randi_range(0, paths.size() - 1)
	return paths[index]


static func get_random_position_in_path_follow(path: PathFollow2D) -> Vector2:
	path.progress_ratio = rng.randf()
	return path.global_position
