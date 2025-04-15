extends CharacterBody2D


@export var speed := 200.0
@export var acceleration := 800.0
@export var friction := 600.0

var input_direction := Vector2.ZERO
	
func _physics_process(delta):
	
	get_input()
	move_player(delta)
	
	
func get_input():
	input_direction = Vector2.ZERO
	if Input.is_action_pressed("up"):
		input_direction.y -= 1
	if Input.is_action_pressed("down"):
		input_direction.y += 1
	if Input.is_action_pressed("left"):
		input_direction.x -= 1
	if Input.is_action_pressed("right"):
		input_direction.x += 1
	input_direction = input_direction.normalized()

func move_player(delta):
	if input_direction != Vector2.ZERO:
		velocity = velocity.move_toward(input_direction * speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	move_and_slide()
