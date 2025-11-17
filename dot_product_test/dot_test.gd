extends Node



func _ready() -> void:
	print(Vector3.UP.dot(Vector3.UP))
	print(Vector3.UP.dot(-Vector3.UP))
	
	print(Vector3.UP.dot(Vector3.UP/2))
	print(Vector3.UP.dot(Vector3.LEFT))
	
	print((Vector3.UP).dot(Vector3.UP * 2))
