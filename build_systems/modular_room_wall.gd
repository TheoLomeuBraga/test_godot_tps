extends ModularRoomPart
class_name ModularRoomWall

@onready var wall : Node3D = $wall
@onready var door : Node3D = $door

func set_part(part: Parts):
	wall.visible = false
	door.visible = false
	set_colisons_recursively(self,true)
	
	if part == Parts.WALL:
		wall.visible = true
		set_colisons_recursively(wall,false)
	
	if part ==  Parts.DOOR:
		door.visible = true
		set_colisons_recursively(door,false)
	
