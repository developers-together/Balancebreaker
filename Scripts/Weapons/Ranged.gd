extends Node2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var weapon_name: String 
@export var Damage = 10
@export var FireRate = 0.1
@export var EM: bool
@export var NumberOfBullets: int
@export var BulletSpeed: int = 600
@export var ammo:int = 3
@export var heat:int = 30
@export var cooldowntime:int = 2
@export var energyuse:int = 10
@export var EnergyRecovery:int = 10
var player_ref
var cooldown = 0
var Bullet = preload("res://Scenes/Fire/Bullets.tscn")
var CurrentAmmo = ammo
var CurrentHeat = heat

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
	#print("fired")
	
	
#func reload():
	#print("Reloading...")
	#sprite.play(weapon_name + "Reload")  # Optional reload animation
	#await get_tree().create_timer(cooldowntime).timeout
	#CurrentAmmo = ammo
	#print("Reloaded")
#
#func _physics_process(delta: float) -> void:
	#CurrentHeat = delta * EnergyRecovery
	#if Input.is_action_pressed("fire"):
		#if WeaponScenes.LastShot < WeaponScenes.Cooldown:
			#WeaponScenes.LastShot += delta
			#return
		#
		#if EM:
			#if heat != 0:
				#heat -= energyuse
				#fire(BulletSpeed)
		#if !EM:
			#if CurrentAmmo != 0:
				#CurrentAmmo -= 1
				#fire(BulletSpeed)
	#if Input.is_action_just_pressed("reload") and CurrentAmmo < ammo:
		#reload()
	#print(CurrentAmmo)
		#
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("reload") and CurrentAmmo < ammo:
		reload()
	
	if CurrentHeat < heat:
		CurrentHeat += EnergyRecovery * delta

	if Input.is_action_pressed("fire") and !is_reloading:
		if WeaponScenes.LastShot < WeaponScenes.Cooldown:
			WeaponScenes.LastShot += delta
			return

		if EM:
			if CurrentHeat >= energyuse:
				CurrentHeat -= energyuse
				fire(BulletSpeed)
		else:
			if CurrentAmmo > 0:
				CurrentAmmo -= 1
				print("Ammo after shot: ", CurrentAmmo)
				fire(BulletSpeed)
			else:
				print("No ammo!")
				
var is_reloading = false

func reload():
	if is_reloading:
		return
	is_reloading = true
	sprite.play(weapon_name + "Reload")
	await get_tree().create_timer(cooldowntime).timeout
	CurrentAmmo = ammo
	is_reloading = false
	print("Reloaded! Ammo: ", CurrentAmmo)
	
