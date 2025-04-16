extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var PlayerCharacterPath = GameData.PlayerPath
	
	var PlayerNode = load(PlayerCharacterPath).instantiate()
	
	add_child(PlayerNode)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
