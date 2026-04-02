extends Control

@onready var item_icon_cursor : TextureRect = $item_icon_cursor

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shot"):
		for c in $GridContainer.get_children():
			if c is GridInventoryItemFrame:
				var item_frame : GridInventoryItemFrame = c
				if item_frame.is_mouse_above:
					var storage : Texture2D = item_icon_cursor.texture
					item_icon_cursor.texture = item_frame.texture
					item_frame.texture = storage
					break
					
					
