extends Node2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var weapon_name: String 
@export var Damage = 10
@export var FireRate = 0.1
@export var EM: bool
@export var NumberOfBullets: int
@export var BulletSpeed: int = 600
var player_ref

var Bullet = preload("res://Scenes/Fire/Bullets.tscn")

func _ready() -> void:
	WeaponScenes.Cooldown = 0.5
	WeaponScenes.LastShot = 0.5
	weapon_name = sprite.animation
	

func fire(speed = 600, addeddirection = 0, target_position = get_parent().get_global_mouse_position()) -> void:
	WeaponScenes.LastShot = 0

	var global_position = get_parent().global_position
	
	var bullet_instance = Bullet.instantiate()
	bullet_instance.global_position = global_position

	var direction = (target_position - global_position).normalized().rotated(addeddirection)
	bullet_instance.velocity = direction * speed
	bullet_instance.rotation = direction.angle()

	get_tree().current_scene.add_child(bullet_instance)

	WeaponScenes.Projectiles.append({
		"projectile": bullet_instance,
		"velocity": bullet_instance.velocity,
		"ticks": 0
	})

	var sprite = $AnimatedSprite2D
	var fire_anim = weapon_name + "Fire"
	print(fire_anim)
	# Play fire animation
	sprite.play(fire_anim)
	# Wait for the duration of the fire animation using a timer
	await get_tree().create_timer(0.15).timeout
	sprite.play(weapon_name)

	if player_ref:
		player_ref.idle_time = 0.0
		player_ref.is_thinking = false
		player_ref.is_fire = true
	print("fired")


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("fire"):
		if WeaponScenes.LastShot < WeaponScenes.Cooldown:
			WeaponScenes.LastShot += delta
			return
		fire(BulletSpeed)
