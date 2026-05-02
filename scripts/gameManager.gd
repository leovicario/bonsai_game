extends Node

signal updateMoney(amount)

var money : int = 0
var amount = 0

@onready var bonsai = preload("res://scenes/bonsai.tscn")

func update_money(amount: int) -> void:
	amount = amount
	print (amount)
	updateMoney.emit(amount)

func _process(delta: float) -> void:
	spawnBonsai()

func spawnBonsai():
	if Input.is_action_just_pressed("click"):
		bonsai = preload("res://scenes/bonsai.tscn")
		var newBonsai = bonsai.instantiate()
		var current_scene = get_tree().current_scene
		var player = current_scene.find_child("player", true, false)
		var garden = current_scene.find_child("Garden", true, false)
		print(player.position)
		garden.add_child(newBonsai)
		newBonsai.global_position = player.global_position
		print(garden)
