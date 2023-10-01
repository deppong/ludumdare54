extends PanelContainer

var mainMenu = load("res://objects/MainMenu.tscn")

func _on_menu_pressed():
	get_tree().change_scene_to_packed(mainMenu)


func _on_restart_pressed():
	get_tree().reload_current_scene() 

func _on_exit_pressed():
	queue_free()
	get_tree().quit()
	pass # Replace with function body.
