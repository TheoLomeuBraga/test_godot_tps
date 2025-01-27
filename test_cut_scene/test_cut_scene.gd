extends Node3D



	

@export_multiline var text_1 : String 
var text_writen_1 : bool = false

@export_multiline var text_2 : String 
var text_writen_2 : bool = false

@export_multiline var text_3 : String 
var text_writen_3 : bool = false


func _ready() -> void:
	$AnimationPlayer.play("act_1")
	
	
	await $AnimationPlayer.animation_finished
	
	if text_writen_1 == false:
		$Control/RichTextLabel.write(text_1)
		text_writen_1 = true
	
	await $Control/RichTextLabel.write_finished
	
	await $WaitUntilInput.pressed
	
	if text_writen_2 == false:
		$Control/RichTextLabel.write(text_2)
		text_writen_2 = true
	
	await $Control/RichTextLabel.write_finished
	
	await $WaitUntilInput.pressed
	
	if text_writen_3 == false:
		$Control/RichTextLabel.write(text_3)
		text_writen_3 = true
	
	await $Control/RichTextLabel.write_finished
