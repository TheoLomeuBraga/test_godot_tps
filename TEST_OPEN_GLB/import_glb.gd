extends Node3D

@export_file_path("*.glb") var file_path : String
@export var animation : String = "walk"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var n : Node3D = load(file_path).instantiate()
	add_child(n)
	
	var ap : AnimationPlayer = n.get_node("AnimationPlayer") 
	if ap != null and ap.has_animation(animation):
		ap.play(animation)
