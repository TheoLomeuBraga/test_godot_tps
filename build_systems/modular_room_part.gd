extends Node3D
class_name ModularRoomPart

func set_colisons_recursively(n:Node,disable : bool):
	if n is CollisionShape3D:
		n.disabled = disable
	for c in n.get_children():
		set_colisons_recursively(c,disable)

enum  Parts {NONE,WALL,DOOR}
func set_part(part: Parts):
	visible = part != Parts.NONE
	set_colisons_recursively(self,part == Parts.NONE)
