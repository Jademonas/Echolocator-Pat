extends Control

@onready var palLabel = $VBoxContainer/Palette

@onready var musicBusId = AudioServer.get_bus_index("Music")
@onready var sfxBusId = AudioServer.get_bus_index("SFX")

# Palettes
var palIndex = 0
var palNames = ["Original", "Hi-Contrast", "Little Boy", "Chocolate", "Aqua", "Bubblegum", "White Mode"]

var user_prefs: UserPreferences

# --------------------------------------------------- #

func _ready():
	user_prefs = UserPreferences.load_or_create()
	$VBoxContainer/musicVolume.value = user_prefs.music_volume
	$VBoxContainer/sfxVolume.value = user_prefs.sfx_volume
	if user_prefs.palette:
		palIndex = user_prefs.palette
		palLabel.text = palNames[palIndex]
		self.material.shader = null
		self.material.shader = user_prefs.get_palette()

# --------------------------------------------------- #

func _on_music_volume_value_changed(value):
	AudioServer.set_bus_volume_db(musicBusId, linear_to_db(value))
	AudioServer.set_bus_mute(musicBusId, value < 0.05)
	if user_prefs:
		user_prefs.music_volume = value 
		user_prefs.save()

# --------------------------------------------------- #

func _on_sfx_volume_value_changed(value):
	AudioServer.set_bus_volume_db(sfxBusId, linear_to_db(value))
	AudioServer.set_bus_mute(sfxBusId, value < 0.05)
	if user_prefs:
		user_prefs.sfx_volume = value 
		user_prefs.save()
	
# --------------------------------------------------- #

func _on_palette_button_down():
	Music.button_press_soft()
	palIndex += 1
	if palIndex >= len(palNames):
		palIndex = 0
	if user_prefs.can_palette(palIndex):
		palLabel.text = palNames[palIndex]
		user_prefs.palette = palIndex
		user_prefs.save()
		self.material.shader = null # Resets the pallete just in case
		self.material.shader = user_prefs.get_palette()
	else:
		palLabel.text = "! LOCKED " + str(palIndex) + " !"

# --------------------------------------------------- #

func _on_back_button_down():
	Music.button_press_confirm()
	SceneTranstition.change_scene_to_file("res://scenes/main_menu.tscn")
