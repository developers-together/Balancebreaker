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
		PlayerDirection = Player.global_position
		var direction = (Player.global_position - global_position).normalized()
		LastShot += delta
		velocity = direction * speed
		PlayerDirection = Player.position - position
		marker_2d.rotation = PlayerDirection.angle()
		if LastShot > CoolDown:
			WeaponInstance.Attack()
			LastShot = 0
		move_and_slide()
