extends "res://Scripts/Weapons/Ranged.gd"

@export var BulletSpacing:int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("fire"):
		if WeaponScenes.LastShot < WeaponScenes.Cooldown: return
		fire()
		fire(BulletSpeed, deg_to_rad(BulletSpacing))
		fire(BulletSpeed, deg_to_rad(-BulletSpacing))
