extends Node2D

class_name BonsaiController

@onready var bonsai_sprite: Sprite2D = $StaticBody2D/Sprite2D

@export var bonsai: bonsaiData = preload("res://bonsai/ficusBonsai.tres")

func _process(_delta):
	# call the resource methods every frame
	grow()
	changeStage()

func _ready():
	print(bonsai.health)
	

func grow():
	if Input.is_action_just_pressed("pickup"):
		if bonsai.growth < 100:
			bonsai.growth = bonsai.growth + 10


func changeStage():
	bonsai_sprite.region_enabled = true
	if bonsai.growth < 50:
		bonsai.stage = bonsai.Stage.SEEDLING
		bonsai_sprite.region_rect = Rect2(0, 0, 16, 16)
	elif bonsai.growth >= 50 and bonsai.growth < 100:
		bonsai.stage = bonsai.Stage.YOUNG
		bonsai_sprite.region_rect = Rect2(16, 0, 16, 16)
	elif bonsai.growth == 100:
		bonsai.stage = bonsai.Stage.MATURE
		bonsai_sprite.region_rect = Rect2(32, 0, 16, 16)

func pickup(player):
	var collision: CollisionShape2D = $StaticBody2D/CollisionShape2D
	collision.set_deferred("disabled", true)
	reparent(player.get_node("HoldPoint"))
	position = Vector2.ZERO
	
func drop(player):
	var collision: CollisionShape2D = $StaticBody2D/CollisionShape2D
	var old_position = player.position
	reparent(player.get_parent())
	position = old_position + Vector2(0,-20)
	collision.set_deferred("disabled", false)
