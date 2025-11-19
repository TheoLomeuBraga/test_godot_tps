extends MeshInstance3D
class_name Leg

var max_distance : float = 1.0

var rng : RandomNumberGenerator = RandomNumberGenerator.new()

var target_pos : Vector3
func _ready() -> void:
	target_pos = global_position
	

var t : Tween
func step(pos : Vector3):
	t = create_tween()
	
	var midle_point : Vector3 = lerp(global_position,target_pos,0.5)
	midle_point += get_parent().basis.y
	t.tween_property(self,"global_position",midle_point,0.1)
	t.tween_property(self,"global_position",target_pos,0.1)

	max_distance = rng.randf_range(0.8,1.2)
	target_pos = pos

func update(pos : Vector3) -> void:
	if target_pos.distance_to(pos) > max_distance:
		step(pos)
