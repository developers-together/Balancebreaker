extends CharacterBody2D

@export var speed = 400

@onready var game_manager: Node = %GameManager

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func GetInput():
	
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
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
	

	
