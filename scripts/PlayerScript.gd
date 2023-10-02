extends CharacterBody2D

@export var speed: float
@export var accel: float = .1
@export var deccel: float = .2
@export var initalSpd: float = .2
@export var health: float = 2
@export var ammoMax: int = 2

var gameOver = false
var ammo:int = 2

var pinging: bool = false
var can_ping = true

signal health_changed(health_val)
signal ammo_changed(ammo_val)
signal start_cooldown()

var beam = preload("res://objects/player_beam.tscn")
var hurt = preload("res://objects/player_hurt_particle.tscn")

var vel: Vector2
var lastDir: Vector2

var healRate:float = 0

func _process(delta):
	heal()
	
func movement():
	# player can't process movement code if pinging
	
	
	var dir = Input.get_vector("MoveLeft","MoveRight","MoveUp","MoveDown") 
	dir = dir.normalized()
	if(pinging or gameOver):
		dir = Vector2(0,0)
	updateAnims(get_global_mouse_position()-position,dir.length()>0)
	if(dir.x != 0):
		if(abs(vel.x)<0.1):
			vel.x = dir.x * initalSpd
		vel.x = lerp(vel.x,dir.x,accel )
	else:
		vel.x = lerp(vel.x,0.0,deccel )
	
	if(dir.y != 0):
		if(abs(vel.y)<0.1):
			vel.y = dir.y * initalSpd
		vel.y = lerp(vel.y,dir.y,accel )
	else:
		vel.y = lerp(vel.y,0.0,deccel )
	velocity = vel * speed
	
	move_and_slide()

func actions():
	
	if(gameOver):
		pinging = false
		$RadarCharge.stop()
		$RadarCoolDown.stop()
		return
	
	if (!pinging):
		if (Input.is_action_just_pressed("Fire")&&ammo>0):
			var beamInst:Node2D = beam.instantiate()
			get_parent().add_child(beamInst)
			beamInst.global_position = $GUN/Muzzle.global_position
			var target = (get_global_mouse_position() - $GUN/Muzzle.global_position).normalized()
			beamInst.rotation = target.angle() 
			ammo-=1
			$AmmoCharge.start()
			ammo_changed.emit(ammo)
			$Gun.play()
	
	if (Input.is_action_just_pressed("Radar") && can_ping):
		$RadarCharge.start()
		pinging = true
	if (Input.is_action_just_released("Radar")):
		$RadarCharge.stop()
		pinging = false

func radar():
	var enemies = get_tree().get_nodes_in_group("enemy")
	
	for enemy in enemies:
		if enemy.has_method("radar_ping"):
			enemy.radar_ping()
	$TwoPing.start()
	$RadarCoolDown.start()
	start_cooldown.emit()
	can_ping = false
	$"Ping A".play()

func radar2():
	var enemies = get_tree().get_nodes_in_group("enemy")
	$"Ping B".play()
	for enemy in enemies:
		if enemy.has_method("radar_ping"):
			enemy.radar_ping()

func reload():
	if ammo<ammoMax:
		ammo+=1
		ammo_changed.emit(ammo)
	if ammo<ammoMax:
		$AmmoCharge.start()
	
func _physics_process(delta):
	actions()
	movement()
	
func player_take_damage():
	if(health<=0):
		return
	health-=1
	healRate=0
	health_changed.emit(health)
	var hurtParticle = hurt.instantiate()
	hurtParticle.global_position = global_position + Vector2(0,-80)
	hurtParticle.emitting = true
	get_parent().add_child(hurtParticle)
	
	if (health <= 0):
		print_debug("Game is over dude")
		dead()
#update animations for moving in each direction
#TODO: replace with real code
func updateAnims(dir,walking):
	if(!walking):
		if(abs(dir.x)>abs(dir.y)):
			if(dir.x>0): $AnimatedSprite2D.play("Rstand")
			else: $AnimatedSprite2D.play("Lstand")
		else:
			if(dir.y<0): $AnimatedSprite2D.play("Ustand")
			else: $AnimatedSprite2D.play("Dstand")
	else:
		if (abs(dir.x)>abs(dir.y)): #horiz
			#$AnimatedSprite2D.play("Run Right")
			if(dir.x>0): $AnimatedSprite2D.play("Rwalk")
			else: $AnimatedSprite2D.play("Lwalk")
		else: #vert
			if(dir.y<0): $AnimatedSprite2D.play("Uwalk")
			else: $AnimatedSprite2D.play("Dwalk")
	
func heal():
	if health >0.01 && health <2:
		health+=healRate
		healRate+=0.000001
		health_changed.emit(health)
	elif health >2:
		health = min(health,2)
		healRate = 0
func dead():
	var fadeout = get_parent().get_node("EndParticle/FadeoutBg")
	fadeout.show()
	get_parent().get_node("EndParticle").emitting = true
	var anim: AnimationPlayer = fadeout.get_node("FadeAnim")
	anim.play("end_fade_out")
	gameOver = true
	get_parent().get_node("Healthbar").hide()
	get_parent().get_node("AmmoBar").hide()
	get_parent().get_node("ping_bar").hide()
	hide()

func showGameOverMenu():
	
	get_parent().get_node("GameOverPanel").show()
	get_parent().get_node("GameOverPanel/GameOverParticle").emitting = true


func _on_radar_cool_down_timeout():
	can_ping = true
