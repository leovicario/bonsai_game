extends Node2D

class_name BonsaiController

@onready var bonsaiInfo = $"../../UI/BonsaiInfo"

@onready var bonsai_sprite: Sprite2D = $StaticBody2D/Sprite2D

var player_in_range: bool = false

@export var ficus_bonsai: bonsaiData = preload("res://bonsai/ficusBonsai.tres")


func awewe():
	# Assume body is the player
	if Input.is_action_just_pressed("click"):
		player_in_range = !player_in_range
		showInfo()
		
func showInfo():
	bonsaiInfo.visible = player_in_range
	
	var bonsai_name = bonsaiInfo.get_node('Control/Panel/MarginContainer/FlowContainer/bonsai_name')
	bonsai_name.text = str(ficus_bonsai.species)
	
	var bonsai_health = bonsaiInfo.get_node('Control/Panel/MarginContainer/FlowContainer/bonsai_health')
	bonsai_health.text = "Health: " + str(ficus_bonsai.health)
	
	var bonsai_growth = bonsaiInfo.get_node('Control/Panel/MarginContainer/FlowContainer/bonsai_growth')
	bonsai_growth.text = "Growth: " + str(ficus_bonsai.growth)

func _ready():
	print(ficus_bonsai.health)
	

func grow():
	if Input.is_action_just_pressed("interact"):
		if ficus_bonsai.growth < 100:
			ficus_bonsai.growth = ficus_bonsai.growth + 10
		print(ficus_bonsai.growth)


func changeStage():
	bonsai_sprite.region_enabled = true
	if ficus_bonsai.growth < 50:
		ficus_bonsai.stage = ficus_bonsai.Stage.SEEDLING
		bonsai_sprite.region_rect = Rect2(0, 0, 16, 16)
	elif ficus_bonsai.growth >= 50 and ficus_bonsai.growth < 100:
		ficus_bonsai.stage = ficus_bonsai.Stage.YOUNG
		bonsai_sprite.region_rect = Rect2(16, 0, 16, 16)
	elif ficus_bonsai.growth == 100:
		ficus_bonsai.stage = ficus_bonsai.Stage.MATURE
		bonsai_sprite.region_rect = Rect2(32, 0, 16, 16)

func pickup(player):
	var collision: CollisionShape2D = $StaticBody2D/CollisionShape2D
	collision.set_deferred("disabled", true)
	reparent(player.get_node("HoldPoint"))
	position = Vector2.ZERO
	
func drop(player):
	var collision: CollisionShape2D = $StaticBody2D/CollisionShape2D
	var old_position := global_position
	reparent(player.get_parent())
	position = old_position + Vector2(0,-8)
	collision.set_deferred("disabled", false)

func _process(_delta):
	# call the resource methods every frame
	awewe()
	showInfo()
	grow()
	changeStage()
