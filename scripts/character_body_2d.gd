extends CharacterBody2D

@export var speed = 100

@onready var interaction_area = $InteractionArea

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
	interact()
	get_input()
	move_and_slide()
	

func interact():
	if Input.is_action_just_pressed("interact"):
		var target_areas = interaction_area.get_overlapping_areas()
		if target_areas.size() > 0:
			print(target_areas[0].name)
