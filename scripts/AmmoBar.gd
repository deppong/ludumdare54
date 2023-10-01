extends Control
var value:int
@export var boxes:Array[NinePatchRect]
@export var recharge:Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(recharge!=null):
		$VBoxContainer/ProgressBar.set_value_no_signal(1-recharge.time_left/recharge.wait_time)
	var i = 0
	for b in boxes:
		if(i>value):
			b.modulate = Color(0,0,0,0)
		else:
			b.modulate = Color(1,1,1,1)
		i+=1
	
func set_value(amount):
	value=amount
