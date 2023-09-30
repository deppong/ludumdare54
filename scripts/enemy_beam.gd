extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func attack():
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.has_method("fart"):
			pass
