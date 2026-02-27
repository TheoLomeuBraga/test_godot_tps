extends Label
class_name FPSCounter

func _process(delta: float) -> void:
	text = str(Engine.get_frames_per_second())
