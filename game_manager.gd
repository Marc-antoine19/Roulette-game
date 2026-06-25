extends Node

var money = 100000
var current_bets = {}

@onready var money_label = get_tree().get_first_node_in_group("money_label")

func update_ui():
	if money_label:
		money_label.text = "$" + str(money)

func spend_money(amount):
	money -= amount
	update_ui()
