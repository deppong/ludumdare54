extends Control

@onready var recharge: Timer = get_parent().get_node("Player/RadarCharge")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(recharge):
		$ProgressBar.set_value_no_signal(pow((recharge.time_left/recharge.wait_time),1.5))
