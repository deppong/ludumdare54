extends Control
var value: int =3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$VBoxContainer/ProgressBar.set_value_no_signal(value)
	
func change_value(amount):
	value = value + amount
	
func set_value(amount):
	value = amount
	
func get_value():
	return value
	
