extends Timer

class_name SelfDestruct


func _ready() -> void:
	autostart = true
	timeout.connect(queue_free)
