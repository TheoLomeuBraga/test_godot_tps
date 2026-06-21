extends Control

var window : Window

func  _ready() -> void:
	window = get_tree().get_root()
	window.borderless = true
	$VBoxContainer/HBoxContainer/Button2.pressed.connect(get_tree().quit)

var grabed : bool = false
var grab_location : Vector2i

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shot"):
		grabed = true
		grab_location = DisplayServer.mouse_get_position()
	elif Input.is_action_just_released("shot"):
		grabed = false
	
	if grabed:
		get_window().set_position(grab_location - DisplayServer.mouse_get_position())
