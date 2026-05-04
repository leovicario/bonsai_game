extends Control

@onready var watering_can = preload("res://tools/watering_can.tres")
@onready var scissors = preload("res://tools/scissors.tres")

var slots : Array = [watering_can, scissors, null, null]
var active_slot : int = 0

@onready var hotbar = get_tree().current_scene.get_node("UI/hotbar")
@onready var hotbar1 = get_tree().current_scene.get_node("UI/hotbar/HBoxContainer/hotbar1")
@onready var hotbar2 = get_tree().current_scene.get_node("UI/hotbar/HBoxContainer/hotbar2")
@onready var hotbar3 = get_tree().current_scene.get_node("UI/hotbar/HBoxContainer/hotbar3")
@onready var hotbar4 = get_tree().current_scene.get_node("UI/hotbar/HBoxContainer/hotbar4")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	loadInventory()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	activeSlot()
	waterCan()

func loadInventory():
	print(hotbar)
	hotbar1.get_child(0).texture = watering_can.icon
	hotbar2.get_child(0).texture = scissors.icon

func activeSlot():
	if Input.is_action_just_pressed("1"):
		active_slot = 0
		print("watering can selected")
	elif Input.is_action_just_pressed("2"):
		active_slot = 1
		print("scissors selected")
		
	if active_slot == 0:
			hotbar1.scale = Vector2(1.1,1.1)
	else: hotbar1.scale = Vector2(1,1)
	
	if active_slot == 1:
			hotbar2.scale = Vector2(1.1,1.1)
	else: hotbar2.scale = Vector2(1,1)

func waterCan():
	if active_slot == 0 and Input.is_action_just_pressed("interact"):
		print("watered!")
