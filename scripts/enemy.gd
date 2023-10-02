extends CharacterBody2D

@onready var player = get_player()
@onready var center_pos = get_parent().get_node("BackgroundPlayArea").position

var d = 0.0
@export var radius = randf_range(400.0, 1000)
@export var speed = randf_range(0.5, 1.0)

signal enemy_died(score)

var beam = preload("res://objects/enemy_beam.tscn")
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

func _process(delta):
	d+= delta
	
	position = Vector2 (sin(d * speed) * radius, cos(d * speed) * radius) + center_pos

func fire(direction: Vector2):
	var beamInst = beam.instantiate()
	beamInst.position = position
	beamInst.rotation = get_angle_to(direction)
	get_parent().add_child(beamInst)

func _on_attack_timer_timeout():
	fire(player.position)

func radar_ping():
	var pingInst = ping.instantiate()
	pingInst.position = position
	get_parent().add_child(pingInst)
	

func enemy_take_damage():
	# ENEMY DIED :(
	var part:GPUParticles2D = particle.instantiate()
	get_parent().add_child(part)
	part.position = position
	part.emitting = true
	enemy_died.emit(2)
	queue_free()
