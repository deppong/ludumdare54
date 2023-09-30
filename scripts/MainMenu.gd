extends Control
var gameScene = preload("res://objects/main.tscn")

func StartGame():
	get_tree().change_scene_to_packed(gameScene)
	pass
	
func OpenHowTo():
	$Canvas/HowToPanel.show()
	
func CloseHowTo():
	$Canvas/HowToPanel.hide()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
