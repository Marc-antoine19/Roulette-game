extends Node

var money = 100000
var current_bet = 0

@onready var game = get_node("/root/Main/GameManager")
@onready var money_label = get_tree().get_first_node_in_group("money_label")

func update_ui():
	if money_label:
		money_label.text = "$" + str(money)
		
func place_bet(amount):
	if amount <= 0:
		return false

	if amount > money:
		return false

	current_bet = amount
	update_ui()
	return true
	
func spend_bet():
	money -= current_bet
	current_bet = 0
	update_ui()
