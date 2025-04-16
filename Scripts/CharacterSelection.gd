extends Node2D




func _on_rx_42_pressed() -> void:
	GameData.PlayerPath= "res://Scenes/PlayerRX42.tscn"
	
	get_tree().change_scene_to_file("res://Game.tscn")



func _on_vx_09_pressed() -> void:
	GameData.PlayerPath= "res://Scenes/PlayerVX09.tscn"
	
	get_tree().change_scene_to_file("res://Game.tscn")
