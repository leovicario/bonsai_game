# Hotbar.gd
extends HBoxContainer

var slots_data: Array[Tool] = [null, null, null, null]
var active_index: int = 0

@onready var slot_nodes = $HotbarSlots.get_children()

func _ready():
	# preload your tools
	slots_data[0] = preload("res://tools/watering_can.tres")
	slots_data[1] = preload("res://tools/scissors.tres")
	refresh_ui()

func _input(event):
	if event.is_action_pressed("ui_1"): set_active(0)
	if event.is_action_pressed("ui_2"): set_active(1)
	if event.is_action_pressed("ui_3"): set_active(2)
	if event.is_action_pressed("ui_4"): set_active(3)
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			set_active((active_index - 1 + 4) % 4)
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			set_active((active_index + 1) % 4)

func set_active(index: int):
	active_index = index
	refresh_ui()
	# tell the player what tool is now active
	get_parent().get_node("Player").active_tool = slots_data[active_index]

func refresh_ui():
	for i in slot_nodes.size():
		slot_nodes[i].set_tool(slots_data[i])
		slot_nodes[i].set_active(i == active_index)
