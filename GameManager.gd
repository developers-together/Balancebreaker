extends Node


@onready var player_rx_42: CharacterBody2D = $"../PlayerRX42"


@onready var player_vx_09: CharacterBody2D = $"../PlayerVX09"

@onready var Bullet = preload('res://Scenes/Bullets.tscn')

var selected_character: PackedScene = null

func _ready() -> void:
	#var PlayerCharacterPath = GameData.PlayerPath
	#
	#var PlayerNode = load(PlayerCharacterPath).instantiate()
	#
	#add_child(PlayerNode)
	
	if GameData.Player == 'RX42':
		player_vx_09.queue_free()
	elif GameData.Player == 'VX09':
		player_rx_42.queue_free()
		
