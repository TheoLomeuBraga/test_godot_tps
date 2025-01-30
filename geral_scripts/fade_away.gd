extends Timer

class_name FadeAway

@export var after_image_material : Material

func set_mat(node : Node):
	if node is MeshInstance3D:
		var n : MeshInstance3D = node
		n.material_override = after_image_material
	
	for c in node.get_children():
		set_mat(c)

func _ready() -> void:
	autostart = true
	timeout.connect(queue_free)
	
	after_image_material = after_image_material.duplicate()
	
	set_mat(get_child(0))



func _process(delta: float) -> void:
	var color : Color = after_image_material.get_shader_parameter("albedo")
	color.a = time_left / wait_time
	after_image_material.set_shader_parameter("albedo",color)
