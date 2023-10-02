extends Node

# TODO change to static res:// path
var enemy_tscn = preload("res://objects/enemy.tscn")
var mortar_enemy_tcsn = preload("res://objects/mortar_enemy.tscn")
var melee_enemy_tcsn = preload("res://objects/melee_enemy.tscn")

var scoreDisplay: RichTextLabel

enum enemy_types {BEAM, MORTAR, MELEE}

# numbers
var score = 0
var enemy_count = 0
var multiplier = 0

# Flags
var can_spawn_mortar: bool = false
var can_spawn_melee: bool = false
var enemy_cap = 5

func _ready():
	$spawn_timer.wait_time = 8.0
	scoreDisplay = get_parent().get_node("ScoreCanvas/ScoreLabel")
	scoreDisplay.text = "[center]"+ format_score(str(0))

func _process(_delta):
	# Connect the enemies death signal to the function that increases our total score
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		if (enemy.has_signal("enemy_died") && !enemy.is_connected("enemy_died", increase_score)):
			enemy.enemy_died.connect(increase_score)
	
	enemy_count = len(enemies)
	
	if score in range(0, 5):
		enemy_cap = 1
	elif score in range(5, 20):
		enemy_cap = 2
		$spawn_timer.wait_time = 5.0
	elif score in range(20, 30):
		enemy_cap = 3
		can_spawn_mortar = true
	elif score in range(30, 40):
		enemy_cap = 4
		can_spawn_melee = true
		$spawn_timer.wait_time = 4.5
	elif score in range(40, 50):
		enemy_cap = 5
		can_spawn_melee = true
		$spawn_timer.wait_time = 4
	elif score >60:
		$spawn_timer.wait_time = 3.5
		enemy_cap = 6+score/40
		
	if score>=5 && !$AudioStreamPlayer.playing:
		$AudioStreamPlayer.play()

func increase_score(reward):
	score+=reward #*(1+multiplier)
	#multiplier+=0.2
	print_debug(score)
	scoreDisplay.text = "[center]"+ format_score(str(score*100))
	
func format_score(sc : String) -> String:
	var i: int = sc.length() - 3
	while i > 0:
		sc = sc.insert(i, ",")
		i = i - 3
	return sc

func spawn_enemy(type):
	var enemy
	match type:
		enemy_types.MORTAR:
			enemy = mortar_enemy_tcsn.instantiate()
			$spawn_path/spawn_point.progress_ratio = randf()
			enemy.position = $spawn_path/spawn_point.position
			print_debug("instantiate mortar enemy")
		enemy_types.MELEE:
			enemy = melee_enemy_tcsn.instantiate()
			$spawn_path/spawn_point.progress_ratio = randf()
			enemy.position = $spawn_path/spawn_point.position
		_:
			enemy = enemy_tscn.instantiate()
			if (randi_range(0, 1) == 1):
				enemy.speed *= -1
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
	#spawn_enemy(enemy_types.MELEE)


func _on_player_health_changed(health_val):
	multiplier = 0
