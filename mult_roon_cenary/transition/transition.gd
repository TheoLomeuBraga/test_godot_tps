extends Area3D


var working : bool = false

@export_file("*.tscn") var next_sceane : String
@export var tag : String

func _ready() -> void:
	if TransitionManager.player != null and TransitionManager.next_tag == tag:
		TransitionManager.player.global_position = global_position

func _on_timer_timeout() -> void:
	working = true





func _on_body_entered(body: Node3D) -> void:
	print("A",working)
	if body is TpsCharter and  working:
		print("B")
		TransitionManager.transitionate(next_sceane,tag)
