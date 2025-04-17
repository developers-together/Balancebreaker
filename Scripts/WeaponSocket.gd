extends Node2D

@export var radius: float = 10  # Distance from player to weapon
var Bullet = preload('res://Scenes/Bullets.tscn')
# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#func fire():
	#global_position = position
	##var mouse_pos = get_global_mouse_position()
	##var mouseDirection = (mouse_pos - global_position).normalized()
	##var weapon_pos = mouseDirection * radius
	###look_at(get_global_mouse_position())
	##rotation = mouseDirection.angle()
	##position = weapon_pos
	#if Input.is_action_just_pressed("fire"):
		#var bullet_instance = Bullet.instantiate()
		#bullet_instance.global_position = global_position
		#var direction = (get_global_mouse_position() - global_position).normalized()
		#bullet_instance.velocity = direction * 600
		#bullet_instance.rotation = direction.angle()
		#get_tree().current_scene.add_child(bullet_instance)
		
func fire():
	var bullet_instance = Bullet.instantiate()
	bullet_instance.global_position = global_position
	var direction = (get_global_mouse_position() - global_position).normalized()
	bullet_instance.velocity = direction * 600
	bullet_instance.rotation = direction.angle()
	get_tree().current_scene.add_child(bullet_instance)
