extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	WeaponScenes.Cooldown = 1
	WeaponScenes.LastShot = 1

func Attack():
	if WeaponScenes.LastShot > WeaponScenes.Cooldown:
		WeaponScenes.LastShot = 0
		animation_player.play("new_animation")
		
		

func _process(delta: float) -> void:
	if Input.is_action_pressed("fire"):
		Attack()
