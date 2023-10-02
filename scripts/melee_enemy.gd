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

var sploding = false

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
	#if (sploding): return
	velocity = (player.position - position).normalized() * 100
	if (player.position - position).length()<500:
		velocity*=3
	if (player.position - position).length()<300:
		if !$AudioStreamPlayer2D.playing:
			$AudioStreamPlayer2D.play()
	if (player.position - position).length()<250:
		$Sprite2D.visible = true
		velocity*=1.3
	move_and_slide()

func _on_explosion_delay_timeout():
	if($damage.has_overlapping_bodies()):
		var overlap = $damage.get_overlapping_bodies() #node2d array
		for item in overlap:
			if(item.has_method("player_take_damage")):
				item.player_take_damage()
	var part:GPUParticles2D = particle.instantiate()
	get_parent().add_child(part)
	part.position = position
	part.emitting = true
	ReparentParticles()
	queue_free()


func enemy_take_damage():
	# ENEMY DIED :(
	var part:GPUParticles2D = particle.instantiate()
	get_parent().add_child(part)
	part.position = position
	part.emitting = true
	enemy_died.emit(2)
	ReparentParticles()
	queue_free()

func ReparentParticles():
	var particles = $TrailParticles
	particles.emitting = false
	$TrailParticles/Timer.start()
	remove_child(particles)
	get_parent().add_child(particles)
	

func _on_player_detection_body_entered(body):
	if (body.is_in_group("player")):
		sploding = true
		$explosion_delay.start()

func radar_ping():
	pass

