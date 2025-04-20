extends Node2D

func _on_rx_42_pressed() -> void:
	
	GameData.Player='RX42'
	
	get_tree().change_scene_to_file("res://Game.tscn")



func _on_vx_09_pressed() -> void:
	GameData.Player = 'VX09'
	get_tree().change_scene_to_file("res://Game.tscn")
	
#("res://Game.tscn")
#("res://Scenes/Rooms/Random Dungeon.tscn")
