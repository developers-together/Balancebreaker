extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var CoolDown = 1
@export var Damage: int
@export var EM: bool

@export var weapon_name: String = ""
var player_ref

func _ready() -> void:
	WeaponScenes.MeleeCooldown = CoolDown
	WeaponScenes.MeleeLastShot = CoolDown
	
	# Auto-assign weapon name if not set
	if weapon_name.is_empty():
		weapon_name = scene_file_path.get_file().get_basename()

func Attack():
	if WeaponScenes.MeleeLastShot > WeaponScenes.MeleeCooldown:
		WeaponScenes.MeleeLastShot = 0
		animation_player.play("new_animation")
		# Optionally play player's melee anim
		if player_ref:
			player_ref.idle_time = 0.0
			player_ref.is_thinking = false
			player_ref.is_fire = true

func _process(delta: float) -> void:
	if Input.is_action_pressed("fire"):
		Attack()
