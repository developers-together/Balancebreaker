extends Node2D

@export var Damage = 10

@export var FireRate = 0.1

signal shoot(bullet, direction, location)

var Bullets = preload('res://Scenes/Bullets.tscn')

func _physics_process(delta):
	look_at(get_global_mouse_position())
	
func _process(_delta: float) -> void:
	if Input.is_action_pressed("fire"):
		var Bullet = Bullets.instantiate()
		add_child(Bullet)
