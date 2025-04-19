extends Node2D

func _ready():
	
	if name != GameData.Player:
		queue_free()
		return
		
	print("RX-42 says hi")
	
	WeaponScenes.PlayerInv[0]= preload("res://Scenes/Weapons/BallisticShotgun.tscn")
	WeaponScenes.PlayerInv[1]= preload("res://Scenes/Weapons/Warhammer.tscn")
	
	WeaponScenes.PlayerDefaultInv[0]= preload("res://Scenes/Weapons/BallisticShotgun.tscn")
	WeaponScenes.PlayerDefaultInv[1]= preload("res://Scenes/Weapons/Warhammer.tscn")
