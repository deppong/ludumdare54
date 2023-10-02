extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var anim: AnimationPlayer = $Area2D/AnimationPlayer
	anim.play("player_beam_fadeOut")
	$NinePatchRect/CPUParticles2D.emitting = true

func _process(_delta):
	pass

func shoot_beam():
	if($Area2D.has_overlapping_bodies()):
		var bodies = $Area2D.get_overlapping_bodies() #node2d array
		for body in bodies:
			if(body.has_method("enemy_take_damage")):
				print_debug("killed enemy")
				body.enemy_take_damage()
