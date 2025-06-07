@tool
extends Node3D
class_name CubeCreator

var button_that_creates_cube : Button
var ep : EditorPlugin

func create_cube() -> void:
	print("I ll Create A Cube")
	var cube : MeshInstance3D  = MeshInstance3D.new()
	
	cube.mesh = BoxMesh.new()
	
	
	add_child(cube,true)
	cube.owner = get_parent()
	

func create_cube_button() -> Button:
	
	button_that_creates_cube = Button.new()
	button_that_creates_cube.text = "Create Cube"
	button_that_creates_cube.pressed.connect(create_cube)
	button_that_creates_cube.visible = false
	return button_that_creates_cube

func _process(delta: float) -> void:
	if Engine.is_editor_hint() and EditorInterface.get_selection().get_selected_nodes().size() == 1:
		button_that_creates_cube.visible = EditorInterface.get_selection().get_selected_nodes()[0] == self

func _enter_tree() -> void:
	if Engine.is_editor_hint():
		create_cube_button()
		ep = EditorPlugin.new()
		ep.add_control_to_container(EditorPlugin.CONTAINER_SPATIAL_EDITOR_MENU, button_that_creates_cube)
	

func _exit_tree() -> void:
	if Engine.is_editor_hint():
		ep.queue_free()
		button_that_creates_cube.queue_free()
