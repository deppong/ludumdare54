extends Node

# TODO change to static res:// path
@export var enemy_tscn: PackedScene
@export var mortar_enemy_tcsn: PackedScene
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
		if (!enemy.is_connected("enemy_died", increase_score)):
			enemy.enemy_died.connect(increase_score)
	
	enemy_count = len(enemies)
	
	

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
	if can_spawn_melee:
		pass
	if can_spawn_mortar:
		pass
	
	spawn_enemy(enemy_types.BEAM)
