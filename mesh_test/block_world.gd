extends GridMap

const air = -1
const grass = 0
const stone = 1

const total_size = 32 * 32 * 32

var current_block_count : int = 0

func _ready() -> void:
	for x in 32:
		for y in 32:
			for z in 32:
				set_cell_item(Vector3i(x,y,z),grass)
				current_block_count += 1
				print(current_block_count," from ",total_size)
	
	
