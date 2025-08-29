extends Camera3D


@export var shake_curve_x : Curve = Curve.new()
@export var shake_curve_y : Curve = Curve.new()
@export var shake_power : float = 0.1

var time : float = 0
func _process(delta: float) -> void:
	time+=delta
	position.x = shake_curve_x.sample(time) * shake_power
	position.y = shake_curve_y.sample(time) * shake_power
	
	if time > 1.0:
		time-=1.0
