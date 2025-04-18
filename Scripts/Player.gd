extends CharacterBody2D

@export var speed = 150

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var weapon_socket: Node2D = $Marker2D/WeaponSocket

@export var radius: float = 10  # Distance from player to weapon

@onready var rx_42: Node = $RX42
@onready var vx_09: Node = $VX09

const OFFSET = 16

#signal shoot(bullet, direction, location)

func GetInput():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

	if input_direction != Vector2.ZERO:
		if input_direction.y > 0:
			animated_sprite_2d.play("VX09MoveDown")
		elif input_direction.y < 0:
			animated_sprite_2d.play("VX09MoveUP")
		elif input_direction.x < 0:
			animated_sprite_2d.play("VX09MoveLeft")
		elif input_direction.x > 0:
			animated_sprite_2d.play("VX09MoveRight")
	else:
		animated_sprite_2d.stop()  # Stop animation when not moving

	# Handle flipping and weapon socket positioning
	if input_direction.x == -1:
		animated_sprite_2d.flip_h = false  # Left
		weapon_socket.position.x = -OFFSET
	elif input_direction.x == 1:
		animated_sprite_2d.flip_h = false  # Right
		weapon_socket.position.x = OFFSET - 10

func _ready() -> void:
	
	if GameData.Player=="RX42":
		rx_42.Ready()
		
	elif GameData.Player=="VX09":
		vx_09.Ready()
	
func _physics_process(_delta):
	
	GetInput()
	move_and_slide()
	
	#if game_manager.GetCharacter() == "VX-09":
		#animated_sprite_2d.play("VX-09")
		#
	#elif game_manager.GetCharacter() == "RX-42":
		#
		#animated_sprite_2d.play("RX-42")
	
#func _ready() -> void:
	#
		#game_manager.UseVX09()

#func _process(_delta: float) -> void:
	#weapon_socket.look_at(get_global_mouse_position())
	#if Input.is_action_pressed("fire"):
		#var Bullets = Bullet.instantiate()
		#weapon_socket.add_child(Bullets)

func _process(_delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	var mouseDirection = (mouse_pos - global_position).normalized()
	var weapon_pos = mouseDirection * radius
	weapon_socket.look_at(mouse_pos)
	weapon_socket.rotation = mouseDirection.angle()
	weapon_socket.position = weapon_pos
	if Input.is_action_pressed("fire"):
		weapon_socket.ranged.fire()
	
	#if Input.is_action_just_pressed("fire"):
		#var bullet_instance = Bullet.instantiate()
		#bullet_instance.global_position = weapon_socket.global_position
		#var direction = (get_global_mouse_position() - weapon_socket.global_position).normalized()
		#bullet_instance.velocity = direction * 600
		#bullet_instance.rotation = direction.angle()
		##weapon_socket.add_child(bullet_instance)
		#get_tree().current_scene.add_child(bullet_instance)

#func _input(event):
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#shoot.emit(Bullet, weapon_socket.rotation, weapon_socket.position)
