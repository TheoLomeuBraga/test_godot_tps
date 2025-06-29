extends Node3D
class_name BulletHell2

static var manager : BulletHell2

@export var bullet_sceane : PackedScene

var bullet_pool : Array[Node3D]





func hide_bullet(n : Node3D) -> void:
	bullet_pool.push_back(n)
	remove_child(n)

var bullet_count : int = 0

func spawn_bullet() -> Node3D:
	if bullet_pool.size() > 0:
		var last_item_id : int = bullet_pool.size() - 1
		var ret : Node3D = bullet_pool[last_item_id]
		bullet_pool.remove_at(last_item_id)
		return ret
	
	bullet_count+=1
	print("spawned ",bullet_count," bullets")
	var b : Node3D = bullet_sceane.instantiate()
	return b

func spawn() -> void:
	
	for i in range(0,36):
		var b : Node3D = spawn_bullet()
		add_child(b)
		b.global_position = Vector3.ZERO
		b.rotation_degrees.y = i * 10

func _ready() -> void:
	manager = self
	spawn()
