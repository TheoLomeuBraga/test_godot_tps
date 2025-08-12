extends Node
class_name ButtonAnimationComponent

var parent : Button

var tween : Tween


@export var trensition_type :  Tween.TransitionType
@export var trensition_duration :  float = 0.5
@export var target_scale : Vector2 = Vector2(2.0,2.0)
@export var ajust_pivo : bool = true
func on_hover_enter() -> void:
	if get_tree() == null:
		return
	tween = get_tree().create_tween()
	tween.tween_property(parent, "scale", target_scale, trensition_duration).set_trans(trensition_type)

func on_hover_exit() -> void:
	if get_tree() == null:
		return
	tween = get_tree().create_tween()
	tween.tween_property(parent, "scale", Vector2(1.0,1.0), trensition_duration).set_trans(trensition_type)

func ajust_position() -> void:
	var lable : Control = parent.get_node("Label")
	if lable != null:
		lable.top_level = true
		lable.global_position = parent.global_position
	
	if ajust_pivo:
		parent.pivot_offset = parent.size / 2

func _ready() -> void:
	parent = get_parent()
	parent.mouse_entered.connect(on_hover_enter)
	parent.focus_entered.connect(on_hover_enter)
	
	parent.mouse_exited.connect(on_hover_exit)
	parent.focus_exited.connect(on_hover_exit)
	
	
	
	call_deferred("ajust_position")
	
	
	
