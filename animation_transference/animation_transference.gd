@tool
extends Node3D

var tm : TransferModfyer

func _ready() -> void:
	if !tm:
		tm = TransferModfyer.new()
		$template_psx_charter.skelenton.add_child(tm)
		tm.skelenton_2 = $demo_model.skelenton
