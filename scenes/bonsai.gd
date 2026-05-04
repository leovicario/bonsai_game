extends Node2D

class_name BonsaiController

@onready var bonsai_sprite: Sprite2D = $StaticBody2D/Sprite2D 

@export var bonsai: bonsaiData = preload("res://bonsai/ficusBonsai.tres").duplicate()

func _process(_delta):
	changeStage()

func _ready():
	pass


func grow(player):
	if player and Inventory.active_slot == 0 and Input.is_action_just_pressed("interact"):
		if self.bonsai.growth < 100:
			self.bonsai.growth = self.bonsai.growth + 10
	elif player and Inventory.active_slot == 1 and Input.is_action_just_pressed("interact"):
		if self.bonsai.growth > 0:
			self.bonsai.growth = self.bonsai.growth -10


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
