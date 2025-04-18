extends Area2D
func body_entered(body):
	print("hi")
	if body.name == "Player":
		get_tree().change_scene_to_file("res://scenes/Game.tscn")
