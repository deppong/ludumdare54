extends CanvasLayer

var menu

var pause = false
# Called when the node enters the scene tree for the first time.
func _ready():
	menu = load("res://objects/MainMenu.tscn")
	process_mode = Node.PROCESS_MODE_ALWAYS

func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		if(pause): resumeGame()
		else: PauseGame()

func _on_resume_pressed():
	resumeGame()
	
func resumeGame():
	print("pressed resume")
	pause = false
	get_tree().paused = false
	hide()

func _on_title_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_packed(menu)

func _on_quit_pressed():
	queue_free()
	get_tree().quit()

func PauseGame():
	if(get_parent().get_node("Player").health<=0): return
	pause = true
	show()
	get_tree().paused = true
	
