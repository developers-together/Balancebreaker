extends Node

#WeaponScenes.Cooldown = 0.5

func _ready() -> void:
	WeaponScenes.Cooldown = 0.5
	WeaponScenes.LastShot = 0.5
	

var Bullet = preload('res://Scenes/Fire/Bullets.tscn')

func fire():
	

	if WeaponScenes.LastShot < WeaponScenes.Cooldown: return
	
	WeaponScenes.LastShot = 0
	var global_position = get_parent().global_position
	var MousePosition = get_parent().get_global_mouse_position()
	var bullet_instance = Bullet.instantiate()
	bullet_instance.global_position = global_position
	var direction = (MousePosition - global_position).normalized()
	bullet_instance.velocity = direction * 600
	bullet_instance.rotation = direction.angle()
	get_tree().current_scene.add_child(bullet_instance)
	
	
	
	WeaponScenes.Projectiles.append({
		"projectile": bullet_instance,
		"velocity": bullet_instance.velocity,
		"ticks": 0
	})

func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("fire"):
		fire()
