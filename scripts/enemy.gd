extends CharacterBody2D

@export var min = -10
@export var max = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Vector2(randf_range(min, max), randf_range(min, max))
	
	move_and_slide()
