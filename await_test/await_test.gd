extends Node3D


func _ready() -> void:
	$Timer1.start()
	$Timer2.start()
	$Timer3.start()

func make_visible() -> void:
	
	await $Timer1.timeout
	$red.visible = true
	
	await $Timer2.timeout
	$green.visible = true
	
	await $Timer3.timeout
	$blue.visible = true

var b : bool = true
func _process(delta: float) -> void:
	if b == true:
		b = false
		make_visible()
