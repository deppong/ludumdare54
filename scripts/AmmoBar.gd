extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$VBoxContainer/ProgressBar.set_value_no_signal(1-$Recharge.time_left/$Recharge.wait_time)
	
