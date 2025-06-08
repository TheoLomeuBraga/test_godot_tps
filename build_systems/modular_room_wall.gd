extends ModularRoomPart
class_name ModularRoomWall

@onready var wall : Node3D = $wall
@onready var door : Node3D = $door

func set_part(part: Parts):
	visible = part != Parts.NONE
	set_colisons_recursively(self,part == Parts.NONE)
