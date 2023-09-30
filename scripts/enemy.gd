extends CharacterBody2D

@export var min = -10
@export var max = 10

@onready var player = get_player()

var beam = preload("res://objects/enemy_beam.tscn")

# Helper script in case the player is completely missing from the scene
func get_player():
	var nodes = get_tree().get_nodes_in_group("player")
	if len(nodes) > 0:
		return nodes[0]
	push_error("The player is missing...")

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(randf_range(min, max), randf_range(min, max))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	move_and_slide()

func fire(direction: Vector2):
	var beamInst = beam.instantiate()
	#beamInst.position = position
	beamInst.rotation = get_angle_to(direction)
	add_child(beamInst)

func _on_attack_timer_timeout():
	fire(player.position)

