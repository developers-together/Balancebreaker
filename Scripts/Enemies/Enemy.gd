extends CharacterBody2D

@export var speed := 50.0
@onready var marker_2d: Marker2D = $Marker2D

var player = null

var Weapon = preload("res://Scenes/Weapons/EMPistol.tscn")

var CoolDown = 0.5
var LastShot = 0.5

var WeaponInstance
var PlayerDirection:Vector2 

func _ready() -> void:
	player = GameData.PlayerNode
	WeaponInstance = Weapon.instantiate()
	marker_2d.add_child(WeaponInstance)
	PlayerDirection = player.global_position

func _physics_process(delta):
	if player:
		var direction = (player.global_position - global_position).normalized()
		LastShot += delta
		velocity = direction * speed
		PlayerDirection = player.position - position
		marker_2d.rotation = PlayerDirection.angle()
		if LastShot > CoolDown:
			WeaponInstance.fire(600,0,player.global_position)
			LastShot = 0
		move_and_slide()
