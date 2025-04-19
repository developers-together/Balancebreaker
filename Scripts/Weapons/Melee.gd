extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var CoolDown = 1

@export var Damage:int

@export var EM:bool

func _ready() -> void:
	
	WeaponScenes.MeleeCooldown = CoolDown
	WeaponScenes.MeleeLastShot = CoolDown

func Attack():
	if WeaponScenes.MeleeLastShot > WeaponScenes.MeleeCooldown:
		WeaponScenes.MeleeLastShot = 0
		animation_player.play("new_animation")
		
		

func _process(delta: float) -> void:
	if Input.is_action_pressed("fire"):
		Attack()
