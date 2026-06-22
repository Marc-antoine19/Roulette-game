extends CanvasLayer

@onready var bet_panel = $BetPanel
@onready var bet_input = $BetPanel/VBoxContainer/LineEdit
@onready var game = get_node("/root/Main/GameManager")

func _ready():
	add_to_group("bet_ui")

func open_bet_menu():
	bet_panel.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func close_bet_menu():
	bet_panel.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func confirm_bet():
	var amount = int(bet_input.text)

	if game.place_bet(amount):
		print("Bet accepted:", amount)
		close_bet_menu()
	else:
		print("Invalid bet")


func _on_button_pressed() -> void:
	confirm_bet
	
func confirm_bet1():
	print("CONFIRM BUTTON PRESSED")
