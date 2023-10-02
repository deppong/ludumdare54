extends Control
var value:int = 2
@export var boxes:Array[NinePatchRect]
@onready var recharge: Timer = get_parent().get_node("Player/AmmoCharge")
@onready var player = get_parent().get_node("Player")
var numBoxes = 0
var box = preload("res://objects/ammoBox.tscn")

func _ready():
	for i in range(player.ammoMax - numBoxes):
		addBox()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(recharge):
		$VBoxContainer/ProgressBar.set_value_no_signal(pow((1-recharge.time_left/recharge.wait_time),1.5))
	var i = 0
	if(boxes.size()>0):
		for b in boxes:
			if(i>=value):
				b.modulate = Color(0,0,0,0)
			else:
				b.modulate = Color(1,1,1,1)
			i+=1
	
func set_value(amount):
	value=amount

func addBox():
	print("addedBox")
	numBoxes += 1
	var thisBox = box.instantiate()
	$VBoxContainer/HBoxContainer.add_child(thisBox)
	boxes.append(thisBox)
	
