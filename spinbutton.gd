extends StaticBody3D

@onready var mesh = $MeshInstance3D
var original_material
var original_position
var failed_spins = 0

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
	var game = get_node("/root/Main/GameManager")
	var ui = get_node("/root/Main/UI")

	if game.current_bets.is_empty():

		failed_spins += 1

		if failed_spins >= 5:
			ui.show_message("Place a fucking bet already!")
		else:
			ui.show_message("Place bets before trying to spin the wheel!")

		return

	failed_spins = 0

	press_animation()

	var table = get_parent().get_node("Final fucking table")
	table.spin()

	var betting_table = get_node("/root/Main/BettingTable")
	betting_table.clear_bets()

	game.current_bets.clear()
