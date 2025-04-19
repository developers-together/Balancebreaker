extends CharacterBody2D


@export var speed := 50.0

var player = null

func _ready() -> void:
	player = GameData.PlayerNode

func _physics_process(delta):
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
