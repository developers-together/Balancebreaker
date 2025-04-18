extends Node2D

@export var radius: float = 10  # Distance from player to weapon

@onready var ranged: Node = $Ranged

var Melee = preload("res://Scenes/Weapons/Melee.tscn")
		
