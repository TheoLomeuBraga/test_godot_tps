extends FreeCamera
class_name GrabSystem

@onready var joint: Joint3D = $Generic6DOFJoint3D
@onready var ray: RayCast3D = $RayCast3D

var has_object : bool = false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if not has_object:
			if ray.is_colliding() && ray.get_collider() is RigidBody3D:
				joint.node_b = ray.get_collider().get_path()
				has_object = true
		else:
			joint.node_b = ""
			has_object = false
