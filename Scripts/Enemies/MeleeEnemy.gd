extends CharacterBody2D


@export var speed := 50.0
@onready var marker_2d: Marker2D = $Marker2D

var Player = null

var Weapon = preload("res://Scenes/Weapons/Sword.tscn")

const SPEED = 50.0

var WeaponInstance
var PlayerDirection:Vector2 

var CoolDown = 0.5
var LastShot = 0.5

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

		# Simple separation force
		var separation = Vector2.ZERO
		for other in get_tree().get_nodes_in_group("enemies"):
			if other != self:
				var diff = global_position - other.global_position
				var dist = diff.length()
				if dist < 32: # Adjust spacing here
					separation += diff.normalized() / dist

		var final_direction = direction + separation.normalized()
		final_direction = final_direction.normalized()

		# Move if not too close
		if distance > 25:
			velocity = final_direction * speed
		else:
			velocity = Vector2.ZERO

		marker_2d.rotation = to_player.angle()

		# Attack logic
		LastShot += delta
		if LastShot > CoolDown and distance <= 50:
			WeaponInstance.Attack()
			LastShot = 0

		move_and_slide()
