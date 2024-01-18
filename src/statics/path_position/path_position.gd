## Responsible to decide a position in the path(s).
class_name PathPosition
extends Node


static var rng: RandomNumberGenerator = RandomNumberGenerator.new()


## Get all PathFollow2Ds from the Path2Ds.
## [br][br]
## Useful when you have multiple Path2Ds (this happens when you need
## to build paths that are not connected).
static func get_paths_follows(paths: Array[Path2D]) -> Array[PathFollow2D]:
	var paths_follows: Array[PathFollow2D] = []
	
	for path in paths:
		for child in path.get_children():
			if child is PathFollow2D:
				paths_follows.append(child)
	
	return paths_follows


static func get_random_path_follow(paths: Array[PathFollow2D]) -> PathFollow2D:
	if not paths:
		return null
	
	var index: int = rng.randi_range(0, paths.size() - 1)
	return paths[index]


static func get_random_position_in_path_follow(path: PathFollow2D) -> Vector2:
	path.progress_ratio = rng.randf()
	return path.global_position
