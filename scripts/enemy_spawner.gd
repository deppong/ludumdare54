extends Node

# TODO change to static res:// path
var enemy_tscn = preload("res://objects/enemy.tscn")
var mortar_enemy_tcsn = preload("res://objects/mortar_enemy.tscn")
@export var melee_enemy_tcsn: PackedScene

enum enemy_types {BEAM, MORTAR, MELEE}

# numbers
var score = 0
var enemy_count = 0

# Flags
var can_spawn_mortar: bool = false
var can_spawn_melee: bool = false
var enemy_cap = 5

func _ready():
	$spawn_timer.wait_time = 8.0

func _process(_delta):
	# Connect the enemies death signal to the function that increases our total score
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		if (enemy.has_signal("enemy_died") && !enemy.is_connected("enemy_died", increase_score)):
			enemy.enemy_died.connect(increase_score)
	
	enemy_count = len(enemies)
	
	if 0 <= score && score < 10:
		$spawn_timer.wait_time = 5.0
	elif 10 <= score && score < 20:
		can_spawn_mortar = true
	elif 20 <= score && score < 30:
		enemy_cap = 10
	elif 30 <= score && score < 40:
		pass

func increase_score(reward):
	score+=reward
	

func spawn_enemy(type):
	var enemy
	match type:
		enemy_types.MORTAR:
			enemy = mortar_enemy_tcsn.instantiate()
			print_debug("instantiate mortar enemy")
		enemy_types.MELEE:
			pass
		_:
			enemy = enemy_tscn.instantiate()
	get_parent().add_child(enemy)

func _on_spawn_timer_timeout():
	if enemy_count >= enemy_cap:
		return
	
	
	var types_to_spawn = [enemy_types.BEAM, enemy_types.BEAM]
	if can_spawn_melee: 
		types_to_spawn.append(enemy_types.MELEE)
	if can_spawn_mortar:
		types_to_spawn.append(enemy_types.MORTAR)
	
	spawn_enemy(types_to_spawn[randi() % len(types_to_spawn)])
