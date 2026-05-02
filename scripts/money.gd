extends Node

var money : int = 100
var amount = GameManager.amount

@onready var moneyLabel = get_node('Panel/Container/moneyLabel')

func _ready() -> void:
	GameManager.updateMoney.connect(update_money_label)
	update_money_label(amount)

func addMoney(amount: int) -> void:
	money += amount
	
func update_money_label(amount) -> void:
	addMoney(amount)
	if moneyLabel:
		moneyLabel.text = str(money)
