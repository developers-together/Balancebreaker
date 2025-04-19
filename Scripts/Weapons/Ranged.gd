extends Node2D

@export var Damage = 10

@export var FireRate = 0.1

@export var EM:bool

@export var NumberOfBullets:int

@export var BulletSpeed:int = 600

#WeaponScenes.Cooldown = 0.5

func _ready() -> void:
	WeaponScenes.Cooldown = 0.5
	WeaponScenes.LastShot = 0.5
	

var Bullet = preload('res://Scenes/Fire/Bullets.tscn')

func fire(speed = 600, addeddirection = 0):
	
	WeaponScenes.LastShot = 0
	var global_position = get_parent().global_position
	var MousePosition = get_parent().get_global_mouse_position()
	var bullet_instance = Bullet.instantiate()
	bullet_instance.global_position = global_position
	var direction = (MousePosition - global_position).normalized()
	direction = direction.rotated(addeddirection)
	bullet_instance.velocity = direction * speed
	bullet_instance.rotation = direction.angle()
	get_tree().current_scene.add_child(bullet_instance)
	
	print("fired")
	
	WeaponScenes.Projectiles.append({
		"projectile": bullet_instance,
		"velocity": bullet_instance.velocity,
		"ticks": 0
	})

func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("fire"):
		if WeaponScenes.LastShot < WeaponScenes.Cooldown: return
		fire(BulletSpeed)
