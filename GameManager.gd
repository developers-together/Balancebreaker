# GameManager.gd

extends Node

@onready var player: CharacterBody2D = $"../Player"

func _ready() -> void:
	GameData.PlayerNode = player
