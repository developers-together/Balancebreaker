extends Control

@onready var game_manager: Node = %GameManager

var selected_character_scene: PackedScene

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_rx_42_pressed() -> void:
	
	selected_character_scene = preload("res://Scenes/PlayerRX42.tscn")
	get_tree().change_scene_to_file("../Game.tscn")
	


func _on_vx_09_pressed() -> void:
	
	selected_character_scene = preload("res://Scenes/PlayerVX09.tscn")
	get_tree().change_scene_to_file("../Game.tscn")
	

	
	
	
