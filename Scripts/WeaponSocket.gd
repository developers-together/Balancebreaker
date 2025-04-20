extends Node2D

func _ready() -> void:
	var weapon_scene = WeaponScenes.PlayerInv[0]
	if weapon_scene:
		var weapon = weapon_scene.instantiate()
		weapon.weapon_name = weapon_scene.resource_path.get_file().get_basename()
		weapon.player_ref = get_parent().get_parent()
		add_child(weapon)

func ChangeWeapon(i):
	if WeaponScenes.PlayerInv[i]:
		# Remove current weapon
		for child in get_children():
			remove_child(child)
			child.queue_free()

		var new_weapon_scene = WeaponScenes.PlayerInv[i]
		var new_weapon = new_weapon_scene.instantiate()

		new_weapon.weapon_name = new_weapon_scene.resource_path.get_file().get_basename()
		new_weapon.player_ref = get_parent().get_parent()

		add_child(new_weapon)
