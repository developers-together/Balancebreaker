extends Node2D

func _ready():
	
	if name != GameData.Player:
		queue_free()
		return
	
	print("VX-09 says hi")
	
	WeaponScenes.PlayerInv[0]= preload("res://Scenes/Weapons/Ranged.tscn")
	WeaponScenes.PlayerInv[1]= preload("res://Scenes/Weapons/Melee.tscn")
	
	WeaponScenes.PlayerDefaultInv[0]= preload("res://Scenes/Weapons/Ranged.tscn")
	WeaponScenes.PlayerDefaultInv[1]= preload("res://Scenes/Weapons/Melee.tscn")
