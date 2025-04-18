extends Node


var Projectiles = []

var PlayerInv = [null, null, null]

func _physics_process(delta):
	
	for t in Projectiles:
		var p = t["projectile"]

		if t["ticks"] >= 60:
			p.queue_free()
			Projectiles.erase(t)
			pass

		t["ticks"] += 1 
