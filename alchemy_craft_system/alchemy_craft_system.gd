extends Control

@onready var opition_buttons : Array[OptionButton] = [
	$HBoxContainer/VBoxContainer/OptionButton1,
	$HBoxContainer/VBoxContainer/OptionButton2
]
@onready var output : Label = $HBoxContainer/Label

@onready var alchemyize : Button = $HBoxContainer/VBoxContainer/Button

@export var items : Array[AlchemyItem]

func get_item_by_name(name : String) -> AlchemyItem:
	for i : AlchemyItem in items:
		if i.item_name == name:
			return i
	return AlchemyItem.new()

func get_alchemize_items_distance(a : AlchemyItem,b : AlchemyItem) -> float:
	return sqrt( pow(b.cold_hot - a.cold_hot,2.0) + pow(b.close_far - a.close_far,2.0) )

func sort_alchemize_items_by_distance(item : AlchemyItem,a : AlchemyItem,b : AlchemyItem) -> bool:
	if get_alchemize_items_distance(item ,a) > get_alchemize_items_distance(item ,b):
		return true
	return false

func find_clossest_equivalent(item : AlchemyItem) -> AlchemyItem:
	var items_list : Array[AlchemyItem] = items.duplicate()
	items_list.sort_custom(sort_alchemize_items_by_distance.bind(item))
	return items_list[0]

func join_alchemy_spectruns(a : float , b : float) -> float:
	var ret : float
	if a < 0 and b < 0:
		ret = -(abs(a) + abs(b))
	else:
		ret = a + b
	print(a," ",b," ",ret,"\n")
	return clamp(ret,-100,100)

func combine_items(add_items : Array[AlchemyItem]) -> AlchemyItem:
	var ret : AlchemyItem = AlchemyItem.new()
	for i : AlchemyItem in add_items:
		ret.cold_hot = join_alchemy_spectruns(ret.cold_hot , i.cold_hot)
		ret.close_far = join_alchemy_spectruns(ret.close_far , i.close_far)
	
	return find_clossest_equivalent(ret)

func _ready() -> void:
	for b : OptionButton in opition_buttons:
		for i : AlchemyItem in items:
			b.add_item(i.item_name)

func alchemize() -> void:
	print("alchemize")
	var items_to_alchemize : Array[AlchemyItem]
	
	for ob : OptionButton in opition_buttons:
		items_to_alchemize.push_back(get_item_by_name(ob.get_item_text(ob.selected)))
		
	
	output.text = combine_items(items_to_alchemize).item_name
