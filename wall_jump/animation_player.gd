extends AnimationPlayer


func _ready() -> void:
	play()


func _process(delta: float) -> void:
	if not is_playing():
		play("texture_swap")
