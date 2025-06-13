extends CharacterBody3D

var floor : bool = false
var air_pause : bool = false

func update_values() -> void:
	floor = is_on_floor() and velocity.y <= 0
	air_pause = Input.is_action_pressed("interact")

func _physics_process(delta: float) -> void:
	update_values()
