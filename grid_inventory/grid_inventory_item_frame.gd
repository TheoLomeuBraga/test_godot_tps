@tool
extends Control
class_name GridInventoryItemFrame

var is_mouse_above : bool = false
func check_is_mouse_above() -> void:
	is_mouse_above = true

func uncheck_is_mouse_above() -> void:
	is_mouse_above = false

func _ready() -> void:
	$TextureRect.mouse_entered.connect(check_is_mouse_above)
	$TextureRect.mouse_exited.connect(uncheck_is_mouse_above)
	

@export var texture : Texture2D :
	set(value):
		texture = value
		if $TextureRect != null:
			$TextureRect.texture = texture
