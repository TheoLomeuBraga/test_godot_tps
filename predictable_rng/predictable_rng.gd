extends Node

func _ready() -> void:
	var rng : RandomNumberGenerator
	rng = RandomNumberGenerator.new()
	rng.seed = 123
	print(rng.randi_range(0,10),rng.randi_range(0,10),rng.randi_range(0,10))
	
	rng = RandomNumberGenerator.new()
	rng.seed = 123
	print(rng.randi_range(0,10),rng.randi_range(0,10),rng.randi_range(0,10))
