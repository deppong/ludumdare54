extends CharacterBody2D

@export var speed: float
@export var accel: float = .1
@export var deccel: float = .2
@export var initalSpd: float = .2

var vel: Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	

func _physics_process(delta):
	var dir = Input.get_vector("MoveLeft","MoveRight","MoveUp","MoveDown") 
	dir = dir.normalized()
	if(dir.x != 0):
		if(abs(vel.x)<0.1):
			vel.x = dir.x * initalSpd
		vel.x = lerp(vel.x,dir.x,accel )
	else:
		vel.x = lerp(vel.x,0.0,deccel )
	
	if(dir.y != 0):
		if(abs(vel.y)<0.1):
			vel.y = dir.y * initalSpd
		vel.y = lerp(vel.y,dir.y,accel )
	else:
		vel.y = lerp(vel.y,0.0,deccel )
	velocity = vel * speed
	move_and_slide()
