extends Node2D


func _ready() -> void:
	var weapon = WeaponScenes.PlayerInv[0].instantiate()
	add_child(weapon)


func ChangeWeapon(i):
	if WeaponScenes.PlayerInv[i]:
		for Child in get_children():
			remove_child(Child)
			Child.queue_free()
		var NewWeapon = WeaponScenes.PlayerInv[i].instantiate()
		add_child(NewWeapon)
