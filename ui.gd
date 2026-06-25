extends CanvasLayer

@onready var bet_panel = $BetPanel

@onready var game = get_node("/root/Main/GameManager")
var selected_chip = 100
var bets = {}
var total_bet = 0

func _ready():
	add_to_group("bet_ui")

func open_bet_menu():
	bet_panel.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func close_bet_menu():
	bet_panel.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func update_bet_label():
	var text = ""

	for number in bets:
		text += str(number) + ": $" + str(bets[number]) + "\n"

	text += "\nTotal: $" + str(total_bet)

	$BetPanel/TotalBetLabel.text = text

func place_number_bet(number):

	if bets.has(number):
		bets[number] += selected_chip
	else:
		bets[number] = selected_chip

	total_bet += selected_chip

	update_bet_label()
	
func place_special_bet(type):
	if bets.has(type):
		bets[type] += selected_chip
	else:
		bets[type] = selected_chip

	total_bet += selected_chip
	update_bet_label()
func _on_button_1_pressed():
	place_number_bet(1)
func _on_button_2_pressed():
	place_number_bet(2)
func _on_button_36_pressed() -> void:
	place_number_bet(36)
func _on_button_35_pressed() -> void:
	place_number_bet(35)
func _on_button_34_pressed() -> void:
	place_number_bet(34)
func _on_button_33_pressed() -> void:
	place_number_bet(33)
func _on_button_32_pressed() -> void:
	place_number_bet(32)
func _on_button_31_pressed() -> void:
	place_number_bet(31)
func _on_button_30_pressed() -> void:
	place_number_bet(30)
func _on_button_29_pressed() -> void:
	place_number_bet(29)
func _on_button_28_pressed() -> void:
	place_number_bet(28)
func _on_button_27_pressed() -> void:
	place_number_bet(27)
func _on_button_26_pressed() -> void:
	place_number_bet(26)
func _on_button_25_pressed() -> void:
	place_number_bet(25)
func _on_button_24_pressed() -> void:
	place_number_bet(24)
func _on_button_23_pressed() -> void:
	place_number_bet(23)
func _on_button_22_pressed() -> void:
	place_number_bet(22)
func _on_button_21_pressed() -> void:
	place_number_bet(21)
func _on_button_20_pressed() -> void:
	place_number_bet(20)
func _on_button_19_pressed() -> void:
	place_number_bet(19)
func _on_button_18_pressed() -> void:
	place_number_bet(18)
func _on_button_17_pressed() -> void:
	place_number_bet(17)
func _on_button_16_pressed() -> void:
	place_number_bet(16)
func _on_button_15_pressed() -> void:
	place_number_bet(15)
func _on_button_14_pressed() -> void:
	place_number_bet(14)
func _on_button_13_pressed() -> void:
	place_number_bet(13)
func _on_button_12_pressed() -> void:
	place_number_bet(12)
func _on_button_11_pressed() -> void:
	place_number_bet(11)
func _on_button_10_pressed() -> void:
	place_number_bet(10)
func _on_button_9_pressed() -> void:
	place_number_bet(9)
func _on_button_8_pressed() -> void:
	place_number_bet(8)
func _on_button_7_pressed() -> void:
	place_number_bet(7)
func _on_button_6_pressed() -> void:
	place_number_bet(6)
func _on_button_3_pressed() -> void:
	place_number_bet(3)
func _on_button_4_pressed() -> void:
	place_number_bet(4)
func _on_button_5_pressed() -> void:
	place_number_bet(5)

func _on_chip_100_button_pressed() -> void:
	selected_chip = 100

func _on_chip_500_button_pressed() -> void:
	selected_chip = 500

func _on_chip_1000_button_pressed() -> void:
	selected_chip = 1000

func _on_confirm_button_pressed():

	if total_bet <= 0:
		return

	if total_bet > game.money:
		print("Not enough money.")
		return

	game.money -= total_bet
	game.current_bets = bets.duplicate()

	game.update_ui()

	close_bet_menu()

func _on_cancel_button_pressed():
	bets.clear()
	total_bet = 0
	$BetPanel/TotalBetLabel.text = "No bet selected"
	close_bet_menu()

func _on_st_12_pressed() -> void:
	place_special_bet("1st on 12")

func _on_nd_12_pressed() -> void:
	place_special_bet("2nd on 12")

func _on_to_18_pressed() -> void:
	place_special_bet("1 to 18")

func _on_even_pressed() -> void:
	place_special_bet("EVEN")

func _on_red_pressed() -> void:
	place_special_bet("RED")

func _on_black_pressed() -> void:
	place_special_bet("BLACK")

func _on_odd_pressed() -> void:
	place_special_bet("ODD")

func _on_to_36_pressed() -> void:
	place_special_bet("19 to 36")

func _on_rd_12_pressed() -> void:
	place_special_bet("3rd on 12")

func _on_to_1_pressed() -> void:
	place_special_bet("2 to 1")

func _on__pressed() -> void:
	place_number_bet(0)
