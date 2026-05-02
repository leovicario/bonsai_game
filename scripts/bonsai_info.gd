extends Control

var player_in_range: bool = false

@onready var bonsaiInfo = $"../../UI/BonsaiInfo"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func showUI():
	# Assume body is the player
	if Input.is_action_just_pressed("pickup"):
		player_in_range = !player_in_range
		


func showInfo():
	bonsaiInfo.visible = player_in_range
	
	var bonsai_name = bonsaiInfo.get_node('Control/Panel/MarginContainer/FlowContainer/bonsai_name')
	#bonsai_name.text = str(bonsai.species)
	
	var bonsai_health = bonsaiInfo.get_node('Control/Panel/MarginContainer/FlowContainer/bonsai_health')
	#bonsai_health.text = "Health: " + str(bonsai.health)
	
	var bonsai_growth = bonsaiInfo.get_node('Control/Panel/MarginContainer/FlowContainer/bonsai_growth')
	#bonsai_growth.text = "Growth: " + str(bonsai.growth)
