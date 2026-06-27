extends Node

const burned : int = 1
const frezed : int = (1 << 1)
const imobilized : int = (1 << 2)
const eletrecuted : int = (1 << 3)

@export_flags("1","2","4","8","16","32","64","128","256") var flags : int

func to_b64(v:int) -> String:
	return Marshalls.variant_to_base64(v)

func from_b64(v:String) -> int:
	return Marshalls.base64_to_variant(v)

func _ready() -> void:
	var bits : int = 1
	bits = 1 << 4
	print(bits)
	bits = bits >> 2
	print(bits)
	bits = bits ^ 1
	print(bits)
	bits = bits & ( 1 >> 2 )
	print(bits)
	bits = 1
	bits = bits << 1
	bits += 1
	bits = bits << 1
	bits += 1
	print(bits)
	bits = 1
	bits = bits << 2
	bits += 1
	print(bits)
	
	print("stats test")
	bits = frezed | imobilized
	if bits & burned > 0:
		print("burned")
	if bits & frezed > 0:
		print("frezed")
	if bits & imobilized > 0:
		print("imobilized")
	if bits & eletrecuted > 0:
		print("eletrecuted")
	
	var f : int = flags
	print("f: ",f)
	var fs : String = to_b64(f)
	print("fs: ",fs)
	var fsf : int = from_b64(fs)
	print("fsf: ",fsf)
