extends CharacterBody2D

@export var speed : float = 100.0

@onready var interaction_area = $InteractionArea

var hasBonsai = false
var bonsai = null

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func animate():
	var animated_sprite = $Sprite2D
	if  Input.is_action_pressed("left") or Input.is_action_pressed("up") :
		animated_sprite.play("idle_side")
		animated_sprite.flip_h = false
		
	if Input.is_action_pressed("right") or Input.is_action_pressed("up"):
		animated_sprite.play("idle_side")
		animated_sprite.flip_h = true
		
	if Input.is_action_pressed("down") and Input.is_action_pressed("left"):
		animated_sprite.play("idle_down")
		animated_sprite.flip_h = false
		
	if Input.is_action_pressed("down"):
		animated_sprite.play("idle_down")
		animated_sprite.flip_h = false


func _physics_process(_delta):
	animate()
	pickupBonsai()
	get_input()
	move_and_slide()
	

func pickupBonsai():
	if Input.is_action_just_pressed("interact"):
		
		var areas = interaction_area.get_overlapping_areas()
		for area in areas:
			if area.name == "bonsaiArea":
				bonsai = area.get_parent().get_parent()
			
			if hasBonsai == false and bonsai:
				bonsai.pickup(self)
				hasBonsai = true
			elif hasBonsai == true and bonsai:
				bonsai.drop(self)
				var area_items = interaction_area.get_overlapping_areas()
				for area_item in area_items:
					if area_item.name == "shippingBoxArea":
						shipBonsai()
				hasBonsai = false

func shipBonsai():
	bonsai.queue_free()
	GameManager.update_money(2540)
	print("shipped!")
	hasBonsai = false
