extends RichTextLabel

var speed : float = 1
func write(t : String,s : float = 1):
	text = t
	visible_ratio = 0
	speed = s

signal write_finished
func _process(delta: float) -> void:
	
	if visible_ratio >= 1:
		write_finished.emit()
	
	if visible_ratio > 0 and Input.is_action_just_pressed("shot"):
		visible_ratio = 1
	
	visible_ratio += speed * delta
