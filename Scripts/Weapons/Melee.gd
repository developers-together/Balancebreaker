extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	WeaponScenes.MeleeCooldown = 1
	WeaponScenes.MeleeLastShot = 1

func Attack():
	if WeaponScenes.MeleeLastShot > WeaponScenes.MeleeCooldown:
		WeaponScenes.MeleeLastShot = 0
		animation_player.play("new_animation")
		
		

func _process(delta: float) -> void:
	if Input.is_action_pressed("fire"):
		Attack()
