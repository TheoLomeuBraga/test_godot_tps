extends Camera3D

@export var mouse_sensitivity : float = 6
@export var speed : float = 12

var can_look_around : bool  = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		can_look_around = Input.is_action_pressed("hide_mouse")
		if can_look_around:
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			rotation_degrees.x -= event.relative.y * mouse_sensitivity / 10
			rotation_degrees.y -= event.relative.x * mouse_sensitivity / 10
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _process(delta: float) -> void:
	if rotation_degrees.x > 90:
		rotation_degrees.x = 90
	elif rotation_degrees.x < -90:
		rotation_degrees.x = -90
	
	
	
	if Input.is_action_pressed("run"):
		position += basis.z * speed * delta * Input.get_axis("front","back") * 2
		position += basis.x * speed * delta * Input.get_axis("left","right") * 2
	else:
		position += basis.z * speed * delta * Input.get_axis("front","back")
		position += basis.x * speed * delta * Input.get_axis("left","right")
