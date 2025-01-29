extends Node

var player : TpsCharter

var next_sceane_path : String
var next_tag : String

func transitionate(sceane_path : String,tag : String) -> void:
	if TpsCharter:
		next_sceane_path = sceane_path
		next_tag = tag
		get_tree().change_scene_to_file(sceane_path)
