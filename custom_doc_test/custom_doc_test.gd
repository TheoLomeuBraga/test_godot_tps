extends Node
class_name CustomDoc
##Custom Documentation Test

##is never called
signal never_call(data)

##just a number
var number : float = 0

##make fucking nothing
func do_thing() -> void:
	pass

##make fucking nothing whith a number
func do_thing_with_number(no : float) -> void:
	pass

##a useles static number
static var useles_static_number : float = 0

##a useles static function
static func useles_function_number() -> void:
	pass

##change to do diferent types of nothing
func _useles_function() -> void:
	pass
