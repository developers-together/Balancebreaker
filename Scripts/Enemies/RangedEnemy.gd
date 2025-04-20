extends CharacterBody2D

@export var speed := 100.0
@onready var marker_2d: Marker2D = $Marker2D

var Player = null

var Weapon = preload("res://Scenes/Weapons/EMPistol.tscn")

var CoolDown = 0.5
var LastShot = 0.5

var WeaponInstance
var PlayerDirection:Vector2 

func _ready() -> void:
	Player = GameData.PlayerNode
	WeaponInstance = Weapon.instantiate()
	marker_2d.add_child(WeaponInstance)
	#PlayerDirection = player.global_position
		
func _physics_process(delta):
	if Player:
		var to_player = Player.global_position - global_position
		var distance = to_player.length()
		var direction = to_player.normalized()

		# Ranged spacing settings
		var min_range = 150  # too close: back up
		var max_range = 200  # too far: move closer

		# Movement logic to stay at comfortable range
		if distance < min_range:
			# Too close - move away
			velocity = -direction * speed
		elif distance > max_range:
			# Too far - move closer
			velocity = direction * speed
		else:
			# In range - hold position
			velocity = Vector2.ZERO

		move_and_slide()

		# Rotate weapon toward player
		PlayerDirection = to_player
		marker_2d.rotation = PlayerDirection.angle()

		# Fire when in range
		LastShot += delta
		if LastShot > CoolDown and distance <= max_range:
			WeaponInstance.fire(600, 0, Player.global_position)
			LastShot = 0
