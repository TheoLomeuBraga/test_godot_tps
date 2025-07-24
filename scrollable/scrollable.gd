extends Control


func _ready() -> void:
	for i in 101:
		var button : Button = Button.new()
		button.text = "button no: " + str(i)
		$ScrollContainer/VBoxContainer.add_child(button)


func _process(delta: float) -> void:
	pass
