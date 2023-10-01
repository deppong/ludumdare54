extends Node

@export var enemy_tscn: PackedScene
var enemy_count = 0

func _process(_delta):
	$spawn_timer.wait_time = randf_range(1.0, 5.0)

func _on_spawn_timer_timeout():
	if (enemy_count < 5):
		var enemy = enemy_tscn.instantiate()
		var spawn_location = $spawn_path/spawn_point
		spawn_location.progress_ratio = randf()
		
		var direction = (spawn_location.rotation + PI /2)
		
		enemy.position = spawn_location.position
		
		get_parent().add_child(enemy)
		enemy_count+=1
		
