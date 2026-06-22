extends StaticBody3D

@onready var mesh = find_child("MeshInstance3D", true, false)
var original_material

func _ready():
	original_material = mesh.material_override

func highlight(state):
	if state:
		var mat = StandardMaterial3D.new()
		mat.albedo_color = Color(0.5, 1.0, 0.5)
		mesh.material_override = mat
	else:
		mesh.material_override = original_material

func interact():
	get_tree().call_group("bet_ui", "open_bet_menu")
