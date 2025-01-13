extends Area3D

class_name InfoBoard

var current_dialog : int = 0
@export var dialogs : Array[String]

@onready var screen_base_scale : Vector3 = $screen.scale

var target_rot : Vector3

var rng : RandomNumberGenerator = RandomNumberGenerator.new()
func _on_timer_timeout() -> void:
	target_rot = screen_base_scale + Vector3(rng.randf_range(0,1),rng.randf_range(0,1),rng.randf_range(0,1))


func _ready() -> void:
	target_rot = screen_base_scale

enum GameEstate {
	NO_ACTION = 0,
	PLAYER_NEXT = 1,
	DIALOG = 2,
}

var estate : GameEstate = GameEstate.NO_ACTION

var charter : TpsCharter

func _process(delta: float) -> void:
	if estate == GameEstate.NO_ACTION:
		$screen.scale = $screen.scale.slerp(screen_base_scale,delta * 2)
		
	elif estate == GameEstate.PLAYER_NEXT:
		$screen.scale = $screen.scale.slerp(target_rot,delta * 2)
		if charter.is_on_floor() and Input.is_action_just_pressed("interact"):
			estate = GameEstate.DIALOG
			charter.estate = charter.PlayerGameEstates.NO_ACTION
		
	elif estate == GameEstate.DIALOG:
		$screen.scale = $screen.scale.slerp(target_rot,delta * 2)
		$TextDisplay/CenterContainer/RichTextLabel.text = dialogs[current_dialog]
		
		if Input.is_action_just_pressed("interact") or Input.is_action_just_pressed("shot"):
			
			current_dialog += 1
			if current_dialog >= dialogs.size():
				
				current_dialog = 0
				estate = GameEstate.NO_ACTION
				charter.estate = charter.PlayerGameEstates.START
	
	$TextDisplay.visible = estate == GameEstate.DIALOG
	

var color : Color:
	get():
		var mat : Material = $screen.mesh.material
		return mat.albedo_color
	set(value):
		var mat : Material = $screen.mesh.material
		mat.albedo_color = value
		$screen.mesh.material = mat

func _on_body_entered(body: Node3D) -> void:
	if body is TpsCharter:
		estate = GameEstate.PLAYER_NEXT
		color = Color(0.2,0.75,1.0)
		charter = body



func _on_body_exited(body: Node3D) -> void:
	if body is TpsCharter:
		estate = GameEstate.NO_ACTION
		color = Color(0.0,0.5,1.0)
