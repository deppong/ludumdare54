extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
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
