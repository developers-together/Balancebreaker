extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var parent_animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"

@onready var weapon_socket: Node2D = $"../Marker2D/WeaponSocket"



func _ready():
	
	if name != GameData.Player:
		queue_free()
		return
		
	print("RX-42 says hi")
	
	WeaponScenes.PlayerInv[0]= preload("res://Scenes/Weapons/Ranged.tscn")
	WeaponScenes.PlayerInv[1]= preload("res://Scenes/Weapons/Melee.tscn")
	
	WeaponScenes.PlayerDefaultInv[0]= preload("res://Scenes/Weapons/Ranged.tscn")
	WeaponScenes.PlayerDefaultInv[1]= preload("res://Scenes/Weapons/Melee.tscn")
