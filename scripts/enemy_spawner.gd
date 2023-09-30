extends Node

@export var enemy_tscn: PackedScene
var enemy_count


func _on_spawn_timer_timeout():
	var enemy = enemy_tscn.instantiate()
	var spawn_location = $spawn_path/spawn_point
	spawn_location.progress_ratio = randf()
	
	var direction = (spawn_location.rotation + PI /2)
	
	enemy.position = spawn_location.position
	
	get_parent().add_child(enemy)
	
