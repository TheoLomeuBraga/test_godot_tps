extends Node

var effect : AudioEffectRecord

var is_recording : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var idx = AudioServer.get_bus_index("Record")
	effect = AudioServer.get_bus_effect(idx, 0)
	effect.set_recording_active(is_recording)




var recording : AudioStreamWAV

func _on_button_pressed() -> void:
	
	
	
	is_recording = not is_recording
	effect.set_recording_active(is_recording)
	
	if not effect.is_recording_active():
		recording = effect.get_recording()


	
	if is_recording:
		$Control/VBoxContainer/Button.text = "stop"
	else:
		$Control/VBoxContainer/Button.text = "record"


func _on_button_2_pressed() -> void:
	$AudioStreamPlayer.stream = recording
	$AudioStreamPlayer.play()
	
