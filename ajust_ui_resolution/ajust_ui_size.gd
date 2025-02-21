
extends Control

func _ready() -> void:
	
	for i in get_child_count():
		var c : Node = get_child(i)
		if c != null and not c is SubViewport:
			c.get_parent().remove_child(c)
			$SubViewport.add_child(c)

func _input(event: InputEvent) -> void:
	$SubViewport.push_input(event)
