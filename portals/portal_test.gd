extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func manage_portal_1() -> void:
	$portal1/SubViewport/Camera3D.position = $FreeCamera.position
	$portal1/SubViewport/Camera3D.rotation = $FreeCamera.rotation
	$portal1/SubViewport/Camera3D.position.x += 30
	

func manage_portal_2() -> void:
	$portal2/SubViewport/Camera3D.position = $FreeCamera.position
	$portal2/SubViewport/Camera3D.rotation = $FreeCamera.rotation
	$portal2/SubViewport/Camera3D.position.x -= 30

func _process(delta: float) -> void:
	manage_portal_1()
	manage_portal_2()
