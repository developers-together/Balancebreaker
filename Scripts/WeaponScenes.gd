extends Node


var projectiles = []

func _physics_process(delta):
	
	for t in projectiles:
		var p = t["projectile"]

		if t["ticks"] >= 60:
			p.queue_free()
			projectiles.erase(t)
			pass

		t["ticks"] += 1 
