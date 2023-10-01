extends AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	speed_scale+=0.05
	

func _destroy():
	queue_free()
