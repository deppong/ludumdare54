extends Control

@onready var recharge: Timer = get_parent().get_node("Player/RadarCharge")
@onready var cooldown: Timer = get_parent().get_node("Player/RadarCoolDown")
@onready var player = get_parent().get_node("Player")

var on_cd = false

func _ready():
	player.connect("start_cooldown", ping_on_cooldown)
	cooldown.connect("timeout", cooldown_off)
	pass

# This could possibly be the worst code I have written. And not
# only that I think I spent like, 45 minutes getting it to work...
# remember that game jams are meant to have games that are made to work
# and not be expanded upon. This code doesn't need to be flexible so it isn't
# this code doesn't need to be flexible so it isn't. This code doesn't need to be flexible so it isn't
# this code doesn't need to be flexible so it isn't. This code doesn't need to be flexible so it isn't
# this code doesn't need to be flexible so it isn't.
func _process(delta):
	if(recharge == null): return
	
	if (on_cd):
		ping_on_cooldown()
	else:
		if (recharge.time_left == 0):
			$ProgressBar.set_value_no_signal(0)
		else:
			$ProgressBar.modulate = Color(1, 1, 1, 1)
			$ProgressBar.set_value_no_signal(pow((1-recharge.time_left/recharge.wait_time), 1.5))


func ping_on_cooldown():
	on_cd = true
	$ProgressBar.set_value_no_signal(pow(cooldown.time_left/cooldown.wait_time, 1.5))
	$ProgressBar.modulate = Color(1, 0, 0, 1)


func cooldown_off():
	$ProgressBar.set_value_no_signal(0)
	$ProgressBar.modulate = Color(1, 1, 1, 1)
	on_cd = false
