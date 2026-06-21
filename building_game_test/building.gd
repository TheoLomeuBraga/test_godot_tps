extends Node3D

var build_button_selected : bool = false

func _ready() -> void:
	var mouse_enter : Callable = func():build_button_selected=true
	$Area3D.mouse_entered.connect(mouse_enter)
	var mouse_exit : Callable = func():build_button_selected=false
	$Area3D.mouse_exited.connect(mouse_exit)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("shot") and build_button_selected and $Area3D != null:
		var v : Node3D = load(scene_file_path).instantiate()
		add_child(v)
		v.transform = $Area3D.transform
		$Area3D.queue_free()
