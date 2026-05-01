extends CharacterBody2D

@export var speed = 100

@onready var interaction_area = $InteractionArea

var hasBonsai = false

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
	dropBonsai()
	get_input()
	move_and_slide()
	

func pickupBonsai():
	if Input.is_action_just_pressed("pickup"):
		var target = interaction_area.get_overlapping_areas()
		if target.size() > 0:
			var bonsai = target[0].get_parent().get_parent()
			print(bonsai.name)
			bonsai.pickup(self)
			hasBonsai = true

func dropBonsai():
	if Input.is_action_just_pressed("interact") and hasBonsai == true:
		var target = interaction_area.get_overlapping_areas()
		if target.size() > 0:
			var bonsai = target[0].get_parent().get_parent()
			print(bonsai.name)
			bonsai.drop(self)
		print('dropping bonsai')
		hasBonsai = false
