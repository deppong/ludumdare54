extends Sprite2D

var startingPos: Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	startingPos = position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(get_global_mouse_position())
	if(get_global_mouse_position().x<get_parent().position.x):
		scale.y=-1
	else:
		scale.y=1
	if(get_global_mouse_position().y<get_parent().position.y):
		z_index=0
	else:
		z_index=1
	var dir = (get_global_mouse_position() - global_position).normalized()
	var dot = dir.dot(Vector2(0,1))
	if dot > 0:
		var offset = Vector2(17,-35)
		if (get_global_mouse_position().x>get_parent().position.x):
			offset *= Vector2(-1,1)
		position = startingPos + (offset * dot)
	else:
		position = startingPos
