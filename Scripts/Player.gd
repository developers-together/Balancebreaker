extends CharacterBody2D

@export var speed = 150

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var weapon_socket: Node2D = $Marker2D/WeaponSocket

@export var radius: float = 10  # Distance from player to weapon

const OFFSET = 16

var idle_time := 0.0
const THINK_TRIGGER_TIME := 10.0

#signal shoot(bullet, direction, location)
var is_thinking := false

var player_id: String = ""

func GetInput(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

	if input_direction != Vector2.ZERO:
		# Reset idle logic
		idle_time = 0.0
		is_thinking = false
		
		# Movement animations
		if input_direction.y > 0:
			animated_sprite_2d.play(player_id+"MoveDown")
		elif input_direction.y < 0:
			animated_sprite_2d.play(player_id+"MoveUp")
		elif input_direction.x != 0:
			animated_sprite_2d.play(player_id+"MoveRight")
	else:
		# Player is idle
		if not is_thinking:
			idle_time += delta

			if idle_time >= THINK_TRIGGER_TIME:
				animated_sprite_2d.play(player_id+"Think")
				is_thinking = true
			else:
				animated_sprite_2d.play(player_id)  # Regular idle

	# Handle flipping and weapon socket
	if input_direction.x == -1:
		animated_sprite_2d.flip_h = true
		weapon_socket.position.x = -OFFSET
	elif input_direction.x == 1:
		animated_sprite_2d.flip_h = false
		weapon_socket.position.x = OFFSET - 10

func _ready() -> void:
	if GameData.Player=="RX42":
		player_id = "RX42"
	elif GameData.Player=="VX09":
		player_id = "VX09"

	
func _physics_process(_delta):
	GetInput(_delta)
	move_and_slide()
	

func _process(_delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	var mouse_direction = (mouse_pos - global_position).normalized()

	weapon_socket.look_at(mouse_pos)
	weapon_socket.rotation = mouse_direction.angle()

	# Flip weapon sprite
	if weapon_socket.get_child_count() > 0:
		var current_weapon = weapon_socket.get_child(0)
		if current_weapon is Node2D:
			current_weapon.scale.y = -1 if mouse_pos.x < global_position.x else 1

	# Keep weapon positioned on the correct side of the player
	var x_offset = 15
	var y_offset = 0
	if mouse_pos.x < global_position.x:
		x_offset *= -1
	weapon_socket.position = Vector2(x_offset, y_offset)

	# Weapon switching
	if Input.is_action_just_pressed("ranged"):
		weapon_socket.ChangeWeapon(0)
	if Input.is_action_just_pressed("melee"):
		weapon_socket.ChangeWeapon(1)
	if Input.is_action_just_pressed("consumable"):
		weapon_socket.ChangeWeapon(2)
