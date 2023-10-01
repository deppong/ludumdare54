extends Control
var value:int
@export var max:int
@export var boxes:Array[NinePatchRect]
# Called when the node enters the scene tree for the first time.
func _ready():
	value = max;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$VBoxContainer/ProgressBar.set_value_no_signal(1-$Recharge.time_left/$Recharge.wait_time)
	
	
func set_ammo(value):
	pass
