extends Node2D

@export var laserSFX:Array[AudioStreamWAV]
# Called when the node enters the scene tree for the first time.
func _ready():
	var anim: AnimationPlayer = $Area2D/AnimationPlayer
	anim.play("mortar_blast_flicker")

func deal_damage():
	if($Area2D.has_overlapping_bodies()):
		var bodies = $Area2D.get_overlapping_bodies() #node2d array
		for body in bodies:
			if(body.has_method("player_take_damage")):
				print_debug("killed enemy")
				body.player_take_damage()
				
	$SFX.set_stream(laserSFX[randi() % laserSFX.size()])
	$SFX.play()
	$Explode.play()
	$Explode.reparent(get_parent())
	$SFX.reparent(get_parent())
	
