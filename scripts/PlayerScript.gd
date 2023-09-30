extends CharacterBody2D

@export var speed: float
@export var accel: float = .1
@export var deccel: float = .2
@export var initalSpd: float = .2

var beam = preload("res://objects/player_beam.tscn")

var vel: Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func movement():
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

func actions():
	if(Input.is_action_just_pressed("Fire")):
		var beamInst:Node2D = beam.instantiate()
		get_parent().add_child(beamInst)
		beamInst.position = position
		beamInst.rotation = get_angle_to(get_global_mouse_position())
	pass

func _physics_process(delta):
	actions()
	movement()
	
func player_take_damage():
	print_debug("Player hit")
