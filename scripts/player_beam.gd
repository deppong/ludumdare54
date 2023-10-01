extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var anim: AnimationPlayer = $Area2D/AnimationPlayer
	anim.play("player_beam_fadeOut")

func _process(_delta):
	if($Area2D.has_overlapping_bodies()):
		var overlap = $Area2D.get_overlapping_bodies() #node2d array
		for item in overlap:
			if(item.has_method("enemy_take_damage")):
				item.enemy_take_damage()
	pass
