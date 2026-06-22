extends StaticBody3D

@onready var mesh = $MeshInstance3D
var original_material
var original_position

func _ready():
	original_material = mesh.material_override
	original_position = position
	
func press_animation():
	position.y -= 0.05

	await get_tree().create_timer(0.1).timeout

	position = original_position

func highlight(state):
	if state:
		var mat = StandardMaterial3D.new()
		mat.albedo_color = Color(1, 1, 0)
		mesh.material_override = mat
	else:
		mesh.material_override = original_material

func interact():
	press_animation()

	print("Spin button clicked!")

	var table = get_parent().get_node("new spinny table again2_0")
	table.spin()
