extends Button

var tween_x : Tween
var tween_y : Tween
var tween_rot : Tween

func hover() -> void:
	tween_x = create_tween()
	tween_y = create_tween()
	tween_rot = create_tween()
	
	tween_x.tween_property(self, "offset_transform_scale:x", 1.2, 0.15)
	tween_y.tween_property(self, "offset_transform_scale:y", 1.2, 0.15)
	tween_rot.tween_property(self, "offset_transform_rotation", 0.2, 0.15).set_trans(Tween.TRANS_BOUNCE)

func unhover() -> void:
	tween_x = create_tween()
	tween_y = create_tween()
	tween_rot = create_tween()
	
	tween_x.tween_property(self, "offset_transform_scale:x", 1.0, 0.1)
	tween_y.tween_property(self, "offset_transform_scale:y", 1.0, 0.1)
	tween_rot.tween_property(self, "offset_transform_rotation", 0, 0.1)

func click() -> void:
	tween_x = create_tween()
	tween_y = create_tween()
	
	tween_x.tween_property(self, "offset_transform_scale:x", 0.8, 0.05)
	tween_y.tween_property(self, "offset_transform_scale:y", 0.8, 0.05)
	
	await tween_y.finished
	
	tween_x = create_tween()
	tween_y = create_tween()
	
	tween_x.tween_property(self, "offset_transform_scale:x", 1.2, 0.15)
	tween_y.tween_property(self, "offset_transform_scale:y", 1.2, 0.15)
	

func _ready() -> void:
	mouse_entered.connect(hover)
	mouse_exited.connect(unhover)
	pressed.connect(click)
