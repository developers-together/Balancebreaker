extends CharacterBody2D

@export var speed = 400

@onready var game_manager: Node = %GameManager

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var weapon_socket: Node2D = $WeaponSocket

const OFFSET = 16

func GetInput():
	
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	if input_direction.x == -1:
		
		animated_sprite_2d.flip_h= true
		
		weapon_socket.position.x = -1 * (OFFSET + 8)
		
	if input_direction.x == 1:
		
		animated_sprite_2d.flip_h= false
		
		weapon_socket.position.x = OFFSET - 10
	
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
	

	
