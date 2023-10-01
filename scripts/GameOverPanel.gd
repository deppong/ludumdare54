extends PanelContainer

var gameScene = preload("res://objects/main.tscn")
var mainMenu = preload("res://objects/MainMenu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_menu_pressed():
	get_tree().change_scene_to_packed(mainMenu)
	pass # Replace with function body.


func _on_restart_pressed():
	get_tree().change_scene_to_packed(gameScene)
	pass # Replace with function body.


func _on_exit_pressed():
	queue_free()
	get_tree().quit()
	pass # Replace with function body.
