extends Control

var user_prefs: UserPreferences
var paused
var time_elapsed: float = 0.0

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

func _ready():
	Engine.time_scale = 1
	$TextureRect.hide()
	$VBoxContainer.hide()
	paused = false
	
	user_prefs = UserPreferences.load_or_create()
	if user_prefs.palette:
		self.material.shader = user_prefs.get_palette()
	
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if not paused:
			Engine.time_scale = 0
			$TextureRect.show()
			$VBoxContainer.show()
			paused = true
		else:
			Engine.time_scale = 1
			$TextureRect.hide()
			$VBoxContainer.hide()
			paused = false
			
	if not paused:
		time_elapsed += delta

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

func _on_resume_pressed():
	Engine.time_scale = 1
	$TextureRect.hide()
	$VBoxContainer.hide()
	paused = false
	Music.button_press_soft()

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

func _on_main_menu_pressed():
	Music.button_press_confirm()
	Engine.time_scale = 1
	$TextureRect.hide()
	$VBoxContainer.hide()
	if user_prefs.speedrunTimer:
		user_prefs.speedrunTimer += time_elapsed
	SceneTranstition.change_scene_to_file("res://scenes/main_menu.tscn")
