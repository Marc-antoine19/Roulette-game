extends StaticBody3D

@onready var mesh = find_child("MeshInstance3D", true, false)
@onready var chip_scene = preload("res://chip.tscn")
@onready var bet_positions = $"roulette table/BetPositions"

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

func show_bets(bets):

	if bet_positions == null:
		print("BetPositions missing!")
		return

	for bet in bets:

		var marker_name = ""

		if typeof(bet) == TYPE_INT:
			marker_name = "Spot" + str(bet)
		elif bet == "RED":
			marker_name = "RedSpot"
		elif bet == "BLACK":
			marker_name = "BlackSpot"
		elif bet == "EVEN":
			marker_name = "EvenSpot"
		elif bet == "ODD":
			marker_name = "OddSpot"
		elif bet == "1st on 12":
			marker_name = "1st12Spot"
		elif bet == "2nd on 12":
			marker_name = "2nd12Spot"
		elif bet == "3rd on 12":
			marker_name = "3rd12Spot"
		elif bet == "1 to 18":
			marker_name = "1to18Spot"
		elif bet == "19 to 36":
			marker_name = "19to36Spot"
		elif bet == "1st 2 to 1":
			marker_name = "2to1Spot"
		elif bet == "2nd 2 to 1":
			marker_name = "2to1Spot2"
		elif bet == "3rd 2 to 1":
			marker_name = "2to1Spot3"
		elif bet == "00":
			marker_name = "Spot00"

		if not bet_positions.has_node(marker_name):
			continue

		var marker = bet_positions.get_node(marker_name)

		var amount = bets[bet]
		var chip_value = 100
		var chip_count = int(amount / chip_value)

		var existing_chips = marker.get_child_count()

		for i in range(chip_count):
			var chip = chip_scene.instantiate()
			marker.add_child(chip)

			var stack_index = existing_chips + i

			chip.position = Vector3(
				randf_range(-0.01, 0.01),
				stack_index * 0.04,
				randf_range(-0.01, 0.01)
			)
func clear_bets():

	for marker in bet_positions.get_children():

		for child in marker.get_children():
			child.queue_free()
