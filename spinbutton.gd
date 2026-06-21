extends StaticBody3D

@onready var mesh = $MeshInstance3D
var original_material

func _ready():
	original_material = mesh.material_override

func highlight(state):
	if state:
		var mat = StandardMaterial3D.new()
		mat.albedo_color = Color(1, 1, 0) # yellow highlight
		mesh.material_override = mat
	else:
		mesh.material_override = original_material

func change_wall_colors():
	var Walls = get_tree().get_nodes_in_group("Walls")

	for wall in Walls:
		if wall is StaticBody3D:
			var mesh = wall.get_node("MeshInstance3D")

			if mesh:
				var mat = StandardMaterial3D.new()

				mat.albedo_color = Color(
					randf(),
					randf(),
					randf()
				)

				mesh.material_override = mat

func interact():
	print("Spin button clicked!")

	change_wall_colors()
