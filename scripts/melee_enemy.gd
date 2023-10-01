extends CharacterBody2D

@onready var player = get_player()
@onready var center_pos = get_parent().get_node("BackgroundPlayArea").position

var d = 0.0
var radius := randf_range(350.0, 1300)
var speed := randf_range(0.5, 1.0)

signal enemy_died(score)

# var beam = preload("res://objects/enemy_beam.tscn")
var ping = preload("res://objects/ping.tscn")
var particle = preload("res://objects/enemy_explode.tscn")

# Helper script in case the player is completely missing from the scene
func get_player():
	var nodes = get_tree().get_nodes_in_group("player")
	if len(nodes) > 0:
		return nodes[0]
	null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	velocity = (player.position - position).normalized() * 100
	move_and_slide()

func fire(direction: Vector2):
	pass

func radar_ping():
	pass
	

func enemy_take_damage():
	# ENEMY DIED :(
	var part:GPUParticles2D = particle.instantiate()
	get_parent().add_child(part)
	part.position = position
	part.emitting = true
	enemy_died.emit(2)
	queue_free()
