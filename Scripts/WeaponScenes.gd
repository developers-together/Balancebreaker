extends Node


var Projectiles = []

var PlayerInv = [null, null, null]

var PlayerDefaultInv = [null, null , null]

var Cooldown:float = 0.5

var LastShot :float 

func _physics_process(delta):
	
	LastShot += delta 
	for t in Projectiles:
		var p = t["projectile"]

		if t["ticks"] >= 40:
			p.queue_free()
			Projectiles.erase(t)
			pass

		t["ticks"] += delta
