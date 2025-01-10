extends Node3D

@export var rooms_templates : Array[PackedScene]

@export var secret_rooms_templates : Array[PackedScene]

@export var first_room : PackedScene
@export var last_room : PackedScene

@export var room_count : int = 5

var room_current_count : int = 0
var last_room_created : Room

@export var room_joint : PackedScene
func create_room_joint(node : Node3D) -> void:
	var joint : Node3D = room_joint.instantiate()
	add_child(joint)
	joint.global_position = node.global_position
	joint.global_rotation = node.global_rotation

func spawn_secret_room() -> void:
	
	var r : Room = secret_rooms_templates[rng.randi_range(0,secret_rooms_templates.size() - 1)].instantiate()
	add_child(r)
	
	if last_room_created != null:
		r.global_position = last_room_created.secret_exit.global_position
		r.global_rotation = last_room_created.secret_exit.global_rotation
		create_room_joint(last_room_created.secret_exit)
	
	room_current_count += 1

var rng : RandomNumberGenerator = RandomNumberGenerator.new()
func spawn_room() -> bool:
	
	var r : Room = rooms_templates[rng.randi_range(0,rooms_templates.size() - 1)].instantiate()
	add_child(r)
	
	if last_room_created != null:
		
		if last_room_created.secret_exit != null:
			spawn_secret_room()
		
		r.global_position = last_room_created.exit.global_position
		r.global_rotation = last_room_created.exit.global_rotation
		create_room_joint(last_room_created.exit)
	
	last_room_created = r
	room_current_count += 1
	
	if room_current_count < room_count:
		return true
	return false

func spawn_first() -> void:
	var r : Room = first_room.instantiate()
	add_child(r)
	
	if last_room_created != null:
		
		if last_room_created.secret_exit != null:
			spawn_secret_room()
		
		r.global_position = last_room_created.exit.global_position
		r.global_rotation = last_room_created.exit.global_rotation
	
	last_room_created = r
	room_current_count += 1

func spawn_last() -> void:
	var r : Room = last_room.instantiate()
	add_child(r)
	
	if last_room_created != null:
		r.global_position = last_room_created.exit.global_position
		r.global_rotation = last_room_created.exit.global_rotation
	
	room_current_count += 1

func _ready() -> void:
	spawn_first()
	while spawn_room():
		pass
	spawn_last()
